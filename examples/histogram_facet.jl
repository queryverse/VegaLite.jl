using VegaLite
using NamedTuples
using DataFrames

## histograms by group

df= DataFrame(group=rand(0:1, 200))
df[:x] = df[:group]*2 + randn(size(df,1))

plot(
    data(df),
    facet(column=@NT(typ=:nominal, field=:group)),
    spec(
        mk.bar(),
        enc.x.quantitative(:x, bin=@NT(maxbins=15)),
        enc.y.quantitative(:*, aggregate=:count),
        enc.color.nominal(:group)
    ) )
