###############################################################################
#
#   @vlmod macro and immutable spec modification helpers
#
###############################################################################

abstract type VLModOp end

abstract type VLPathPart end

struct VLField <: VLPathPart
    name::Symbol
end

struct VLIndex <: VLPathPart
    index::Int
end

struct VLPath
    parts::Vector{VLPathPart}
end

struct VLSetOp <: VLModOp
    path::VLPath
    value
end

struct VLDeleteOp <: VLModOp
    path::VLPath
end

struct VLMod
    ops::Vector{VLModOp}
end

const _vlmod_channel_aliases = Set{Symbol}((
    :x,
    :y,
    :color,
    :size,
    :shape,
    :opacity,
    :row,
    :column,
    :theta,
    :radius,
    :longitude,
    :latitude,
    :longitude2,
    :latitude2,
    :tooltip,
    :detail,
    :href,
    :text,
    :order,
    :strokeDash,
    :key
))

_vlmod_key(part::VLField) = string(part.name)

function _vlmod_copy_object(node::AbstractDict)
    copied = OrderedDict{String,Any}()
    for (k, v) in node
        copied[string(k)] = v
    end
    return copied
end

_vlmod_make_empty_object() = OrderedDict{String,Any}()

function _vlmod_get(node::AbstractDict, key::String)
    haskey(node, key) && return node[key]
    skey = Symbol(key)
    haskey(node, skey) && return node[skey]
    return nothing
end

function _vlmod_haskey(node::AbstractDict, key::String)
    return haskey(node, key) || haskey(node, Symbol(key))
end

function _vlmod_delete!(node::AbstractDict, key::String)
    haskey(node, key) && delete!(node, key)
    skey = Symbol(key)
    haskey(node, skey) && delete!(node, skey)
    return node
end

function _vlmod_convert_value(value)
    if value isa AbstractDict
        return OrderedDict{String,Any}(string(k) => _vlmod_convert_value(v) for (k, v) in value)
    elseif value isa AbstractVector
        return [_vlmod_convert_value(v) for v in value]
    end
    return Vega.replace_remaining_frag(Vega.convert_nt_to_dict(value, VLFrag))
end

function vl_normalize_path(path::VLPath)
    if isempty(path.parts)
        return path
    end

    first_part = path.parts[1]
    if !(first_part isa VLField)
        throw(ArgumentError("Unsupported path part in @vlmod path."))
    end

    first_name = first_part.name
    if first_name in _vlmod_channel_aliases
        return VLPath(vcat(VLPathPart[VLField(:encoding)], path.parts))
    end

    return path
end

function _vlmod_promote_mark(child)
    child === nothing && return _vlmod_make_empty_object()
    child isa AbstractDict && return child

    promoted = _vlmod_make_empty_object()
    promoted["type"] = _vlmod_convert_value(child)
    return promoted
end

function _vlmod_empty_node(node)
    return (node isa AbstractDict && isempty(node)) || (node isa AbstractVector && isempty(node))
end

function _vlmod_copy_array(node::AbstractVector)
    return Any[node...]
end

function _vlmod_channel_path_for_shorthand(path::VLPath)
    length(path.parts) == 2 || return false
    p1 = path.parts[1]
    p2 = path.parts[2]
    p1 isa VLField || return false
    p2 isa VLField || return false
    p1.name == :encoding || return false
    return p2.name in _vlmod_channel_aliases
end

function _vlmod_normalize_set_value(path::VLPath, value)
    if _vlmod_channel_path_for_shorthand(path)
        if value isa Symbol
            return OrderedDict{String,Any}("field" => string(value))
        elseif value isa AbstractString
            return OrderedDict{String,Any}(parse_shortcut(value))
        end
    end
    return value
end

function _vlmod_empty_container_for(next_part::VLPathPart)
    if next_part isa VLField
        return _vlmod_make_empty_object()
    elseif next_part isa VLIndex
        return Any[]
    else
        throw(ArgumentError("Unsupported path part in @vlmod path."))
    end
