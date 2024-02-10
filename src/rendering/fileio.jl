function fileio_load(f::FileIO.File{FileIO.format"vegalite"})
    return loadspec(f.filename)
end

function fileio_load(stream::FileIO.Stream{FileIO.format"vegalite"})
    return loadspec(stream.io)
end

function fileio_save(file::FileIO.File{FileIO.format"vegalite"}, data::VLSpec; include_data=true, kwargs...)
    Vega.savespec(file.filename, data; include_data=include_data, kwargs...)
end

function fileio_save(stream::FileIO.Stream{FileIO.format"vegalite"}, data::VLSpec; include_data=true, kwargs...)
    Vega.savespec(stream.io, data; include_data=include_data, kwargs...)
end

function fileio_save(file::FileIO.File{FileIO.format"vega"}, data::VLSpec; include_data=true, kwargs...)
    s = Base64.stringmime(MIME("application/vnd.vega.v5+json"), data)
    parsed = JSON.parse(s)
    vgspec = Vega.VGSpec(parsed)
    Vega.savespec(file.filename, vgspec; include_data=include_data, kwargs...)
end

function fileio_save(stream::FileIO.Stream{FileIO.format"vega"}, data::VLSpec; include_data=true, kwargs...)
    s = Base64.stringmime(MIME("application/vnd.vega.v5+json"), data)
    parsed = JSON.parse(s)
    vgspec = Vega.VGSpec(parsed)
    Vega.savespec(stream.io, vgspec; include_data=include_data, kwargs...)
end
