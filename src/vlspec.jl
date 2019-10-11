###############################################################################
#
#   Definition of VLSpec type and associated functions
#
###############################################################################

struct VLSpec{T} <: AbstractVegaSpec
    params::Dict
end
vltype(::VLSpec{T}) where T = T

# data is an object in vega lite
function vl_set_spec_data!(specdict, datait)
    recs = [Dict{String,Any}(string(c[1])=>isa(c[2], DataValues.DataValue) ? (isna(c[2]) ? nothing : get(c[2])) : c[2] for c in zip(keys(r), values(r))) for r in datait]
    specdict["data"] = Dict{String,Any}("values" => recs)
end

function detect_encoding_type!(specdict, datait)
    col_names = fieldnames(eltype(datait))
    col_types = [fieldtype(eltype(datait),i) for i in col_names]
    col_type_mapping = Dict{Symbol,Type}(i[1]=>i[2] for i in zip(col_names,col_types))

    if haskey(specdict, "encoding")
        for (k,v) in specdict["encoding"]
            if v isa Dict && !haskey(v, "type")
                if !haskey(v, "aggregate") && haskey(v, "field") && haskey(col_type_mapping,Symbol(v["field"]))
                    jl_type = col_type_mapping[Symbol(v["field"])]
                    if jl_type <: DataValues.DataValue
                        jl_type = eltype(jl_type)
                    end
                    if jl_type <: Number
                        v["type"] = "quantitative"
                    elseif jl_type <: AbstractString
                        v["type"] = "nominal"
                    elseif jl_type <: Dates.AbstractTime
                        v["type"] = "temporal"
                    end
                end
            end
        end
    end
end

function (p::VLSpec{:plot})(data)
    TableTraits.isiterabletable(data) || throw(ArgumentError("'data' is not a table."))

    new_dict = copy(getparams(p))

    it = IteratorInterfaceExtensions.getiterator(data)
    vl_set_spec_data!(new_dict, it)
    detect_encoding_type!(new_dict, it)

    return VLSpec{:plot}(new_dict)
end

function (p::VLSpec{:plot})(uri::URI)
    new_dict = copy(getparams(p))
    new_dict["data"] = Dict{String,Any}("url" => string(uri))

    return VLSpec{:plot}(new_dict)
end

function (p::VLSpec{:plot})(path::AbstractPath)
    new_dict = copy(getparams(p))

    as_uri = string(URI(path))

    # TODO This is a hack that might only work on Windows
    # Vega seems to not understand properly formed file URIs
    new_dict["data"] = Dict{String,Any}("url" => Sys.iswindows() ? as_uri[1:5] * as_uri[7:end] : as_uri)

    return VLSpec{:plot}(new_dict)
end

Base.:(==)(x::VLSpec, y::VLSpec) = vltype(x) == vltype(y) && getparams(x) == getparams(y)

"""
    deletedata!(spec::VLSpec)

Delete data from `spec` in-place.  See also [`deletedata`](@ref).
"""
function deletedata!(spec::VLSpec)
    delete!(getparams(spec), "data")
    return spec
end

"""
    deletedata(spec::VLSpec)

Create a copy of `spec` without data.  See also [`deletedata!`](@ref).
"""
deletedata(spec::VLSpec) = deletedata!(copy(spec))

push_field!(fields, _) = fields
push_field!(fields, xs::AbstractVector) = foldl(push_field!, xs; init=fields)
function push_field!(fields, dict::AbstractDict)
    f = get(dict, "field", nothing)
    f !== nothing && push!(fields, string(f))
    for v in values(dict)
        push_field!(fields, v)
    end
    return fields
end

encoding_fields(spec::VLSpec) = encoding_fields(getparams(spec))
function encoding_fields(specdict)
    fields = Set{String}()
    for (k, v) in specdict
        k == "data" && continue
        push_field!(fields, v)
    end
    return sort!(collect(fields))
end

function with_stripped_data(spec::VLSpec)
    fields = encoding_fields(spec)
    vals = get(get(getparams(spec), "data", Dict()), "values", nothing)
    vals isa AbstractVector || return spec
    vals = map(row -> Dict(f => get(row, f, nothing) for f in fields), vals)
    return @set spec.data.values = vals
end
