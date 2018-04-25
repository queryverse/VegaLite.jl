__precompile__()
module VegaLite

using JSON, Compat, Requires, NodeJS, Cairo, Rsvg
import IteratorInterfaceExtensions, TableTraits, FileIO, DataValues

import Base: |>, repeat

# This import can eventually be removed, it currently just makes sure
# that the iterable tables integration for DataFrames and friends
# is loaded
import IterableTables

export renderer, actionlinks, junoplotpane, png, svg, jgp, pdf, savefig,
    loadspec, savespec, @vl_str


########################  settings functions  ###############################

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


# Switch for showing plots in a browser or in the plotpane when in Juno

global JUNOPLOTPANE = false

"""
`junoplotpane()::Bool`

when using Juno, show if plots will be rendered in plotpane or not

`junoplotpane(::Bool)`

set if plots should be rendered in Juno's plotpane or not
"""
junoplotpane() = JUNOPLOTPANE
junoplotpane(b::Bool) = (global JUNOPLOTPANE ; JUNOPLOTPANE = b)



########################  includes  #####################################

include("typedefs.jl")
include("schema_parsing.jl")
include("func_definition.jl")
include("generated/funcs.jl")
include("generated/documentation.jl")
include("generated/utils.jl")
include("utils.jl")
include("spec_validation.jl")
include("render.jl")
include("juno_integration.jl")
include("io.jl")
include("show.jl")
include("macro.jl")
include("fileio.jl")

### TableTraits.jl integration

function vldata(d)
    TableTraits.isiterabletable(d) || error("Only iterable tables can be passed to vldata.")

    it = IteratorInterfaceExtensions.getiterator(d)

    recs = [Dict(c[1]=>isa(c[2], DataValues.DataValue) ? (isnull(c[2]) ? nothing : get(c[2])) : c[2] for c in zip(keys(r), values(r))) for r in it]

    VegaLite.VLSpec{:data}(Dict("values" => recs))
end

|>(a, b::VLSpec) = vldata(a) |> b

end
