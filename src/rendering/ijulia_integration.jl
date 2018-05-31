######################################################################
#
#     IJulia Integration
#
#     - Works through the definition of show(io::IO, m::MIME"text/html", v::VegaLiteVis)
#     - Signals to Jupyter the required libs (D3, vega, vega-lite)
#
######################################################################

# @require IJulia begin  # define only if/when IJulia is loaded

# Apparently (?) the security model of Jupyter does not allow loading local
# d3, vegalite, .. js files.
#   => libraries are loaded from an internet repository

function Base.show(io::IO, m::MIME"text/html", v::VegaLiteVis)
  divid = "vl" * randstring(10) # generated id for this plot

  fh = """
  <div>
    <div id="$divid"></div>

    <style media="screen">
      .vega-actions a {
        margin-right: 10px;
        font-family: sans-serif;
        font-size: x-small;
        font-style: italic;
      }
    </style>

    <meta charset="utf-8">

    <script type="text/javascript">
      requirejs.config({
          paths: {
            d3: "https://cdnjs.cloudflare.com/ajax/libs/d3/3.5.16/d3.min.js?noext",
            vg: "https://cdnjs.cloudflare.com/ajax/libs/vega/2.6.0/vega.min.js?noext",
            vl: "https://cdnjs.cloudflare.com/ajax/libs/vega-lite/1.2.0/vega-lite.js?noext",
            vg_embed: "https://cdnjs.cloudflare.com/ajax/libs/vega-embed/2.2.0/vega-embed.js?noext"
          },
          shim: {
            vg_embed: {deps: ["vg.global", "vl.global"]},
            vl: {deps: ["vg"]},
            vg: {deps: ["d3"]}
          }
      });

      define('vg.global', ['vg'], function(vgGlobal) {
          window.vg = vgGlobal;
      });

      define('vl.global', ['vl'], function(vlGlobal) {
          window.vl = vlGlobal;
      });

      require(["vg_embed"], function(vg_embed) {
        var vlSpec = $(JSON.json(v.vis));

        var embedSpec = {
          mode: "vega-lite",
          renderer: "$(SVG ? "svg" : "canvas")",
          actions: $SAVE_BUTTONS,
          spec: vlSpec
        };

        vg_embed("#$divid", embedSpec, function(error, result) {});
      })


    </script>

  </div>
  """

  write(io, fh)
end

# end
