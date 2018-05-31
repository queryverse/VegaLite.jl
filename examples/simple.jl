using VegaLite

src = "https://raw.githubusercontent.com/vega/new-editor/master/data/movies.json"

# Syntax 1 : using named tuples

plot(
    data = @NT(url = src),
    mark = @NT(typ = :circle),
    encoding = @NT(
        x = @NT(
            field= :IMDB_Rating,
            typ = :quantitative,
            bin=@NT(maxbins=10)),
        y = @NT(
            field= :Rotten_Tomatoes_Rating,
            typ = :quantitative,
            bin=@NT(maxbins=10)),
        size = @NT(
            aggregate = :count,
            typ = :quantitative )) ) |> display
    

# Syntax 2 : using shorcut functions

plot(
    data(url=src),
    mk.circle(),
    enc.x.quantitative(:IMDB_Rating, bin=@NT(maxbins=10)),
    enc.y.quantitative(:Rotten_Tomatoes_Rating, bin=@NT(maxbins=10)),
    enc.size.quantitative(:*, aggregate=:count) ) |> display