end

function _vlmod_set_node(node, parts::Vector{VLPathPart}, value)
    isempty(parts) && return value
    part = parts[1]

    if part isa VLField
        key = _vlmod_key(part)
        dict = node isa AbstractDict ? _vlmod_copy_object(node) : _vlmod_make_empty_object()

        if length(parts) == 1
            dict[key] = value
            return dict
        end

        child = _vlmod_get(dict, key)
        if key == "mark"
            child = _vlmod_promote_mark(child)
        elseif child === nothing
            child = _vlmod_empty_container_for(parts[2])
        end

        dict[key] = _vlmod_set_node(child, parts[2:end], value)
        return dict
    elseif part isa VLIndex
        part.index >= 1 || throw(ArgumentError("Array index in @vlmod must be >= 1."))
        arr = node isa AbstractVector ? _vlmod_copy_array(node) : Any[]

        while length(arr) < part.index
            push!(arr, nothing)
        end

        if length(parts) == 1
            arr[part.index] = value
            return arr
        end

        child = arr[part.index]
        if child === nothing
            child = _vlmod_empty_container_for(parts[2])
        end
        arr[part.index] = _vlmod_set_node(child, parts[2:end], value)
        return arr
    else
        throw(ArgumentError("Unsupported path part in @vlmod path."))
    end
end

function _vlmod_delete_node(node, parts::Vector{VLPathPart})
    isempty(parts) && return node, false
    part = parts[1]

    if part isa VLField
        node isa AbstractDict || return node, false
        key = _vlmod_key(part)
        _vlmod_haskey(node, key) || return node, false

        if length(parts) == 1
            dict = _vlmod_copy_object(node)
            _vlmod_delete!(dict, key)
            return dict, true
        end

        child = _vlmod_get(node, key)
        new_child, deleted = _vlmod_delete_node(child, parts[2:end])
        deleted || return node, false

        dict = _vlmod_copy_object(node)
        if _vlmod_empty_node(new_child)
            _vlmod_delete!(dict, key)
        else
            dict[key] = new_child
        end

        return dict, true
    elseif part isa VLIndex
        node isa AbstractVector || return node, false
        part.index >= 1 || throw(ArgumentError("Array index in @vlmod must be >= 1."))
        part.index <= length(node) || return node, false
        arr = _vlmod_copy_array(node)

        if length(parts) == 1
            deleteat!(arr, part.index)
            return arr, true
        end

        child = arr[part.index]
        new_child, deleted = _vlmod_delete_node(child, parts[2:end])
        deleted || return node, false

        if _vlmod_empty_node(new_child)
            deleteat!(arr, part.index)
        else
            arr[part.index] = new_child
        end

        return arr, true
    else
        throw(ArgumentError("Unsupported path part in @vlmod path."))
    end
end

function vl_set_normalized(spec::VLSpec, path::VLPath, value)
    normalized_value = _vlmod_convert_value(_vlmod_normalize_set_value(path, value))
    new_params = _vlmod_set_node(Vega.getparams(spec), path.parts, normalized_value)
    return VLSpec(new_params)
end

function vl_delete_normalized(spec::VLSpec, path::VLPath)
    new_params, _ = _vlmod_delete_node(Vega.getparams(spec), path.parts)
    return VLSpec(new_params)
end

function vl_set(spec::VLSpec, path::VLPath, value)
    normalized = vl_normalize_path(path)
    return vl_set_normalized(spec, normalized, value)
end

function vl_delete(spec::VLSpec, path::VLPath)
    normalized = vl_normalize_path(path)
    return vl_delete_normalized(spec, normalized)
end

vl_apply(spec::VLSpec, op::VLSetOp) = vl_set(spec, op.path, op.value)
vl_apply(spec::VLSpec, op::VLDeleteOp) = vl_delete(spec, op.path)

function vl_apply(spec::VLSpec, mod::VLMod)
    current = spec
    for op in mod.ops
        current = vl_apply(current, op)
    end
    return current
