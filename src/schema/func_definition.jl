###################################################################
#   VegaLite public API definition
###################################################################

### list of VegaLite property names that need a new denomination in Julia
const sp2jl = Dict{Symbol,Symbol}(:type => :typ)
const jl2sp = Dict( (v,k) for (k,v) in sp2jl)

### conversion between property name in VegaLite and julia function name
jlfunc(vln::String) = jlfunc(Symbol(vln))
jlfunc(vln::Symbol) = Symbol("vl" * string(vln))
vlname(fn::Symbol)  = replace(string(fn), r"^vl", "")


### step 1 : build a dict linking SpecDefs to (possibly several) parent SpecDef
#             with their property name

lookinto!(s::SpecDef, parent::SpecDef, prop="*") =
  deftree[s] = [(prop, parent)]

function _addtodeftree(s::SpecDef, parent::SpecDef, prop::String)
  push!(alreadyseen, (s, parent))
  deftree[s] = push!(get(deftree, s, Tuple{String, SpecDef}[]), (prop, parent))
end

function lookinto!(s::ArrayDef, parent::SpecDef, prop="*")
  (s, parent) in alreadyseen && return
  _addtodeftree(s, parent, prop)
  isa(s.items, UnionDef) && lookinto!(s.items, parent, prop)
end

function lookinto!(s::ObjDef, parent::SpecDef, prop="*")
  (s, parent) in alreadyseen && return
  _addtodeftree(s, parent, prop)
  for (k,v) in s.props
    lookinto!(v, s, k)
  end
end

function lookinto!(s::UnionDef, parent::SpecDef, prop="*")
  (s, parent) in alreadyseen && return
  _addtodeftree(s, parent, prop)
  for v in s.items
    lookinto!(v, s)
  end
end

alreadyseen = []  # to avoid infinite recursion
deftree = Dict{SpecDef, Vector{Tuple{String, SpecDef}}}()
lookinto!(rootSpec, VoidDef(""), "plot")

# length(deftree) # 716
# extrema(length(v) for v in values(deftree)) # 1 to 9

### step 2 : identify functions to be created among all properties

needsfunction(s::IntDef)    = false
needsfunction(s::NumberDef) = false
needsfunction(s::BoolDef)   = false
needsfunction(s::StringDef) = false
needsfunction(s::VoidDef)   = false
needsfunction(s::AnyDef)    = false
needsfunction(s::ObjDef)    = true
needsfunction(s::UnionDef)  = any(needsfunction, s.items)
needsfunction(s::ArrayDef)  = needsfunction(s.items)
needsfunction(s::SpecDef)   = error("unknown type $(typeof(s))")

funcs = Dict{Symbol,Dict}()
for (def, ns) in deftree
  needsfunction(def) || continue

  if isa(def, UnionDef)  # remove non-object parts
    items   = filter(needsfunction, def.items)
    realdef = length(items)==1 ? items[1] : UnionDef("", items)
  else
    realdef = def
  end

  for (name, parentdef) in ns
    if name=="*" # if UnionDef look up one level
      nsp = deftree[parentdef]
      nns = unique(collect(v[1] for v in nsp))
      # (length(nsp) > 1) && warn("which name ? $(join(nns, "," ))")
      sfn        = Symbol(nsp[1][1])
      realparent = nsp[1][2]
    else
      sfn = Symbol(name)
      realparent = parentdef
    end

    sfn2 = sfn == :plot ? :plot : jlfunc(sfn)
    haskey(funcs, sfn2)          || (funcs[sfn2]          = Dict())
    haskey(funcs[sfn2], realdef) || (funcs[sfn2][realdef] = Set())
    push!( funcs[sfn2][realdef] , realparent )
  end
end

# length(funcs) # 51
# showall(keys(funcs))
# k,v = first(funcs)
# k,v = :vllayer, funcs[:vllayer]
# for (k,v) in funcs
#   v2 = filter(needsfunction, keys(v))
#   na  = sum( isa(d, ArrayDef) for d in v2 )
#   nna = sum( !isa(d, ArrayDef) for d in v2 )
#   (na > 0 ) && println("$k : $na $nna")
# end

const arrayprops = Symbol[:layer, :transform, :hconcat, :vconcat]

### step 3 : declare functions
#
# for sfn in keys(funcs)
#   if isdefined(sfn)
#     mt = @eval typeof($sfn).name.mt
#     if isdefined(mt, :module) && mt.module != current_module()
#       println("   importing $sfn from $(mt.module)")
#       eval( Expr(:import, Symbol(mt.module), sfn) )
#     end
#   end
#
#   specnm = Symbol(vlname(sfn)) # VegaLite property name
#   @eval( function ($sfn)(args...;kwargs...)
#            $(Expr(:curly, :VLSpec, QuoteNode(specnm)))( wrapper($(QuoteNode(sfn)), args...; kwargs...) )
#          end  )
#
#   # export
#   eval( Expr(:export, sfn) )
# end
