###############################################################################
#
#   Definition of VLSpec type and associated functions
#
###############################################################################

struct VLSpec{T}
    params::Union{Dict, Vector}
end
vltype(::VLSpec{T}) where T = T

"""
creates a new VLSpec from the arguments provided
"""
function mkSpec(VL::Symbol, args...;kwargs...)
    params = todicttree(args...; kwargs...)

    # check if at least one of the SpecDef associated matches
    fdefs = collect(keys(funcs[VL]))
    conforms(params, "$VL", UnionDef("", fdefs))

    VLSpec{VL}(params)
end



# fuse identical keys (for encodings mostly)
function collapsetodict(elp::Vector{T})::Dict{String,Any} where T<:Tuple
    pars = Dict{String,Any}()
    for (k,v) in elp
        if haskey(pars, k)
            pars[k] = fuse(pars[k], v)
        else
            pars[k] = v
        end
    end
    pars
end

"""
transform single argument to a dict or vector
"""
togoodarg(a) = a

function togoodarg(a::Tuple)::Dict{String,Any}
    all( isa(e, VLSpec) for e in a) || error("tuple $a is not all VLSpecs")
    elp = Tuple{String,Any}[ (vlname(vltype(e)), e.params) for e in a ]
    collapsetodict(elp)
end

function togoodarg(a::NamedTuple)::Dict{String,Any}
    elp = Tuple{String,Any}[]
    for fnsym in fieldnames(typeof(a))
        # translate to a valid VegaLite prop if needed ('typ' -> 'type'), and to a string
        fnstr = String( get(jl2sp, fnsym, fnsym) )
        push!(elp, (fnstr,  togoodarg(getfield(a, fnsym))))
    end
    collapsetodict(elp)
end

function togoodarg(a::Dict{String,Any})::Dict{String,Any}
    elp = Tuple{String,Any}[]
    for (k,v) in a
        # translate to a valid VegaLite prop if needed ('typ' -> 'type'), and to a string
        fnstr = String( get(jl2sp, k, k) )
        push!(elp, (fnstr,  togoodarg(v)))
    end
    Dict{String,Any}(elp) # no need to fuse since we started with a Dict
end

function togoodarg(a::Vector)::Vector
    togoodarg.(a)
end

function togoodarg(a::VLSpec)
    error("unexpected VLSpec for a keyword arg $a")
end

"""
transform arguments to a tree structure (dict of dicts) suitable for a VLSpec.
"""
function todicttree(args...; kwargs...)
    ####  pass 1 : collect prop => value pairs
    pars = Tuple{Union{String,Void},Any}[]

    # kw args
    for (ksym,v) in kwargs
        # translate to a valid VegaLite prop if needed ('typ' -> 'type'), and to a string
        kstr = String( get(jl2sp, ksym, ksym) )
        push!(pars, (kstr, togoodarg(v)) )
    end

    # positional arguments
    for a in args
        if a isa VLSpec
            push!(pars, (vlname(vltype(a)), a.params) )
        else
            push!(pars, (nothing, togoodarg(a)) )
        end
    end

    #### pass 2 : separate cases the params are all propertyless from the other
    # cases. In the former case they could be fields for an ArrayObj
    #   such as data, or transform, etc....

    if (length(pars)==1) && pars[1][1]==nothing
        return pars[1][2]
    elseif all( p[1]==nothing for p in pars )
        return [ p[2] for p in pars ]
    elseif all( p[1]!=nothing for p in pars )
        return collapsetodict(pars)
    else
        error("inconsistent args in ($args ; $kwargs)")
    end
end



# function todicttree(args...; kwargs...)
#     ####  pass 1 : collect prop => value pairs
#     pars = Pair{Union{String,Void},Any}[]
#
#     # kw args
#     for (ksym,v) in kwargs
#         # translate to a valid VegaLite prop if needed ('typ' -> 'type'), and to a string
#         kstr = String( get(jl2sp, ksym, ksym) )
#         v2= if v isa NamedTuple
#                 kwa = [ (ns,  getfield(v, ns)) for ns in fieldnames(typeof(v)) ]
#                 todicttree(;kwa...)
#             elseif v isa Dict
#                 kwa = [ (Symbol(k),  val) for (k,val) in v ]
#                 todicttree(;kwa...)
#             elseif v isa Tuple  # accepted if all elements have a prop (VLSpecs)
#                 all( isa(e, VLSpec) for e in v) || error("tuple $v is not all VLSpecs")
#                 kwa = [ (Symbol(vlname(vltype(e))), e.params) for e in v ]
#                 todicttree(;kwa...)
#             elseif v isa VLSpec
#                 Dict(vlname(vltype(v)) => v.params)
#             else
#                 v
#             end
#         push!(pars, kstr => v2)
#     end
#
#     # positional arguments
#     for a in args
#         if a isa VLSpec
#             push!(pars, vlname(vltype(a)) => a.params)
#         elseif a isa NamedTuple
#             kwa = [ (ns,  getfield(a, ns)) for ns in fieldnames(typeof(a)) ]
#             push!(pars, nothing => todicttree(;kwa...) )
#         elseif a isa Tuple  # accepted if all elements have a prop (VLSpecs)
#             all( isa(e, VLSpec) for e in a) || error("tuple $a is not all VLSpecs")
#             push!(pars, nothing => todicttree(collect(a)...))
#         elseif a isa Vector
#             push!(pars, nothing => todicttree.(a) )
#         else
#             push!(pars, nothing => a)
#         end
#     end
#
#     #### pass 2 : separate cases the params are all propertyless from the other
#     # cases. In the former case they could be fields for an ArrayObj
#     #   such as data, or transform, etc....
#
#     if all( p[1]==nothing for p in pars )
#         return length(pars)==1 ? pars[1][2] : [ p[2] for p in pars ]
#
#     elseif all( p[1]!=nothing for p in pars )
#         pars2 = Dict{String,Any}()
#         for p in pars
#             if haskey(pars2, p[1])
#                 pars2[p[1]] = fuse(pars2[p[1]], p[2])
#             else
#                 pars2[p[1]] = p[2]
#             end
#         end
#         return pars2
#     else
#         error("inconsistent args in ($args ; $kwargs)")
#     end
# end

function fuse(a::Dict, b::Dict)
    na = copy(a)
    for (k,v) in b
        if haskey(a, k)
            na[k] = fuse(na[k], v)
        else
            na[k] = v
        end
    end
    na
end

function fuse(a, b)
    [a, b]
end
