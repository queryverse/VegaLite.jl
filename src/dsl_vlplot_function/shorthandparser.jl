function tokenize_shorthand(s::AbstractString)
    tokens = String[]
    curr_start = 1
    i = 1
    while true
        if s[i] == '(' || s[i] == ')' || s[i] == ':'
            if i > curr_start
                push!(tokens, s[curr_start:prevind(s, i)])
            end
            push!(tokens, s[i:i])
            curr_start = nextind(s, i)
        elseif !(isletter(s[i]) || isnumeric(s[i]) || s[i] in ('_'))
            throw(ArgumentError("Invalid shortcut string"))
        end

        i = nextind(s, i)

        if i > lastindex(s)
            if i > curr_start
                push!(tokens, s[curr_start:prevind(s, i)])
            end
            break
        end
    end
    return tokens
end

function decode_typ(s::AbstractString)
    s = lowercase(s)
    if s == "q"
        s = "quantitative"
    elseif s == "o"
        s = "ordinal"
    elseif s == "n"
        s = "nominal"
    elseif s == "t"
        s = "temporal"
    end
    for key in ("StandardType", "TypeForShape")
        if s in vlschema[]["definitions"][key]["enum"]
            return "type" => s
        end
    end
    throw(ArgumentError("Invalid type."))
end

function decode_func(s::AbstractString)
    s = lowercase(s)
    if s in vlschema[]["definitions"]["AggregateOp"]["enum"]
        return "aggregate" => s
    end
    for key in (
        "LocalMultiTimeUnit",
        "LocalSingleTimeUnit",
        "UtcMultiTimeUnit",
        "UtcSingleTimeUnit",
    )
        if s in vlschema[]["definitions"][key]["enum"]
            return "timeUnit" => s
        end
    end
    throw(ArgumentError("Unknown aggregation function or time unit '$s'."))
end

function parse_shortcut(s::AbstractString)
    tokens = tokenize_shorthand(s)
    if length(tokens) > 1
        if tokens[2] == "("
            if length(tokens) > 2 && tokens[3] == ")"
                if length(tokens) == 3
                    decoded_func = decode_func(tokens[1])
                    return [decoded_func, "type" => decoded_func[1] == "timeUnit" ? "temporal" : "quantitative"]
                elseif length(tokens) == 5 && tokens[4] == ":"
                    return [decode_func(tokens[1]), decode_typ(tokens[5])]
                else
                    throw(ArgumentError("invalid shortcut string"))
                end
            elseif length(tokens) > 3 && tokens[4] == ")"
                if length(tokens) == 4
                    decoded_func = decode_func(tokens[1])
                    return [decoded_func, "field" => tokens[3], "type" => decoded_func[1] == "timeUnit" ? "temporal" : "quantitative"]
                elseif length(tokens) == 6 && tokens[5] == ":"
                    return [decode_func(tokens[1]), "field" => tokens[3], decode_typ(tokens[6])]
                else
                    throw(ArgumentError("invalid shortcut string"))
                end
            else
                throw(ArgumentError("Invalid shortcut string"))
            end
        elseif length(tokens) == 3 && tokens[2] == ":"
            return ["field" => tokens[1], decode_typ(tokens[3])]
        else
            throw(ArgumentError("Invalid shortcut string"))
        end
    else
        return ["field" => tokens[1]]
    end
end
