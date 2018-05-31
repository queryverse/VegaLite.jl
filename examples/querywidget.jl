using VegaLite
using NamedTuples

rooturl = "https://raw.githubusercontent.com/vega/new-editor/master/"
durl = rooturl * "data/cars.json"

layer1 = (selection(CylYr=@NT(typ=:single, fields=["Cylinders", "Year"],
                              bind=@NT(Cylinders=@NT(input=:range, min=3, max=8, step=1),
                                       Year=@NT(input=:range, min=1969, max=1981, step=1) ))),
          mk.circle(),
          enc.x.quantitative(:Horsepower),
          enc.y.quantitative(:Miles_per_Gallon),
          enc.color.value(:grey, condition=@NT(selection=:CylYr, field=:Origin, typ=:nominal)))

layer2 = (transform([@NT(filter=@NT(selection=:CylYr))]),
          mk.circle(),
          enc.x.quantitative(:Horsepower),
          enc.y.quantitative(:Miles_per_Gallon),
          enc.color.nominal(:Origin),
          enc.size.value(100))

plot(
    data(url=durl),
    description="Drag the sliders to highlight points.",
    layer(layer1, layer2) )
