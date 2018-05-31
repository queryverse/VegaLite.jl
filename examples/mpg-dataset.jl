using VegaLite
using RDatasets

mpg = dataset("ggplot2", "mpg") # load the 'mpg' dataframe

# Scatter plot

mpg |>                             # add values (qualify 'data' because it is exported by RDatasets too)
  plot(mk.point(),                 # mark type = points
       enc.x.quantitative(:Cty),   # bind x dimension to :Cty field in mpg
       enc.y.quantitative(:Hwy))   # bind y dimension to :Hwy field in mpg

# Scatter plot with color encoding manufacturer

mpg |>
  plot(
    mk.point(),
    enc.x.quantitative(:Cty, axis=nothing),
    enc.y.quantitative(:Hwy, scale=@NT(zero=false)),
    enc.color.nominal(:Manufacturer),
    width=250, height=250)

# A slope graph:

mpg |>
  plot(
    mk.line(),
    enc.x.ordinal(:Year, axis=@NT(labelAngle=-45, labelPadding=10),
                  scale=@NT(rangeStep=50)),
    enc.y.quantitative(:Hwy, aggregate=:mean),
    enc.color.nominal(:Manufacturer))

# A facetted plot:

mpg |>
  plot(
    mk.point(),
    enc.column.ordinal(:Cyl), # sets the column facet dimension
    enc.row.ordinal(:Year),   # sets the row facet dimension
    enc.x.quantitative(:Displ),
    enc.y.quantitative(:Hwy),
    enc.size.quantitative(:Cty),
    enc.color.nominal(:Manufacturer))


# A table:

mpg |>
  plot(
    mk.text(),
    enc.x.ordinal(:Cyl), # sets the column facet dimension
    enc.y.ordinal(:Year),   # sets the row facet dimension
    enc.text.quantitative(:Displ, aggregate=:mean),
    background=:white,
    config(
        numberFormat=".2r",
        mark=@NT( fontStyle="italic", fontSize=15, font="helvetica") ))
