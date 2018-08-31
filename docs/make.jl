using Documenter, VegaLite

info("Building docs...")

Pkg.add("DataFrames")
Pkg.add("VegaDatasets")
Pkg.add("Query")

makedocs(
  modules=[VegaLite],
  format=:html,
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
        "Simple Charts" => "examples/examples_simplecharts.md",
        "Single-View Plots" => Any[            
            "Bar Charts & Histograms" => "examples/examples_barchartshistograms.md",
            "Scatter & Strip Plots" => "examples/examples_scatter_strip_plots.md",
            "Line Charts" => "examples/examples_line_charts.md",
            "Area Charts & Streamgraphs" => "examples/examples_area_Charts_streamgraphs.md",
            "Table-based Plots" => "examples/examples_table_based_plots.md"
        ],
        "Layered Plots" => Any[
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
    deps = nothing,
    make = nothing,
    target = "build",
    repo = "github.com/fredo-dedup/VegaLite.jl.git",
    julia = "1.0"
)
