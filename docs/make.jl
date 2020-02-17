using Documenter, VegaLite, UUIDs

function Base.show(io::IO, m::MIME"text/html", v::VegaLite.VLSpec)
    divid = string("vl", replace(string(uuid4()), "-"=>""))
    print(io, "<div style=\"resize:both;overflow:auto;width:50%;height:50%;\" id='$divid'></div>")
    print(io, "<script type='text/javascript'>requirejs.config({paths:{'vg-embed': 'https://cdn.jsdelivr.net/npm/vega-embed@6.2.1?noext','vega-lib': 'https://cdn.jsdelivr.net/npm/vega-lib?noext','vega-lite': 'https://cdn.jsdelivr.net/npm/vega-lite@4.0.2?noext','vega': 'https://cdn.jsdelivr.net/npm/vega@5.9.0?noext'}}); require(['vg-embed'],function(vegaEmbed){vegaEmbed('#$divid',")    
    VegaLite.our_json_print(io, v)
    print(io, ",{mode:'vega-lite'}).catch(console.warn);})")
    print(io, "</script>")
    print(io, "<script type='text/javascript'>if(ResizeObserver){const divContainer=document.querySelector('#$divid');const resizeObserver=new ResizeObserver(entries => {for (let entry of entries) {if(entry.contentBoxSize || entry.contentRect ) {window.dispatchEvent(new Event('resize'));}}});resizeObserver.observe(divContainer);}</script>")
end

function Base.show(io::IO, m::MIME"text/html", v::VegaLite.VGSpec)
    divid = string("vg", replace(string(uuid4()), "-"=>""))
    print(io, "<div style=\"resize:both;overflow:auto;width:50%;height:50%;\" id='$divid'></div>")
    print(io, "<script type='text/javascript'>requirejs.config({paths:{'vg-embed': 'https://cdn.jsdelivr.net/npm/vega-embed@6.2.1?noext','vega-lib': 'https://cdn.jsdelivr.net/npm/vega-lib?noext','vega-lite': 'https://cdn.jsdelivr.net/npm/vega-lite@4.0.2?noext','vega': 'https://cdn.jsdelivr.net/npm/vega@5.9.0?noext'}}); require(['vg-embed'],function(vegaEmbed){vegaEmbed('#$divid',")    
    VegaLite.our_json_print(io, v)
    print(io, ",{mode:'vega'}).catch(console.warn);})")
    print(io, "</script>")
    print(io, "<script type='text/javascript'>if(ResizeObserver){const divContainer=document.querySelector('#$divid');const resizeObserver=new ResizeObserver(entries => {for (let entry of entries) {if(entry.contentBoxSize || entry.contentRect ) {window.dispatchEvent(new Event('resize'));}}});resizeObserver.observe(divContainer);}</script>")
end

makedocs(
  modules=[VegaLite],
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
        "Data sources" => "userguide/data.md",
        "Using Vega" => "userguide/vega.md"
    ],
    "Examples" => Any[
        "Vega-Lite" => [
            "Single-View Plots" => Any[
                "Bar Charts" => "examples/examples_barcharts.md",
                "Histograms, Density Plots, and Dot Plots" => "examples/examples_histograms.md",
                "Scatter & Strip Plots" => "examples/examples_scatter_strip_plots.md",
                "Line Charts" => "examples/examples_line_charts.md",
                "Area Charts & Streamgraphs" => "examples/examples_area_Charts_streamgraphs.md",
                "Table-based Plots" => "examples/examples_table_based_plots.md",
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
        "Vega" => [
            "Bar Charts" => "examples/examples_vega_bar_charts.md",
            "Line & Area Charts" => "examples/examples_vega_line_area_charts.md",
            "Circular Charts" => "examples/examples_vega_circular_charts.md",
            "Scatter Plots" => "examples/examples_vega_scatter_plots.md",
            "Tree Diagrams" => "examples/examples_vega_tree_diagrams.md",
            "Network Diagrams" => "examples/examples_vega_network_diagrams.md",
            "Single Data Source" => "examples/examples_vega_single_data_source.md",
            "Multiple Data Source" => "examples/examples_vega_multi_data_source.md"
        ]
    ],
    "Reference Manual" => [
        "Global settings" => "referencemanual/global.md",
        "Outputs" => "referencemanual/output.md"]
  ]
)

deploydocs(
    repo = "github.com/queryverse/VegaLite.jl.git",
)
