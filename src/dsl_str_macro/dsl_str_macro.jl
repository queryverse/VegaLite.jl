macro vl_str(content)
    return VLSpec(Vega.json_parse(content))
end
