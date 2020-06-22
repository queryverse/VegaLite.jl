using Documenter, VegaLite, UUIDs

function Base.show(io::IO, m::MIME"text/html", v::VegaLite.VLSpec)
    divid = string("vl", replace(string(uuid4()), "-" => ""))
    print(io, "<div id='$divid' style=\"width:100%;height:100%;\"></div>")
    print(io, "<script type='text/javascript'>requirejs.config({paths:{'vg-embed': 'https://cdn.jsdelivr.net/npm/vega-embed@6?noext','vega-lib': 'https://cdn.jsdelivr.net/npm/vega-lib?noext','vega-lite': 'https://cdn.jsdelivr.net/npm/vega-lite@4?noext','vega': 'https://cdn.jsdelivr.net/npm/vega@5?noext'}}); require(['vg-embed'],function(vegaEmbed){vegaEmbed('#$divid',")
    VegaLite.our_json_print(io, v)
    print(io, ",{mode:'vega-lite'}).catch(console.warn);})</script>")
end

makedocs(
  modules = [VegaLite],
  sitename = "VegaLite.jl",
  pages = [
    "Home" => "index.md",
    "Getting Started" => Any[
        "Installation" => "gettingstarted/installation.md",
        "Tutorial" => "gettingstarted/tutorial.md"
    ],
    "User Guide" => Any[
        "Vega-lite specifications" => "userguide/vlspec.md",
        "The @vlplot command" => "userguide/vlplotmacro.md",
        "Data sources" => "userguide/data.md"
    ],
    "Examples" => Any[
        "Single-View Plots" => Any[
            "Bar Charts" => "examples/examples_barcharts.md",
            "Histograms, Density Plots, and Dot Plots" => "examples/examples_histograms.md",
            "Scatter & Strip Plots" => "examples/examples_scatter_strip_plots.md",
            "Line Charts" => "examples/examples_line_charts.md",
            "Area Charts & Streamgraphs" => "examples/examples_area_Charts_streamgraphs.md",
            "Table-based Plots" => "examples/examples_table_based_plots.md",
            "Circular Plots" => "examples/examples_circular_plots.md",
            "Advanced Calculations" => "examples/examples_advancedcalculations.md"
        ],
        "Composite Mark" => Any[
            "Error Bars & Error Bands" => "examples/examples_error_bars_bands.md",
            "Box Plots" => "examples/examples_box_plots.md"
        ],
        "Multi-View Displays" => Any[
            "Faceting (Trellis Plot / Small Multiples)" => "examples/examples_faceting.md",
            "Repeat & Concatenation" => "examples/examples_repeat_concatenation.md"
        ],
        "Maps (Geographic Displays)" => "examples/examples_maps.md"
    ],
    "Reference Manual" => [
        "Global settings" => "referencemanual/global.md",
        "Outputs" => "referencemanual/output.md"]
  ]
)

deploydocs(
    repo = "github.com/queryverse/VegaLite.jl.git",
)
