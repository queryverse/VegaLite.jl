function load(f::FileIO.File{FileIO.format"vegalite"})
    return loadspec(f.filename)
end

function save(file::FileIO.File{FileIO.format"vegalite"}, data::VLSpec{:plot}; include_data=false)
    savespec(file.filename, data, include_data=include_data)
end
