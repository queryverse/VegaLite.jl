module VegaLite

using JSON, NodeJS # 6s
import IteratorInterfaceExtensions # 1s
import TableTraits # 0
import Tables
using FileIO # 17s !!!
using DataValues  # 1s
import MacroTools
using URIParser
using FilePaths
using REPL, Dates
using Random
import JSONSchema
using Setfield: Setfield, PropertyLens, @lens, @set

# This import can eventually be removed, it currently just makes sure
# that the iterable tables integration for DataFrames and friends
# is loaded
import IterableTables

export renderer, actionlinks
export @vl_str, @vlplot
export @vg_str
export load, save
export deletedata, deletedata!

global vlschema = JSONSchema.Schema(JSON.parsefile(joinpath(@__DIR__, "..", "assets", "vega", "vega-lite-schema.json")))

########################  settings functions  ############################

# Switch for plotting in SVGs or canvas

global RENDERER = :svg

"""
`renderer()`

show current rendering mode (svg or canvas)

`renderer(::Symbol)`

set rendering mode (svg or canvas)
"""
renderer() = RENDERER
function renderer(m::Symbol)
  global RENDERER
  m in [:svg, :canvas] || error("rendering mode should be either :svg or :canvas")
  RENDERER = m
end


# Switch for showing or not the buttons under the plot

global ACTIONSLINKS = true

"""
`actionlinks()::Bool`

show if plots will have (true) or not (false) the action links displayed

`actionlinks(::Bool)`

indicate if actions links should be dislpayed under the plot
"""
actionlinks() = ACTIONSLINKS
actionlinks(b::Bool) = (global ACTIONSLINKS ; ACTIONSLINKS = b)


########################  includes  #####################################
include("spec_utils.jl")
include("vgspec.jl")
include("vlspec.jl")

include("dsl_vlplot_macro/dsl_vlplot_macro.jl")
include("dsl_str_macro/dsl_str_macro.jl")

include("rendering/render.jl")
include("rendering/io.jl")
include("rendering/show.jl")
include("rendering/fileio.jl")

include("mime_wrapper.jl")

end
