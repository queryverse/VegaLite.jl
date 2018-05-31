using VegaLite
using NamedTuples

rooturl = "https://raw.githubusercontent.com/vega/new-editor/master/"
durl = rooturl * "data/flights-2k.json"

layer1 = (selection(brush=@NT(typ=:interval, encodings=[:x])),
          mk.bar(),
          enc.x.quantitative(@NT(repeat=:column), bin=@NT(maxbins=20)),
          enc.y.quantitative(:*, aggregate=:count) )

layer2 = (transform([@NT(filter=@NT(selection=:brush))]),
          mk.bar(),
          enc.x.quantitative(@NT(repeat=:column), bin=@NT(maxbins=20)),
          enc.y.quantitative(:*, aggregate=:count),
          enc.color.value(:goldenrod) )

plot(
    data(url=durl, format=@NT(parse=@NT(date=:date))),
    transform([@NT(calculate="hours(datum.date)", as=:time)]),
    rep(column=["distance", "delay", "time"]),
    spec( layer(layer1, layer2) ) ) 
