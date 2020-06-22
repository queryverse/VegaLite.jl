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

    if s in union(vlschema.data["definitions"]["StandardType"]["enum"], vlschema.data["definitions"]["TypeForShape"]["enum"])
        return "type" => s
    else
        throw(ArgumentError("Invalid type."))
    end
end

function decode_func(s::AbstractString)
    s = lowercase(s)
    if s in vlschema.data["definitions"]["AggregateOp"]["enum"]
        return "aggregate" => s
    elseif s in union(
                vlschema.data["definitions"]["LocalMultiTimeUnit"]["enum"],
                vlschema.data["definitions"]["LocalSingleTimeUnit"]["enum"],
                vlschema.data["definitions"]["UtcMultiTimeUnit"]["enum"],
                vlschema.data["definitions"]["UtcSingleTimeUnit"]["enum"])
        return "timeUnit" => s
    else
        throw(ArgumentError("Unknown aggregation function or time unit '$s'."))
    end
end

function parse_shortcut(s::AbstractString)
    tokens = tokenize_shorthand(s)
    if length(tokens) > 1
        if tokens[2] == "("
            if length(tokens) > 2 && tokens[3] == ")"
                if length(tokens) == 3
                    decoded_func = decode_func(tokens[1])
                    return [decoded_func,"type" => decoded_func[1] == "timeUnit" ? "temporal" : "quantitative"]
                elseif length(tokens) == 5 && tokens[4] == ":"
                    return [decode_func(tokens[1]),decode_typ(tokens[5])]
                else
                    throw(ArgumentError("invalid shortcut string"))
                end
            elseif length(tokens) > 3 && tokens[4] == ")"
                if length(tokens) == 4
                    decoded_func = decode_func(tokens[1])
                    return [decoded_func,"field" => tokens[3],"type" => decoded_func[1] == "timeUnit" ? "temporal" : "quantitative"]
                elseif length(tokens) == 6 && tokens[5] == ":"
                    return [decode_func(tokens[1]),"field" => tokens[3],decode_typ(tokens[6])]
                else
                    throw(ArgumentError("invalid shortcut string"))
                end
            else
                throw(ArgumentError("Invalid shortcut string"))
            end
        elseif length(tokens) == 3 && tokens[2] == ":"
            return ["field" => tokens[1],decode_typ(tokens[3])]
        else
            throw(ArgumentError("Invalid shortcut string"))
        end
    else
        return ["field" => tokens[1]]
    end
end
