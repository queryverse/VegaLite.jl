function savefig(filename::AbstractString, mime::AbstractString, v::VLSpec)
    open(filename, "w") do f
        show(f, mime, v)
    end
end


"""
    savefig(filename::AbstractString, v::VLSpec)
Save the plot ``v`` as a file with name ``filename``. The file format
will be picked based on the extension of the filename.
"""
function savefig(filename::AbstractString, v::VLSpec)
    file_ext = lowercase(splitext(filename)[2])
    if file_ext == ".svg"
        mime = "image/svg+xml"
    elseif file_ext == ".pdf"
        mime = "application/pdf"
    elseif file_ext == ".png"
        mime = "image/png"
    elseif file_ext == ".eps"
        mime = "application/eps"
        # elseif file_ext == ".ps"
        #     mime = "application/postscript"
    else
        throw(ArgumentError("Unknown file type."))
    end

    savefig(filename, mime, v)
end

"""
    loadspec(filename::AbstractString)
    loadspec(io::IO)

Load a vega-lite specification from a file with name `filename`. An `IO`
object can also be passed. Returns a `VLSpec` object.
"""
loadspec(filename::AbstractString) = open(loadspec, filename)
loadspec(io::IO) = VLSpec(JSON.parse(io))

"""
    svg(filename::AbstractString, v::VLSpec)
Save the plot ``v`` as a svg file with name ``filename``.
"""
function svg(filename::AbstractString, v::VLSpec)
    savefig(filename, "image/svg+xml", v)
end

"""
    pdf(filename::AbstractString, v::VLSpec)
Save the plot ``v`` as a pdf file with name ``filename``.
"""
function pdf(filename::AbstractString, v::VLSpec)
    savefig(filename, "application/pdf", v)
end

"""
    png(filename::AbstractString, v::VLSpec)
Save the plot ``v`` as a png file with name ``filename``.
"""
function png(filename::AbstractString, v::VLSpec)
    savefig(filename, "image/png", v)
end

"""
    eps(filename::AbstractString, v::VLSpec)
Save the plot ``v`` as a eps file with name ``filename``.
"""
function eps(filename::AbstractString, v::VLSpec)
    savefig(filename, "application/eps", v)
end

function Vega.savespec(io::IO, v::VLSpec; include_data=false, indent=nothing)
    output_dict = copy(Vega.getparams(v))
    if !include_data
        delete!(output_dict, "data")
    end
    if indent === nothing
        JSON.print(io, output_dict)
    else
        JSON.print(io, output_dict, indent)
    end
end
