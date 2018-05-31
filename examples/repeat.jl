using Distributions
using DataFrames
using VegaLite

xs = rand(Normal(), 100, 3)
dt = DataFrame(a = xs[:,1] + xs[:,2] .^ 2,
               b = xs[:,3] .* xs[:,2],
               c = xs[:,3] .+ xs[:,2])

dt |>
    plot(
        rep(column = [:a, :b, :c], row = [:a, :b, :c]),
        spec(
            width=100, height=100,
            mk.point(),
            enc.x.quantitative(@NT(repeat=:column)),
            enc.y.quantitative(@NT(repeat=:row))) )
