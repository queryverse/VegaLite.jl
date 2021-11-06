###############################################################################
#
#   Definition of VLSpec type and associated functions
#
###############################################################################

struct VLSpec <: Vega.AbstractVegaSpec
    params::OrderedDict
end

# data is an object in vega lite
function vl_set_spec_data!(specdict, datait)
    recs = [OrderedDict{String,Any}(string(c[1]) => isa(c[2], DataValues.DataValue) ? (isna(c[2]) ? nothing : get(c[2])) : c[2] for c in zip(keys(r), values(r))) for r in datait]
    specdict["data"] = OrderedDict{String,Any}("values" => recs)
end

function augment_encoding_type(x::AbstractDict, data::Vega.DataValuesNode)
    if !haskey(x, "type") && !haskey(x, "aggregate") && haskey(x, "field") && haskey(data.columns, Symbol(x["field"]))
        new_x = copy(x)

        jl_type = eltype(data.columns[Symbol(x["field"])])

        if jl_type <: DataValues.DataValue
            jl_type = eltype(jl_type)
        end

        if jl_type <: Number
            new_x["type"] = "quantitative"
        elseif jl_type <: AbstractString
            new_x["type"] = "nominal"
        elseif jl_type <: Dates.AbstractTime
            new_x["type"] = "temporal"
        end

        return new_x
    else
        return x
    end
end

function add_encoding_types(specdict, parentdata=nothing)
    if (haskey(specdict, "data") && haskey(specdict["data"], "values") && specdict["data"]["values"] isa Vega.DataValuesNode) || parentdata !== nothing || any(i -> haskey(specdict, i), ("spec", "layer", "concat", "vconcat", "hconcat"))
        data = (haskey(specdict, "data") && haskey(specdict["data"], "values") && specdict["data"]["values"] isa Vega.DataValuesNode) ? specdict["data"]["values"] : parentdata

        newspec = OrderedDict{String,Any}(
            (k == "encoding" && v isa AbstractDict && !isnothing(data)) ? k => OrderedDict{String,Any}(kk => augment_encoding_type(vv, data) for (kk, vv) in v) :
                k == "spec" ? k => add_encoding_types(v, data) :
                k in ("layer", "concat", "vconcat", "hconcat") ? k => [add_encoding_types(i, data) for i in v] : k => v for (k, v) in specdict
        )

        return newspec
    else
        return specdict
    end
end

function our_json_print(io, spec::VLSpec)
    JSON.print(io, add_encoding_types(Vega.getparams(spec)))
end

function (p::VLSpec)(data)
    TableTraits.isiterabletable(data) || throw(ArgumentError("'data' is not a table."))

    it = IteratorInterfaceExtensions.getiterator(data)

    datavaluesnode = Vega.DataValuesNode(it)

    new_dict = copy(Vega.getparams(p))

    new_dict["data"] = OrderedDict{String,Any}("values" => datavaluesnode)

    return VLSpec(new_dict)
    end

function (p::VLSpec)(uri::URI)
    new_dict = copy(Vega.getparams(p))
    new_dict["data"] = OrderedDict{String,Any}("url" => string(uri))

    return VLSpec(new_dict)
end

function (p::VLSpec)(path::AbstractPath)
    new_dict = copy(Vega.getparams(p))

    as_uri = string(URI(path))

    # TODO This is a hack that might only work on Windows
    # Vega seems to not understand properly formed file URIs
    new_dict["data"] = OrderedDict{String,Any}("url" => Sys.iswindows() ? as_uri[1:5] * as_uri[7:end] : as_uri)

    return VLSpec(new_dict)
end

Base.:(==)(x::VLSpec, y::VLSpec) = Vega.getparams(x) == Vega.getparams(y)

"""
    Vega.deletedata!(spec::VLSpec)

Delete data from `spec` in-place.  See also [`Vega.deletedata`](@ref).
"""
function Vega.deletedata!(spec::VLSpec)
    delete!(Vega.getparams(spec), "data")
    return spec
end

"""
    Vega.deletedata(spec::VLSpec)

Create a copy of `spec` without data.  See also [`Vega.deletedata!`](@ref).
"""
Vega.deletedata(spec::VLSpec) = Vega.deletedata!(copy(spec))

"""
Remove potentially duplicated data in composed subspecs and promote it to the top level spec
"""
function promote_data_to_toplevel(spec::VLSpec, key)
    specdict = deepcopy(Vega.getparams(spec))
    (key in ("layer", "concat", "vconcat", "hconcat") && haskey(specdict, key)) || return specdict
    parentdata = get(specdict, "data", nothing)
    for subspec in specdict[key]
        haskey(subspec, "data") || continue
        data = subspec["data"]
        if isnothing(parentdata)
            parentdata = data
            specdict["data"] = parentdata
        end
        parentdata == data && delete!(subspec, "data")
    end
    return VLSpec(specdict)
end

abstract type VLSpecTyped end
struct SingleView <: VLSpecTyped spec::VLSpec end
abstract type ComposedView <: VLSpecTyped end
struct Layer <: ComposedView  spec::VLSpec end
abstract type MultiView <: ComposedView end
struct Facet <: MultiView  spec::VLSpec end
struct Repeat <: MultiView  spec::VLSpec end
struct Concat <: MultiView  spec::VLSpec end
struct HConcat <: MultiView  spec::VLSpec end
struct VConcat <: MultiView  spec::VLSpec end

