################################################################################
#  Save to file functions
################################################################################

function savefig(filename::AbstractString, mime::AbstractString, v::VLSpec{:plot})
    open(filename, "w") do f
        show(f, mime, v)
    end
end


"""
    savefig(filename::AbstractString, v::VLSpec{:plot})
Save the plot ``v`` as a file with name ``filename``. The file format
will be picked based on the extension of the filename.
"""
function savefig(filename::AbstractString, v::VLSpec{:plot})
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

Load a vega-lite specification from a file with name `filename`. Returns
a `VLSpec` object.
"""
function loadspec(filename::AbstractString)
    s = readstring(filename)
    return VLSpec{:plot}(JSON.parse(s))
end

"""
    savespec(filename::AbstractString, v::VLSpec{:plot}; include_data=false)

Save the plot `v` as a vega-lite specification file with the name `filename`.
The `include_data` argument controls whether the data should be included
in the saved specification file.
"""
function savespec(filename::AbstractString, v::VLSpec{:plot}; include_data=false)
    output_dict = copy(v.params)
    if !include_data
        delete!(output_dict, "data")
    end
    open(filename, "w") do f
        JSON.print(f, output_dict)
    end
end

"""
    svg(filename::AbstractString, v::VLSpec{:plot})
Save the plot ``v`` as a svg file with name ``filename``.
"""
function svg(filename::AbstractString, v::VLSpec{:plot})
    savefig(filename, "image/svg+xml", v)
end

"""
    pdf(filename::AbstractString, v::VLSpec{:plot})
Save the plot ``v`` as a pdf file with name ``filename``.
"""
function pdf(filename::AbstractString, v::VLSpec{:plot})
    savefig(filename, "application/pdf", v)
end

"""
    png(filename::AbstractString, v::VLSpec{:plot})
Save the plot ``v`` as a png file with name ``filename``.
"""
function png(filename::AbstractString, v::VLSpec{:plot})
    savefig(filename, "image/png", v)
end

"""
    eps(filename::AbstractString, v::VLSpec{:plot})
Save the plot ``v`` as a eps file with name ``filename``.
"""
function eps(filename::AbstractString, v::VLSpec{:plot})
    savefig(filename, "application/eps", v)
end
