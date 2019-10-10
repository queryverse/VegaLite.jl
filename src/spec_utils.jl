struct ObjectProxy
    params::Dict
end

abstract type AbstractVegaSpec end

Base.copy(spec::T) where {T <: AbstractVegaSpec} = T(copy(getparams(spec)))

const ObjectLike = Union{AbstractVegaSpec, ObjectProxy}

getparams(spec) = getfield(spec, :params)

Base.propertynames(spec::ObjectLike) =
    [Symbol(key) for key in keys(getparams(spec))]

function Base.getproperty(spec::ObjectLike, name::Symbol)
    if name === :params
        Base.depwarn(
            """
            Using `spec.params["NAME"]` to obtain vega-lite property is deprecated.
            Please use `spec.NAME` instead.
            """,
            :getproperty,
        )
        return getparams(spec)
    end
    params = getparams(spec)
    value = params[keytype(params)(name)]
    if value isa Dict
        return ObjectProxy(value)
    else
        return value
    end
end

Setfield.set(spec::ObjectLike, ::typeof(@lens getparams(_)), params) =
    typeof(spec)(params)

function Setfield.set(spec::ObjectLike, ::PropertyLens{name}, value) where name
    params = copy(getparams(spec))
    params[keytype(params)(name)] = _maybeparams(value)
    @set getparams(spec) = params
end

_maybeparams(value) = value
_maybeparams(value::ObjectLike) = getparams(value)

_getiterator(data) =
    if TableTraits.isiterabletable(data)
        IteratorInterfaceExtensions.getiterator(data)
    else
        Tables.rowtable(data)
    end
