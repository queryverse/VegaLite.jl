######################################################################
#
#     Rendering
#
######################################################################

asset(url...) = normpath(joinpath(vegaliate_app_path, "minified", url...))

#Vega Scaffold: https://github.com/vega/vega/wiki/Runtime

"""
Creates standalone html file for showing the plot (typically in a browser tab).
VegaLite js files are references to local copies.
"""
function writehtml_full(io::IO, spec::VLSpec; title="VegaLite plot")
  divid = "vg" * randstring(3)

  print(io,
  """
  <html>
    <head>
      <title>$title</title>
      <meta charset="UTF-8">
      <script>$(read(asset("vega.min.js"), String))</script>
      <script>$(read(asset("vega-lite.min.js"), String))</script>
      <script>$(read(asset("vega-embed.min.js"), String))</script>
    </head>
    <body>
      <div id="$divid" style="width:100%;height:100%;"></div>
    </body>

    <style media="screen">
      .vega-actions a {
        margin-right: 10px;
        font-family: sans-serif;
        font-size: x-small;
        font-style: italic;
      }
    </style>

    <script type="text/javascript">

      var opt = {
        mode: "vega-lite",
        renderer: "$(Vega.RENDERER)",
        actions: $(Vega.ACTIONSLINKS)
      }

      var spec = """)

  our_json_print(io, spec)
  println(io)

  println(io, """
      vegaEmbed('#$divid', spec, opt);

    </script>

  </html>
  """)
end

function writehtml_full(spec::VLSpec; title="VegaLite plot")
  tmppath = string(tempname(), ".vegalite.html")

  open(tmppath, "w") do io
    writehtml_full(io, spec, title=title)
  end

  tmppath
end

const cdn_versions = (vg="5.6.0", vl="3.4.0", vg_embed="5.1.2")

"""
Creates a HTML script + div block for showing the plot (typically for IJulia).
VegaLite js files are loaded from the web (to accommodate the security model of
IJulia) using requirejs.
"""
function writehtml_partial_require(io::IO, spec::String; title="VegaLite plot")
  divid = "vg" * randstring(3)

  println(io,
  """
  <html>
    <body>
      <div id="$divid" style="width:100%;height:100%;"></div>
    </body>

    <style media="screen">
      .vega-actions a {
        margin-right: 10px;
        font-family: sans-serif;
        font-size: x-small;
        font-style: italic;
      }
    </style>

    <script type="text/javascript">

    requirejs.config({
        paths: {
          vg: "https://cdnjs.cloudflare.com/ajax/libs/vega/$(cdn_versions.vg)/vega.min.js?noext",
          vl: "https://cdnjs.cloudflare.com/ajax/libs/vega-lite/$(cdn_versions.vl)/vega-lite.min.js?noext",
          vg_embed: "https://cdnjs.cloudflare.com/ajax/libs/vega-embed/$(cdn_versions.vg_embed)/vega-embed.min.js?noext"
        },
        shim: {
          vg_embed: {deps: ["vg.global", "vl.global"]},
          vl: {deps: ["vg"]}
        }
    });

    define('vg.global', ['vg'], function(vgGlobal) {
        window.vega = vgGlobal;
    });

    define('vl.global', ['vl'], function(vlGlobal) {
        window.vl = vlGlobal;
    });

    require(["vg_embed"], function(vg_embed) {
      var spec = $spec;

      var opt = {
        mode: "vega-lite",
        renderer: "$(Vega.RENDERER)",
        actions: $(Vega.ACTIONSLINKS)
      }

      vg_embed("#$divid", spec, opt);

    })

    </script>

  </html>
  """)
end

"""
Creates a HTML script + div block for showing the plot (typically for Pluto).
VegaLite js files are loaded from the web using script tags.
"""
function writehtml_partial_script(io::IO, spec::VLSpec; title="VegaLite plot")
  divid = "vg" * randstring(3)
  print(io, """
    <style media="screen">
      .vega-actions a {
        margin-right: 10px;
        font-family: sans-serif;
        font-size: x-small;
        font-style: italic;
      }
    </style>

    <script src="https://cdn.jsdelivr.net/npm/vega@$(cdn_versions.vg)"></script>
    <script src="https://cdn.jsdelivr.net/npm/vega-lite@$(cdn_versions.vl)"></script>
    <script src="https://cdn.jsdelivr.net/npm/vega-embed@$(cdn_versions.vg_embed)"></script>

    <div id="$divid"></div>

    <script>
      var spec = """)
  our_json_print(io, spec)
  print(io,"""
      ;
      var opt = {
        mode: "vega-lite",
        renderer: "$(Vega.RENDERER)",
        actions: $(Vega.ACTIONSLINKS)
      };
      vegaEmbed("#$divid", spec, opt);
    </script>
  """)
end

function Base.display(d::REPL.REPLDisplay, plt::VLSpec)
  # checkplot(plt)
  tmppath = writehtml_full(plt)
  Vega.launch_browser(tmppath) # Open the browser
end
