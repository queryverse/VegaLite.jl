# VegaLite.jl

_Julia bindings to Vega-Lite_

[![Project Status: Active - The project has reached a stable, usable state and is being actively developed.](http://www.repostatus.org/badges/latest/active.svg)](http://www.repostatus.org/#active)
[![](https://img.shields.io/badge/docs-stable-blue.svg)](https://www.queryverse.org/VegaLite.jl/stable/)
[![Run CI on main](https://github.com/queryverse/VegaLite.jl/actions/workflows/jlpkgbutler-ci-master-workflow.yml/badge.svg)](https://github.com/queryverse/VegaLite.jl/actions/workflows/jlpkgbutler-ci-master-workflow.yml)
[![codecov](https://codecov.io/gh/queryverse/VegaLite.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/queryverse/VegaLite.jl)

## Overview

[VegaLite.jl](https://github.com/queryverse/VegaLite.jl) is a plotting package for the [julia](https://julialang.org/) programming language. The package is based on [Vega-Lite](https://vega.github.io/vega-lite/), which extends a traditional [grammar of graphics](https://doi.org/10.1007/0-387-28695-0) API into a [grammar of interactive graphics](https://doi.org/10.1109/TVCG.2016.2599030).

Additionally, [VegaLite.jl](https://github.com/queryverse/VegaLite.jl) provides basic support for [Vega](https://vega.github.io/vega).

[VegaLite.jl](https://github.com/queryverse/VegaLite.jl) allows you to create a wide range of statistical plots. It exposes the full functionality of the underlying [Vega-Lite](https://vega.github.io/vega-lite/) and is at the same time tightly integrated into the julia ecosystem. Here is an example of a scatter plot:

```@example
using VegaLite, VegaDatasets

dataset("cars") |>
@vlplot(
    :point,
    x=:Horsepower,
    y=:Miles_per_Gallon,
    color=:Origin,
    width=400,
    height=400
)
```
![plot](assets/readme_plot1.svg)

## Installation

To install [VegaLite.jl](https://github.com/queryverse/VegaLite.jl), run the following command in the julia Pkg REPL-mode:

````julia
(v1.0) pkg> add VegaLite
````

## Documentation

The current documentation can be found [here](https://queryverse.github.io/VegaLite.jl/stable).

## Note for Jupyterlab Users

[VegaLite.jl](https://github.com/queryverse/VegaLite.jl) can be used in combination with many different front end clients including [JupyterLab](https://jupyterlab.readthedocs.io/en/stable/), [Pluto.jl](https://github.com/fonsp/Pluto.jl), and [Julia for VSCode](https://www.julia-vscode.org).

**Important:** [JupyterLab](https://jupyterlab.readthedocs.io/en/stable/) supplies its own version of [Vega-Lite](https://vega.github.io/vega-lite/) and *cannot* be kept in perfect sync with [VegaLite.jl](https://github.com/queryverse/VegaLite.jl). Formatting discrepancies **can** and **will** arise on occasion for [JupyterLab](https://jupyterlab.readthedocs.io/en/stable/) users. [VegaLite.jl](https://github.com/queryverse/VegaLite.jl) targets the latest available minor release of [Vega-Lite](https://vega.github.io/vega-lite/) which is also supported by [JupyterLab](https://jupyterlab.readthedocs.io/en/stable/).

## Developer Notes

JupyterLab support depends on Juperlab's built-in renderer; before updating to a new major version of vega-lite, check the [JupyterLab project](https://github.com/jupyterlab/jupyterlab/blob/master/packages/vega5-extension/package.json#L42) for the latest supported version of vega-lite.
