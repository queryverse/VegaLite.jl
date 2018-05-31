###################################################################
#   function documentation
###################################################################

function prettydesc(desc::String)
  res = replace(desc, "\n", " ") # remove all CR because they break formatting
  res = replace(res, "__", "*")  # markdown italic compatibilty issue ?
  res
end

function prettytype(typ::SpecDef)
  isa(typ, IntDef) && return "Int"
  isa(typ, NumberDef) && return "Number"
  if isa(typ, StringDef)
    if length(typ.enum) > 0
      tstr = "one of " * join(collect(typ.enum),",")
    else
      tstr = "String/Symbol"
     end
    return tstr
  end
  isa(typ, BoolDef) && return "Bool"
  isa(typ, VoidDef) && return "Void"
  isa(typ, AnyDef) && return "Any"
  # warn("[prettytype] unmamanged type $(typeof(typ))")
  "???"
end

function mkdoc(spec::UnionDef, context::Symbol, indent)
  docstr = String[]

  # if all are simple types use a short format
  if all( !needsfunction(s) for s in spec.items )
    tstr = join(prettytype.(spec.items), ", ", " or ")
    push!(docstr, "($tstr) $(prettydesc(spec.desc))")

  else # case 1, case 2 format
    length(spec.items) == 1 && return mkdoc(spec.items[1], context, indent)

    spec.desc != "" && push!(docstr, prettydesc(spec.desc), "")
    push!(docstr, "One of : ")
    for (i,v) in enumerate(spec.items)
      isa(v, VoidDef) && continue
      fs = needsfunction(v) ? "`$context(<keyword args..>)`" : "`$context=...`"
      push!(docstr, "\n- **case #$(i)**") # "* $fs $(prettydesc(v.desc))")
      append!(docstr, mkdoc(v, Symbol(""), 2))
    end
  end
  repeat(" ", indent) .* docstr
end

function mkdoc(spec::ObjDef, context::Symbol, indent)
  docstr = String[]
  spec.desc != "" && push!(docstr, prettydesc(spec.desc), "")
  for (k,v) in spec.props
    sk = get(sp2jl, Symbol(k), Symbol(k))
    if haskey(funcs, jlfunc(sk))
      push!(docstr, "- `$sk` : $(prettydesc(v.desc)) *see help for `$(jlfunc(sk))()`*")
    else
      dstrs = mkdoc(v, sk, 2)
      dstrs[1] = "- `$sk` : " * dstrs[1]
      append!(docstr, dstrs)
    end
  end
  repeat(" ", indent) .* docstr
end

function _mkdoc(spec::SpecDef, indent)
  docstr = String[]
  push!(docstr, "($(prettytype(spec))) $(prettydesc(spec.desc))")
  repeat(" ", indent) .* docstr
end

mkdoc(spec::IntDef, context::Symbol, indent)    = _mkdoc(spec, indent)
mkdoc(spec::NumberDef, context::Symbol, indent) = _mkdoc(spec, indent)
mkdoc(spec::StringDef, context::Symbol, indent) = _mkdoc(spec, indent)
mkdoc(spec::BoolDef, context::Symbol, indent)   = _mkdoc(spec, indent)
mkdoc(spec::VoidDef, context::Symbol, indent)   = _mkdoc(spec, indent)
mkdoc(spec::AnyDef, context::Symbol, indent)    = _mkdoc(spec, indent)

function mkdoc(spec::ArrayDef, context::Symbol, indent)
  docstr = String[]
  tstr = prettytype(spec.items)
  push!(docstr, "(Array of $tstr) $(prettydesc(spec.desc))")
  repeat(" ", indent) .* docstr
end


########################################################

# lookup dict for finding of the function associated to spec
def2funcs = Dict{SpecDef,Any}()
for (k,v) in funcs
  for def in keys(v)
    def2funcs[def] = push!( get(def2funcs, def, []), k )
  end
end

flatten(s::SpecDef)  = [s]
flatten(s::UnionDef) = vcat(flatten.(s.items)...)

# sfn, dvs = :plot, funcs[:plot]
for (sfn, dvs) in funcs
  # organize defs of function by enclosing parent functions
  pfuncs = Dict{Symbol,Any}()
  for (def, pset) in dvs
    # skip array defs for special functions (arrayprops)
    Symbol(vlname(sfn)) in arrayprops &&
      isa(def, ArrayDef) && continue

    # unfold unions to find more factorizations of docs
    vdef = flatten(def)
    for pdef in pset
      pfns = get(def2funcs, pdef, [:unknown])
      for pfn in pfns
        for d in vdef
          # println(pfn)
          pfuncs[pfn] = push!(get(pfuncs, pfn, Set()), d)
        end
      end
    end
  end

  # gather docs by enclosing funcs having same defs
  docdict = Dict()
  for (pfn, defset) in pfuncs
    docdict[defset] = push!(get(docdict, defset, []), pfn)
  end

  # create doc string
  docstr = String[]
  for (defset, pfnset) in docdict
    header = "## `$sfn`"
    pfns = filter(f -> f != :unknown, collect(pfnset))
    if length(pfns) > 0
      flist = join("`" .* string.(pfns) .* "()`", ", ", " and ")
      header *= " in $flist"
    end
    push!(docstr, header)
    append!(docstr, mkdoc(UnionDef("", collect(defset)), sfn, 0))
    push!(docstr, "")
  end

  fulldoc = join(rstrip.(docstr), "\n")
  eval(:( @doc $fulldoc $sfn ))
end

# vllayer
# plot
# vlorder
# vlvalues
# vlcell
# vlequal
# vlx2
# vlaxis
# vlvconcat
