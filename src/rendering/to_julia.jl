function Vega.printrepr(io::IO, v::VLSpec; indent = nothing, include_data = false)
    newlines = indent === nothing ? false : true
    indent = indent === nothing ? 0 : indent

    print(io, "@vlplot(")
    newlines && println(io)
    Vega.print_vspec_as_julia(io, Vega.getparams(v), indent, 1, newlines, include_data)
    newlines && println(io)
    print(io, ")")
end
