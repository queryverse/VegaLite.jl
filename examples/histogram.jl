using VegaLite
using DataFrames

# a simple histogram of random standard normal draws
DataFrame(x=randn(200)) |>
  plot(
    mk.bar(),
    enc.x.quantitative(:x, bin=@NT(maxbins=20), axis=@NT(title="values")),
    enc.y.quantitative(:*, aggregate=:count, axis=@NT(title="number of draws"))
  )
