# Vega-lite specifications

A [Vega-Lite](https://vega.github.io/vega-lite/) plot specification is represented as a `VLSpec` object in Julia. There are multiple ways to create a `VLSpec` object:
1. The `@vlplot` macro is the main way to create `VLSpec` instances in code.
2. Using the `vl` string macro, you can write [Vega-Lite](https://vega.github.io/vega-lite/) specifications as JSON in your Julia code.
3. You can load [Vega-Lite](https://vega.github.io/vega-lite/) specifications from disc with the `load` function.
4. The [DataVoyager.jl](https://github.com/queryverse/DataVoyager.jl) package provides a graphical user interface that you can use to create [Vega-Lite](https://vega.github.io/vega-lite/) specification.

There are two main things one can do with a `VLSpec` object:
1. One can display it in various front ends.
2. One can save the plot to disc in various formats using the `save` function.

This section will give a brief overview of these options. Other sections will describe each option in more detail.

## The `@vlplot` macro

The `@vlplot` macro is the main way to specify plots in [VegaLite.jl](https://github.com/queryverse/VegaLite.jl). The macro uses a syntax that is closely aligned with the JSON format of the original [Vega-Lite](https://vega.github.io/vega-lite/) specification. It is very simple to take a vega-lite specification and "translate" it into a corresponding `@vlplot` macro call. In addition, the macro provides a number of convenient syntax features that allow for a concise expression of common vega-lite patterns. These shorthands give [VegaLite.jl](https://github.com/queryverse/VegaLite.jl) a syntax that can be used in a productive way for exploratory data analysis.

A very simple [Vega-Lite](https://vega.github.io/vega-lite/) JSON specification looks like this:

```json
{
  "data": {
    "values": [
      {"a": "A","b": 28}, {"a": "B","b": 55}, {"a": "C","b": 43},
      {"a": "D","b": 91}, {"a": "E","b": 81}, {"a": "F","b": 53},
      {"a": "G","b": 19}, {"a": "H","b": 87}, {"a": "I","b": 52}
    ]
  },
  "mark": "bar",
  "encoding": {
    "x": {"field": "a", "type": "ordinal"},
    "y": {"field": "b", "type": "quantitative"}
  }
}
```

This can be directly translated into the following `@vlplot` macro call:

```julia
using VegaLite

@vlplot(
    data={
        values=[
            {a="A",b=28},{a="B",b=55},{a="C",b=43},
            {a="D",b=91},{a="E",b=81},{a="F",b=53},
            {a="G",b=19},{a="H",b=87},{a="I",b=52}
        ]
    },
    mark="bar",
    encoding={
        x={field="a", type="ordinal"},
        y={field="b", type="quantitative"}
    }
)
```

The main difference between JSON and the `@vlplot` macro is that keys are not surrounded by quotation marks in the macro, and key-value pairs are separate by a `=` (instead of a `:`).

While these literal translations of JSON work, they are also quite verbose. The `@vlplot` macro provides a number of shorthands so that the same plot can be expressed in a much more concise manner. The following example creates the same plot, but uses a number of alternative syntaxes provided by the `@vlplot` macro:

```julia
using VegaLite, DataFrames

data = DataFrame(
    a=["A","B","C","D","E","F","G","H","I"],
    b=[28,55,43,91,81,53,19,87,52]
)

data |> @vlplot(:bar, :a, :b)
```

Typically you should use these shorthands so that you can express your plots in a concise way. The various shorthands are described in more detail in a different chapter.

## The `vl` string macro

One can embed a JSON vega-lite specification directly in Julia code by using the `vl` string macro:

```julia
using VegaLite

spec = vl"""
{
  "$schema": "https://vega.github.io/schema/vega-lite/v2.json",
  "description": "A simple bar chart with embedded data.",
  "data": {
    "values": [
      {"a": "A","b": 28}, {"a": "B","b": 55}, {"a": "C","b": 43},
      {"a": "D","b": 91}, {"a": "E","b": 81}, {"a": "F","b": 53},
      {"a": "G","b": 19}, {"a": "H","b": 87}, {"a": "I","b": 52}
    ]
  },
  "mark": "bar",
  "encoding": {
    "x": {"field": "a", "type": "ordinal"},
    "y": {"field": "b", "type": "quantitative"}
  }
}
"""
```

The resulting `VLSpec` object is indistinguishable from one that is created via the `@vlplot` macro.

The main benefit of this approach is that one can directly leverage JSON vega-lite examples and code.

**NOTE:** A JSON spec can be shown in the `@vlplot` style using `Vega.printrepr` - see "Next Steps" in the tutorial for an example.

## Manipulating `VLSpec` object directly

Vega-Lite properties can be directly accessed as properties of the `VLSpec` object.

```julia
julia> using VegaLite, VegaDatasets

julia> spec = dataset("cars") |>
              @vlplot(:point, x=:Acceleration, y=:Cylinders)

julia> spec.mark
:point

julia> spec.encoding.x.field
"Acceleration"
```

To modify properties, use [Setfield.jl](https://github.com/jw3126/Setfield.jl):

```julia
julia> using Setfield  # imports `@set` etc.

julia> spec2 = @set spec.mark = :line
       spec3 = @set spec2.encoding.y.field = "Miles_per_Gallon"
```

## Loading and saving vega-lite specifications

The `load` and `savefig` functions can be used to load and save vega-lite specifications to and from disc. The following example loads a vega-lite specification from a file named `myfigure.vegalite`:

```julia
using VegaLite

spec = load("myfigure.vegalite")
```

To save a `VLSpec` to a file on disc, use the `save` function:

```julia
using VegaLite

spec = ... # Aquire a spec from somewhere

spec |> savefig("myfigure.vegalite")
```

## [DataVoyager.jl](https://github.com/queryverse/DataVoyager.jl)

The [DataVoyager.jl](https://github.com/queryverse/DataVoyager.jl) package provides a graphical UI for data exploration that is based on vega-lite. One can use that tool to create a figure in the UI, and then export the corresponding vega-lite specification for use with this package here.

## Displaying plots

[VegaLite.jl](https://github.com/queryverse/VegaLite.jl) integrates into the default Julia multimedia system for viewing plots. This means that in order to show a plot `p` you would simply call the `display(p)` function. Most interactive Julia environments (REPL, IJulia, Jupyter Lab, nteract etc.) automatically call `display` on the value of the last interactive command for you.

Simply viewing plots should work out of the box in all known Julia environments. If you plan to use the interactive features of [VegaLite.jl](https://github.com/queryverse/VegaLite.jl) the story becomes slightly more nuanced: while many environments (REPL, [Jupyter Lab](https://github.com/jupyterlab/jupyterlab), [nteract](https://github.com/nteract/nteract), [ElectronDisplay.jl](https://github.com/queryverse/ElectronDisplay.jl), [VS Code](https://www.julia-vscode.org/)) support interactive [VegaLite.jl](https://github.com/queryverse/VegaLite.jl) plots by default, there are others that either need some extra configuration work ([Jupyter Notebook](http://jupyter.org/)), or don't support interactive plots.

## Saving plots

[VegaLite.jl](https://github.com/queryverse/VegaLite.jl) plots can be saved as [PNG](https://en.wikipedia.org/wiki/Portable_Network_Graphics), [SVG](https://en.wikipedia.org/wiki/Scalable_Vector_Graphics), [PDF](https://en.wikipedia.org/wiki/PDF), [EPS](https://en.wikipedia.org/wiki/Encapsulated_PostScript) and HTML files. You can save a plot by calling the `savefig` function:

```julia
using VegaLite, VegaDatasets

p = dataset("cars") |> @vlplot(:point, x=:Horsepower, y=:Miles_per_Gallon)

# Save as PNG file
savefig("figure.png", p)

# Save as SVG file
savefig("figure.svg", p)

# Save as PDF file
savefig("figure.pdf", p)

# Save EPS file
savefig("figure.eps", p)

# Save HTML file
savefig("figure.html", p)
```

You can also use the `|>` operator with the `save` function:

```julia
using VegaLite, VegaDatasets

dataset("cars") |>
    @vlplot(:point, x=:Horsepower, y=:Miles_per_Gallon) |>
    savefig("figure.png")
```
