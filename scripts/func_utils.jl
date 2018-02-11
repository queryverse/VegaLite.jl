open(joinpath(@__DIR__, "..", "src", "generated", "utils.jl"), "w") do f

### Shorcut functions

# ... x(typ=:quantitative, .. ))  => xquantitative()
for chan in keys(refs["EncodingWithFacet"].props)
  for typ in refs["Type"].enum
    sfn = Symbol(chan * typ)

    # function declaration and export
    schan = jlfunc(chan)
    println(f, :(function ($sfn)(args...;kwargs...)
            nkw = [kwargs ; (:type, $typ)]
            ($schan)(args...;nkw...)
          end))
    println(f, Expr(:export, sfn) )

    # function documentation
    sfn0 = jlfunc(chan)
    println(f, :( @doc (@doc $sfn0) $sfn ))
  end
end

# encode_x()
for chan in keys(refs["EncodingWithFacet"].props)
    sfn = Symbol("encode_" * chan)

    schan = jlfunc(chan)

    println(f, :(function ($sfn)(field::Symbol, args...;kwargs...)
        contains(i->i[1],kwargs,:field) && error("You cannot pass a keyword argument named 'field'.")
        nkw = [kwargs ; (:field, field)]
        encoding(($schan)(args...;nkw...))
    end))

    println(f, :(function ($sfn)(shorthand::String, args...;kwargs...)
        parts = match(r"(\w+)(\(\w+\))?(:[QqOoNnTt])?", shorthand)

        if parts[2]==nothing
            field_name = parts[1]
            agg_name = nothing
        else
            field_name = parts[2][2:end-1]
            agg_name = parts[1]
        end
        vl_type = if parts[3]!=nothing && uppercase(parts[3][2:end])=="Q"
            "quantitative"
        elseif parts[3]!=nothing && uppercase(parts[3][2:end])=="O"
            "ordinal"
        elseif parts[3]!=nothing && uppercase(parts[3][2:end])=="N"
            "nominal"
        elseif parts[3]!=nothing && uppercase(parts[3][2:end])=="T"
            "temporal"
        else
            nothing
        end

        parts = split(shorthand, ':')

        nkw = [kwargs ; (:field, Symbol(field_name))]
        if vl_type!=nothing
          nkw = [nkw ; (:type, vl_type)]
        end
        if agg_name!=nothing
          nkw = [nkw ; (:aggregate, String(agg_name))]
        end

        encoding(($schan)(args...;nkw...))
    end))

    println(f, Expr(:export, sfn))
end

# ... mark(typ=:line .. ))  => markline()
for typ in refs["Mark"].enum
  sfn = Symbol("mark" * typ)

  # function declaration and export
  # styp = Symbol(typ)
  println(f, :(function ($sfn)(args...;kwargs...)
          nkw = [kwargs ; (:type, $typ)]
          vlmark(args...;nkw...)
        end))
  println(f, Expr(:export, sfn) )

  # function documentation
  sfn0 = jlfunc(:mark)
  println(f, :( @doc (@doc $sfn0) $sfn ))
end

# 1st level aliases

# import Base: repeat

for sfn in [:config, :data, :transform, :selection, :encoding,
            :layer, :spec, :facet, :hconcat, :vconcat, :repeat]
  sfn0 = jlfunc(sfn)

  println(f, :( function ($sfn)(args...;kwargs...)
            ($sfn0)(args...;kwargs...)
         end ))
  println(f, Expr(:export, sfn) )

  # documentation
  println(f, :( @doc (@doc $sfn0) $sfn ))
end

end
