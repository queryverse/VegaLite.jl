module VegaLite

if isdefined(Base, :Experimental) && isdefined(Base.Experimental, Symbol("@optlevel"))
    @eval Base.Experimental.@optlevel 0
end

using JSON
import NodeJS
import IteratorInterfaceExtensions # 1s
import TableTraits # 0
using FileIO # 17s !!!
using DataValues  # 1s
import MacroTools
using URIParser
using FilePaths
using REPL, Dates
using Random
# import Cairo, Rsvg
using Pkg.Artifacts
using DataStructures
import TableTraitsUtils
using Vega
import Base64
import BufferedStreams

export renderer, actionlinks
export @vl_str, @vlplot, vlplot, @vlfrag, vlfrag
export @vg_str, @vgplot, vgplot, @vgfrag, vgfrag
export load, save
export deletedata, deletedata!

vegalite_app_path(args...) = joinpath(artifact"vegalite_app", args...)
const vegaliate_app_includes_canvas = Ref{Bool}()

const vlschema = Ref{Dict{String,Any}}()

function __init__()
    vegaliate_app_includes_canvas[] = ispath(vegalite_app_path("node_modules", "canvas"))
    vlschema[] = JSON.parsefile(
        vegalite_app_path("schemas", "vega-lite-schema.json")
    )
end

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
