using VegaLite
using NamedTuples

rooturl = "https://raw.githubusercontent.com/vega/new-editor/master/"
topourl = rooturl * "data/us-10m.json"
dataurl = rooturl * "data/unemployment.tsv"

plot(
    width=500, height=400,
    data(url=topourl, format=@NT(typ=:topojson, feature=:counties)),
    transform([@NT(
        lookup=:id,
        from=@NT(
            data=@NT(url=dataurl),
            key=:id,
            fields=[:rate]) )]),
    projection=@NT(typ=:albersUsa),
    mk.geoshape(),
    enc.color.quantitative(:rate) )
