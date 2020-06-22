using Test
using VegaLite
using Vega
using Dates

@testset "VegaLite" begin

    include("testhelper_create_vg_plot.jl")
    include("test_io.jl")
    include("test_show.jl")
    include("test_base.jl")
    include("test_macro.jl")
    include("test_shorthand.jl")
    include("test_spec.jl")
    include("test_vg.jl")
    include("test_vlplot_macro.jl")
    include("test_properties.jl")
    include("test_inlinedata.jl")
    include("test_positional.jl")

end
