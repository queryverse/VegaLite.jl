# download javascript files

using BinDeps
@BinDeps.setup

# uschema = "https://vega.github.io/schema/vega-lite/v2.json"

uvega     = "https://cdnjs.cloudflare.com/ajax/libs/vega/3.1.0/vega.min.js"
uvegalite = "https://cdnjs.cloudflare.com/ajax/libs/vega-lite/2.1.3/vega-lite.min.js"
uembed    = "https://cdnjs.cloudflare.com/ajax/libs/vega-embed/3.0.0/vega-embed.min.js"

destdir      = joinpath(@__DIR__, "lib")

run(@build_steps begin
  CreateDirectory(destdir, true)
  # FileDownloader(uschema,   joinpath(destdir, basename(uschema)))
  FileDownloader(uvega,     joinpath(destdir, basename(uvega)))
  FileDownloader(uvegalite, joinpath(destdir, basename(uvegalite)))
  FileDownloader(uembed,    joinpath(destdir, basename(uembed)))
end)

# install NodeJS modules
using NodeJS
using Compat

run(Cmd(`$(npm_cmd()) install --production --no-bin-links --no-package-lock --no-optional`, dir=@__DIR__))
