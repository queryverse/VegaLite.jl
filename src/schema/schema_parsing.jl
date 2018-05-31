####################################################################
#  JSON schema parsing
####################################################################

using JSON

@compat abstract type SpecDef end

type ObjDef <: SpecDef
  desc::String
  props::Dict{String, SpecDef}
  addprops::SpecDef
  required::Set{String}
end

type NumberDef <: SpecDef
  desc::String
end
NumberDef(spec::Dict) = NumberDef(get(spec, "description", ""))

type IntDef <: SpecDef
  desc::String
end
IntDef(spec::Dict)    = IntDef(get(spec, "description", ""))

type StringDef <: SpecDef
  desc::String
  enum::Set{String}
end
StringDef(spec::Dict) =
  StringDef(get(spec, "description", ""),
            Set{String}(get(spec, "enum", String[])))

type BoolDef <: SpecDef
  desc::String
end
BoolDef(spec::Dict)   = BoolDef(get(spec, "description", ""))

type ArrayDef <: SpecDef
  desc::String
  items::SpecDef
end
ArrayDef(spec::Dict) =
  ArrayDef(get(spec, "description", ""), toDef(spec["items"]))

type UnionDef <: SpecDef
  desc::String
  items::Vector
end

type VoidDef <: SpecDef
  desc::String
end

type AnyDef <: SpecDef
  desc::String
end


function elemtype(typ::String)
  typ=="number"  && return NumberDef("")
  typ=="boolean" && return BoolDef("")
  typ=="integer" && return IntDef("")
  typ=="string"  && return StringDef("", Set{String}())
  typ=="null"    && return VoidDef("")
  error("unknown elementary type $typ")
end


###########  Schema parsing  ##############

function toDef(spec::Dict)
  if haskey(spec, "type")
    typ = spec["type"]

    if isa(typ, Vector)  # parse as UnionDef
      if length(spec["type"]) > 1
        return UnionDef(get(spec, "description", ""), elemtype.(spec["type"]))
      end
      typ = spec["type"][1]
    end

    if isa(typ, String)
      typ=="null"    && return VoidDef("")
      typ=="number"  && return NumberDef(spec)
      typ=="boolean" && return BoolDef(spec)
      typ=="integer" && return IntDef(spec)
      typ=="string"  && return StringDef(spec)
      typ=="array"   && return ArrayDef(spec)

      if typ == "object"
        ret = ObjDef(get(spec, "description", ""),
                     Dict{String, SpecDef}(),
                     VoidDef(""),
                     Set{String}(get(spec, "required", String[])))

        if haskey(spec, "properties")
          for (k,v) in spec["properties"]
            ret.props[k] = toDef(v)
          end
        end

        if haskey(spec, "required")
          ret.required = Set(spec["required"])
        end

        if haskey(spec, "additionalProperties") && isa(spec["additionalProperties"], Dict)
          ret.addprops = toDef(spec["additionalProperties"])
        end

        return ret
      end

      error("unknown type $typ")
    end

    error("type $typ is neither an array nor a string")

  elseif haskey(spec, "\$ref")
    rname = split(spec["\$ref"], "/")[3] # name of definition
    # if this ref has already been seen (it is in the 'refs' dict) fetch its
    # SpecDef. Otherwise create.
    if !haskey(refs, rname)
      # Some refs are auto-referential. We need to create a dummy def to avoid
      # infinite recursion.
      refs[rname] = VoidDef("")
      refs[rname] = toDef(schema["definitions"][rname])
      # reparse a second time to set correctly auto-referential children props
      temp = toDef(schema["definitions"][rname])
      # and update refs[rname]
      for field in fieldnames(refs[rname])
        setfield!(refs[rname], field, getfield(temp, field))
      end
    end
    return refs[rname]

  elseif haskey(spec, "anyOf")
    return UnionDef(get(spec, "description", ""),
                    toDef.(spec["anyOf"]))

  elseif length(spec) == 0
    return AnyDef("")

  else
    # warn("not a ref, 'AnyOf' and no type")
    return AnyDef("")
  end
end

fn = joinpath(@__DIR__, "../../deps/lib/", "vega-lite-schema.json")
schema = JSON.parsefile(fn)
# showall(keys(schema["definitions"]))
# schema["definitions"]["TopLevelProperties"]
# schema["definitions"]["TopLevelSpec"]
# collect(Iterators.filter(n -> startswith(n, "TopLevel"), keys(schema["definitions"])))

refs = Dict{String, SpecDef}()
rootSpec = toDef(schema["definitions"]["TopLevelSpec"])

# length(refs) # 124
# dl = rootSpec.items[2].props["layer"]
# dl2 = dl.items.items[1]
# dl2 === dl2.props["layer"].items.items[1] # true, OK
# Base.summarysize(rootSpec) # 203k
