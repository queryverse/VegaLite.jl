######################################################################
#
#     Rendering
#
######################################################################

asset(url...) = normpath(joinpath(@__DIR__, "../..", "assets", "vega", url...))

#Vega Scaffold: https://github.com/vega/vega/wiki/Runtime

"""
Creates standalone html file for showing the plot (typically in a browser tab).
VegaLite js files are references to local copies.
"""
function writehtml_full(io::IO, spec::String; title="VegaLite plot")
  divid = "vg" * randstring(3)

  println(io,
  """
  <html>
    <head>
      <title>$title</title>
      <meta charset="UTF-8">
      <script src="file://$(asset("vega.min.js"))"></script>
      <script src="file://$(asset("vega-lite.min.js"))"></script>
      <script src="file://$(asset("vega-embed.min.js"))"></script>
    </head>
    <body>
      <div id="$divid"></div>
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
        renderer: "$RENDERER",
        actions: $ACTIONSLINKS
      }

      var spec = $spec

      vegaEmbed('#$divid', spec, opt);

    </script>

  </html>
  """)
end

function writevghtml_full(io::IO, spec::String; title="Vega plot")
  divid = "vg" * randstring(3)

  println(io,
  """
  <html>
    <head>
      <title>$title</title>
      <meta charset="UTF-8">
      <script src="file://$(asset("vega.min.js"))"></script>
      <script src="file://$(asset("vega-embed.min.js"))"></script>
    </head>
    <body>
      <div id="$divid"></div>
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
        mode: "vega",
        renderer: "$RENDERER",
        actions: $ACTIONSLINKS
      }

      var spec = $spec

      vegaEmbed('#$divid', spec, opt);

    </script>

  </html>
  """)
end

function writehtml_full(spec::String; title="VegaLite plot")
  tmppath = string(tempname(), ".vegalite.html")

  open(tmppath, "w") do io
    writehtml_full(io, spec, title=title)
  end

  tmppath
end

function write_vg_html_full(spec::String; title="Vega plot")
  tmppath = string(tempname(), ".vega.html")

  open(tmppath, "w") do io
    writevghtml_full(io, spec, title=title)
  end

  tmppath
end



"""
Creates a HTML script + div block for showing the plot (typically for IJulia).
VegaLite js files are loaded from the web (to accommodate the security model of
IJulia) using requirejs.
"""
function writehtml_partial(io::IO, spec::String; title="VegaLite plot")
  divid = "vg" * randstring(3)

  println(io,
  """
  <html>
    <body>
      <div id="$divid"></div>
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
          vg: "https://cdnjs.cloudflare.com/ajax/libs/vega/5.6.0/vega.min.js?noext",
          vl: "https://cdnjs.cloudflare.com/ajax/libs/vega-lite/3.4.0/vega-lite.min.js?noext",
          vg_embed: "https://cdnjs.cloudflare.com/ajax/libs/vega-embed/5.1.2/vega-embed.min.js?noext"
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
        renderer: "$RENDERER",
        actions: $ACTIONSLINKS
      }

      vg_embed("#$divid", spec, opt);

    })

    </script>

  </html>
  """)
end

"""
opens a browser tab with the given html file
"""
function launch_browser(tmppath::String)
  if Sys.isapple()
    run(`open $tmppath`)
  elseif Sys.iswindows()
    run(`cmd /c start $tmppath`)
  elseif Sys.islinux()
    run(`xdg-open $tmppath`)
  end
end


function Base.display(d::REPL.REPLDisplay, plt::VLSpec{:plot})
  # checkplot(plt)
  tmppath = writehtml_full(render_json(plt))
  launch_browser(tmppath) # Open the browser
end

function Base.display(d::REPL.REPLDisplay, plt::VGSpec)
  tmppath = write_vg_html_full(JSON.json(getparams(plt)))
  launch_browser(tmppath) # Open the browser
end

render_json(x) = sprint(render_json, x)
render_json(io::IO, plt::VLSpec) =
    JSON.print(io, getparams(with_stripped_data(plt)))