end

(mod::VLMod)(spec::VLSpec) = vl_apply(spec, mod)

function _vlmod_path_symbols_from_expr(ex)
    if ex isa Symbol
        return VLPathPart[VLField(ex)]
    elseif ex isa Expr && ex.head == :ref && length(ex.args) == 2
        parts = _vlmod_path_symbols_from_expr(ex.args[1])
        idx_arg = ex.args[2]
        idx = if idx_arg isa Integer
            Int(idx_arg)
        elseif idx_arg isa QuoteNode && idx_arg.value isa Integer
            Int(idx_arg.value)
        else
            throw(ArgumentError("Only integer literal array indices are supported in @vlmod paths: $ex"))
        end
        push!(parts, VLIndex(idx))
        return parts
    elseif ex isa Expr && ex.head == :. && length(ex.args) == 2
        left = _vlmod_path_symbols_from_expr(ex.args[1])
        right = ex.args[2]
        if right isa QuoteNode && right.value isa Symbol
            push!(left, VLField(right.value))
            return left
        elseif right isa Symbol
            push!(left, VLField(right))
            return left
        else
            throw(ArgumentError("Invalid dotted path in @vlmod: $ex"))
        end
    else
        throw(ArgumentError("Invalid path syntax in @vlmod: $ex"))
    end
end

function _vlmod_path_expr_from_parts(path_parts::Vector{VLPathPart})
    parts_expr = Expr(
        :vect,
        map(path_parts) do part
            if part isa VLField
                :(VegaLite.VLField($(QuoteNode(part.name))))
            elseif part isa VLIndex
                :(VegaLite.VLIndex($(part.index)))
            else
                throw(ArgumentError("Unsupported path part in @vlmod path."))
            end
        end...
    )
    return :(VegaLite.VLPath($parts_expr))
end

function _vlmod_is_delete_expr(ex)
    return ex isa Expr &&
        ex.head == :call &&
        length(ex.args) == 2 &&
        ex.args[1] == :delete
end

_vlmod_is_op_expr(ex) = (ex isa Expr && ex.head == :(=)) || _vlmod_is_delete_expr(ex)

function _vlmod_parse_op_expr(ex)
    if ex isa Expr && ex.head == :(=) && length(ex.args) == 2
        path_parts = _vlmod_path_symbols_from_expr(ex.args[1])
        path_expr = _vlmod_path_expr_from_parts(path_parts)
        value_expr = esc(ex.args[2])
        return :(VegaLite.VLSetOp($path_expr, $value_expr))
    elseif _vlmod_is_delete_expr(ex)
        path_parts = _vlmod_path_symbols_from_expr(ex.args[2])
        path_expr = _vlmod_path_expr_from_parts(path_parts)
        return :(VegaLite.VLDeleteOp($path_expr))
    else
        throw(ArgumentError("Invalid @vlmod operation: $ex"))
    end
end

function _vlmod_mod_expr(op_exprs::AbstractVector)
    return :(VegaLite.VLMod(VegaLite.VLModOp[$(op_exprs...)]))
end

macro vlmod(args...)
    isempty(args) && throw(ArgumentError("@vlmod requires at least one operation."))

    if all(_vlmod_is_op_expr, args)
        parsed_ops = [_vlmod_parse_op_expr(arg) for arg in args]
        return _vlmod_mod_expr(parsed_ops)
    end

    if length(args) >= 2 && all(_vlmod_is_op_expr, args[2:end])
        target = esc(args[1])
        parsed_ops = [_vlmod_parse_op_expr(arg) for arg in args[2:end]]
        mod_expr = _vlmod_mod_expr(parsed_ops)
        return :(VegaLite.vl_apply($target, $mod_expr))
    end

    throw(ArgumentError("Invalid @vlmod syntax. Use @vlmod(op1, op2, ...) or @vlmod(spec, op1, op2, ...)."))
end