const ConcatSpecs = Union{Concat, HConcat, VConcat}

function VLSpecTyped(spec::VLSpec)
    specdict = Vega.getparams(spec)
    haskey(specdict, "layer") && return Layer(spec)
    haskey(specdict, "facet") &&  return Facet(spec)
    haskey(specdict, "repeat") &&  return Repeat(spec)
    haskey(specdict, "concat") &&  return Concat(spec)
    haskey(specdict, "hconcat") &&  return HConcat(spec)
    haskey(specdict, "vconcat") &&  return VConcat(spec)
    return SingleView(spec)
end

Layer(spec::SingleView) = Layer(VLSpec(OrderedDict{String,Any}("layer" => [deepcopy(Vega.getparams(spec.spec))])))

"""
    spec1::VLSpec + spec2::VLSpec

The addition of two `VLSpec` produces a new `VLSpec` with both specs layered. The order matters
as `spec1` will appear below `spec2`.
If the specs contain common data, it will be promoted to the top level specification.
Layering layered specification will append the layers instead of creating a nested layer, so
for example [l1, l2] + [l3, l4] will become [l1, l2, l3, l4] instead of [[l1, l2], [l3, l4]].
Multi-view specs (facet, repeat, concat) cannot be layered.
"""
Base.:+(a::VLSpec, b::VLSpec) = Base.:+(VLSpecTyped(a), VLSpecTyped(b))
Base.:+(a::MultiView, b::VLSpecTyped) = error("Multi-view spec $(typeof(a)) can not be layered")
Base.:+(a::VLSpecTyped, b::MultiView) = error("Multi-view spec $(typeof(b)) can not be layered")
Base.:+(a::MultiView, b::MultiView) = error("Multi-view spec $(typeof(a)) can not be layered")
Base.:+(a::VLSpecTyped, b::VLSpecTyped) = error("Layering not implemented for $(typeof(a)) + $(typeof(b))")
function Base.:+(a::Layer, b::Layer)
    a_spec = deepcopy(Vega.getparams(a.spec))
    b_spec = deepcopy(Vega.getparams(b.spec))
    append!(a_spec["layer"], b_spec["layer"])
    return promote_data_to_toplevel(VLSpec(a_spec), "layer")
end
Base.:+(a::SingleView, b::SingleView) = Layer(a) + Layer(b)
Base.:+(a::SingleView, b::Layer) = Layer(a) + b
Base.:+(a::Layer, b::SingleView) = a + Layer(b)

"""
    spec1::VLSpec * spec2::VLSpec

Multiplicating two `VLSpec` creates a new `VLSpec` as a composition of the two specifications.
Properties defined in `spec2` have precedence over `spec1`, meaning that if a given property
is specified in both then the result specification will use the property from `spec2`.

# Examples
some examples
"""
Base.:*(a::VLSpec, b::VLSpec) = Base.:*(VLSpecTyped(a), VLSpecTyped(b))
Base.:*(a::MultiView, b::MultiView) = error("Two multi-view specs ($(typeof(a)), $(typeof(b))) can not be composed")
Base.:*(a::VLSpecTyped, b::MultiView) = b * Vega.deletedata(a)
function Base.:*(a::MultiView, b::VLSpecTyped)
        a_spec = deepcopy(Vega.getparams(a.spec))
    b_spec = deepcopy(Vega.getparams(b.spec))
    if haskey(b_spec, "data")
        a_spec["data"] = b_spec["data"]
        delete!(b_spec, "data")
    end
    if haskey(a_spec, "spec")
        b_spec = _compose!(a_spec["spec"], b_spec)
    end
    a_spec["spec"] = b_spec
    return VLSpec(a_spec)
end
Base.:*(a::ConcatSpecs, b::VLSpecTyped) = _compose(a, b) # FIXME: do something smarter
Base.:*(a::VLSpecTyped, b::VLSpecTyped) = _compose(a, b)

function _compose(a::VLSpec, b::VLSpec)
    a_spec = deepcopy(Vega.getparams(a.spec))
    b_spec = deepcopy(Vega.getparams(b.spec))
    return VLSpec(_compose!(a_spec, b_spec))
end
function _compose!(a::OrderedDict, b::OrderedDict)
    for (k, v) in b
        if haskey(a, k) && a[k] isa OrderedDict && b[k] isa OrderedDict
            _compose!(a[k], b[k])
        else
            a[k] = b[k]
        end
    end
    return a
end

function Base.hcat(A::VLSpec...)
    spec = VLSpec(OrderedDict{String,Any}())
    Vega.getparams(spec)["hconcat"] = []
    for i in A
        push!(Vega.getparams(spec)["hconcat"], deepcopy(Vega.getparams(i)))
    end
    return promote_data_to_toplevel(spec, "hconcat")
end

function Base.vcat(A::VLSpec...)
    spec = VLSpec(OrderedDict{String,Any}())
    Vega.getparams(spec)["vconcat"] = []
    for i in A
        push!(Vega.getparams(spec)["vconcat"], deepcopy(Vega.getparams(i)))
    end
    return promote_data_to_toplevel(spec, "vconcat")
end
