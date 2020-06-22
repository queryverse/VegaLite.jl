@time using VegaLite

module VegaLite ; end

using VegaLite # 55s w/ precompilation, 23s w/o precompilation
using NamedTuples
using ElectronDisplay

############################################################


############################################################################

# TODO le schema json ne contient pas la def de "brush", ni "grid"

rooturl = "https://raw.githubusercontent.com/vega/new-editor/master/data/"
dataurl = rooturl * "data/cars.json"

plot(
    rep(row    = ["Horsepower","Acceleration"],
        column = ["Horsepower", "Miles_per_Gallon"]),
    spec(
        data(url = durl),
        mk.point(),
        selection(
            brush = @NT(
                typ = "interval", resolve = "union",
                encodings = ["x"],
                on = "[mousedown[event.shiftKey], mouseup] > mousemove",
                translate = "[mousedown[event.shiftKey], mouseup] > mousemove"),
            grid = @NT(
                typ = "interval", resolve = "global", bind = "scales",
                translate = "[mousedown[!event.shiftKey], mouseup] > mousemove") ),
        enc.x.quantitative(@NT(repeat = :row)),
        enc.y.quantitative(@NT(repeat = :column)),
        enc.color.nominal(:Origin, condition = @NT(selection = "!brush", value = :grey))
                    )
     ) |> display
