###############################################################################
#
#   Definition of the helper functions for the creation of VegaLite specs
#    (i.e. beyond definitions using NamedTuples and Dicts)
#
###############################################################################

### encoding family : enc.x.quantitative, ...

function mkfunc1(dim, typ)
    if typ == :value
        function (val, args...; kwargs...)
            pars = todicttree(args...; value=val, typ=typ, kwargs...)
            VLSpec{:vlencoding}(;[(dim, pars);]...)
        end
    else
        function (field, args...; kwargs...)
            pars = todicttree(args...; field=field, typ=typ, kwargs...)
            VLSpec{:vlencoding}(;[(dim, pars);]...)
        end
    end
end

# channels = Symbol.(collect(keys(refs["EncodingWithFacet"].props)))
# chantyps = Symbol.(collect(union(refs["BasicType"].enum, refs["GeoType"].enum)))
# push!(chantyps, :value)
#
# typnt = NamedTuples.make_tuple( chantyps )
#
# encs = []
# for ch in channels
#     push!(encs, typnt( [ mkfunc1(ch, tp) for tp in chantyps ]... ) )
# end
# enc = NamedTuples.make_tuple( channels )( encs... )
#
# export enc

#####  mark family : mark.line(), ...

function mkfunc2(typ)
    function (args...; kwargs...)
        VLSpec{:vlmark}(args...; typ=typ, kwargs...)
    end
end


# this fails at precompilation
# marktyps = Symbol.(collect(refs["Mark"].enum))
# marknt = NamedTuples.make_tuple( marktyps )

# => switch to explicit creation
# marktyps = Symbol[:tick, :bar, :square, :point, :line, :rect, :area, :circle, :rule, :text, :geoshape]
# marknt = @NT(tick, bar, square, point, line, rect, area, circle, rule, text, geoshape)
#
# mark = marknt([ mkfunc2(typ) for typ in marktyps ]...)
#
# export mark
#

#### plot, the top level function

# function plot(args...; kwargs...)
#     vls = mkSpec(:plot, args...; kwargs...)
#     checkplot(vls)
#     vls
# end

plot(args...; kwargs...)        = mkSpec(:plot, args...; kwargs...)

export plot

#### 1st level aliases

config(args...; kwargs...)     = mkSpec(:vlconfig, args...; kwargs...)
selection(args...; kwargs...)  = mkSpec(:vlselection, args...; kwargs...)
resolve(args...; kwargs...)    = mkSpec(:vlresolve, args...; kwargs...)
projection(args...; kwargs...) = mkSpec(:vlprojection, args...; kwargs...)
facet(args...; kwargs...)      = mkSpec(:vlfacet, args...; kwargs...)
spec(args...; kwargs...)       = mkSpec(:vlspec, args...; kwargs...)
rep(args...; kwargs...)        = mkSpec(:vlrepeat, args...; kwargs...)

transform(args...) = mkSpec(:vltransform, args...)
hconcat(args...)   = mkSpec(:vlhconcat, args...)
vconcat(args...)   = mkSpec(:vlvconcat, args...)
layer(args...)     = mkSpec(:vllayer, args...)

export config, selection, resolve, projection, facet, spec, rep
export transform, hconcat, vconcat, layer

### data
# dat is a special case, we want to interpret correctly cases where an
# iterable table is passed as an argument

getrealvalue(v::DataValues.DataValue) = isnull(v) ? nothing : get(v)
getrealvalue(v) = v

function data(args...; kwargs...)
    if (length(args) == 1) && TableTraits.isiterabletable(args[1])
        it = IteratorInterfaceExtensions.getiterator(args[1])
        recs = [Dict(c[1] => getrealvalue(c[2]) for c in zip(keys(r), values(r))) for r in it]

        mkSpec(:vldata; values=recs, kwargs...)
    else
        mkSpec(:vldata, args...; kwargs...)
    end
end

function |>(a, b::VLSpec{:plot})
    b.params["data"] = data(a).params
    b
end

export data
