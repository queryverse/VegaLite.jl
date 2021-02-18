macro vlplot(ex...)
    new_ex = Vega.convert_curly_style(ex, VLFrag)

    return :(VegaLite.VLSpec(convert_frag_tree_to_dict(fix_shortcut_level_spec($new_ex))))
end

macro vlfrag(ex...)
    new_ex = Vega.convert_curly_style(ex, VLFrag)

    return new_ex
end
