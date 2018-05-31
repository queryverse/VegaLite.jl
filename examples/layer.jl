using VegaLite

# Example 1 : interpolation mode comparisons

df  = DataFrame(x=[0:5;], y=rand(6))

encx = enc.x.quantitative(:x)
ency = enc.y.quantitative(:y)

plot(
    data(df),
    width=300, background=:white,
    layer= [ (mk.line(interpolate="linear"), encx, ency, enc.color.value(:green) ),
             (mk.line(interpolate="basis"),  encx, ency, enc.color.value(:red)   ),
             (mk.point(),                    encx, ency, enc.color.value(:black)) ] )


# Example 2 : closed shape w/ points

r, nb = 5., 10
df = DataFrame(n = [1:nb;],
               x = r * (0.2 + rand(nb)) .* cos.(2π * linspace(0,1,nb)),
               y = r * (0.2 + rand(nb)) .* sin.(2π * linspace(0,1,nb)))

encx = enc.x.quantitative(:x, scale=@NT(zero=false))
ency = enc.y.quantitative(:y, scale=@NT(zero=false))
encn = enc.order.quantitative(:n)
encgreen = enc.color.value(:green)
encblack = enc.color.value(:black)
enc50 = enc.size.value(50)

plot(
    data(df),
    width=300, background=:white,
    layer= [ (mk.line(interpolate="cardinal-closed"), encx, ency, encn, encgreen ),
             (mk.point(), encx, ency, encblack, enc50) ] )

# Example 3 : error bars

rooturl = "https://raw.githubusercontent.com/vega/new-editor/master/"
durl = rooturl * "data/population.json"

xchan = enc.x.ordinal(:age, axis=@NT(labelAngle=-45))

ymin = enc.y.quantitative(:people, aggregate=:min, axis=@NT(title="population"))
ymax = enc.y.quantitative(:people, aggregate=:max, axis=@NT(title="population"))
y2max = enc.y2.quantitative(:people, aggregate=:max)
ymean = enc.y.quantitative(:people, aggregate=:mean, axis=@NT(title="population"))

size10 = enc.size.value(10)
colblack = enc.color.value(:black)

plot(
    data(url=durl),
    transform([@NT(filter="datum.year==2000")]),
    layer((mk.tick(),  xchan, ymin,  size10, colblack),
          (mk.tick(),  xchan, ymax,  size10,  colblack),
          (mk.rule(),  xchan, ymin,  y2max,  colblack),
          (mk.point(filled=true), xchan, ymean, enc.size.value(30)))
    )
