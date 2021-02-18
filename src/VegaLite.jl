module VegaLite

using JSON, NodeJS # 6s
import IteratorInterfaceExtensions # 1s
import TableTraits # 0
using FileIO # 17s !!!
using DataValues  # 1s
import MacroTools
using URIParser
using FilePaths
using REPL, Dates
using Random
using Setfield: Setfield, PropertyLens, @lens, @set
# import Cairo, Rsvg
using Pkg.Artifacts
using DataStructures
import TableTraitsUtils
using Vega
import Base64

export renderer, actionlinks
export @vl_str, @vlplot, vlplot, @vlfrag, vlfrag
export @vg_str, @vgplot, vgplot, @vgfrag, vgfrag
export load, save
export deletedata, deletedata!

const vegaliate_app_path = artifact"vegalite_app"
const vegaliate_app_includes_canvas =
    ispath(joinpath(vegaliate_app_path, "node_modules", "canvas"))

const vlschema =
    JSON.parsefile(joinpath(vegaliate_app_path, "schemas", "vega-lite-schema.json"))

include("vlspec.jl")

include("dsl_vlplot_function/shorthandparser.jl")
include("dsl_vlplot_function/dsl_vlplot_function.jl")
include("dsl_vlplot_macro/dsl_vlplot_macro.jl")
include("dsl_str_macro/dsl_str_macro.jl")

include("rendering/to_julia.jl")
include("rendering/render.jl")
include("rendering/io.jl")
include("rendering/show.jl")
include("rendering/fileio.jl")

include("experimental.jl")

end
