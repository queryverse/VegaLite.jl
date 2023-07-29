## Choropleth of unemployment rate per county

```@example
using VegaLite, VegaDatasets

us10m = dataset("us-10m")
unemployment = dataset("unemployment")

@vlplot(
    :geoshape,
    width=500, height=300,
    data={
        values=us10m,
        format={
            type=:topojson,
            feature=:counties
        }
    },
    transform=[{
        lookup=:id,
        from={
            data=unemployment,
            key=:id,
            fields=["rate"]
        }
    }],
    projection={
        type=:albersUsa
    },
    color="rate:q"
)
```

## One dot per zipcode in the U.S.

```@example
using VegaLite, VegaDatasets

dataset("zipcodes") |>
@vlplot(
    :circle,
    width=500, height=300,
    transform=[{calculate="substring(datum.zip_code, 0, 1)", as=:digit}],
    projection={type=:albersUsa},
    longitude=:longitude,
    latitude=:latitude,
    size={value=1},
    color="digit:n"
)
```

## One dot per airport in the US overlayed on geoshape

```@example
using VegaLite, VegaDatasets

us10m = dataset("us-10m")
airports = dataset("airports")

@vlplot(width=500, height=300) +
@vlplot(
    mark={
        :geoshape,
        fill=:lightgray,
        stroke=:white
    },
    data={
        values=us10m,
        format={
            type=:topojson,
            feature=:states
        }
    },
    projection={type=:albersUsa},
) +
@vlplot(
    :circle,
    data=airports,
    projection={type=:albersUsa},
    longitude="longitude:q",
    latitude="latitude:q",
    size={value=10},
    color={value=:steelblue}
)
```

## Rules (line segments) connecting SEA to every airport reachable via direct flight

```@example
using VegaLite, VegaDatasets

us10m = dataset("us-10m")
airports = dataset("airports")
flightsairport = dataset("flights-airport")

@vlplot(width=800, height=500) +
@vlplot(
    mark={
        :geoshape,
        fill=:lightgray,
        stroke=:white
    },
    data={
        values=us10m,
        format={
            type=:topojson,
            feature=:states
        }
    },
    projection={type=:albersUsa}
) +
@vlplot(
    :circle,
    data=airports,
    projection={type=:albersUsa},
    longitude="longitude:q",
    latitude="latitude:q",
    size={value=5},
    color={value=:gray}
) +
@vlplot(
    :rule,
    data=flightsairport,
    transform=[
        {filter={field=:origin,equal=:SEA}},
        {
            lookup=:origin,
            from={
                data=airports,
                key=:iata,
                fields=["latitude", "longitude"]
            },
            as=["origin_latitude", "origin_longitude"]
        },
        {
            lookup=:destination,
            from={
                data=airports,
                key=:iata,
                fields=["latitude", "longitude"]
            },
            as=["dest_latitude", "dest_longitude"]
        }
    ],
    projection={type=:albersUsa},
    longitude="origin_longitude:q",
    latitude="origin_latitude:q",
    longitude2="dest_longitude:q",
    latitude2="dest_latitude:q"
)
```

## Three choropleths representing disjoint data from the same table

```@example
using VegaLite, VegaDatasets

us10m = dataset("us-10m")
rows = dataset("population_engineers_hurricanes")

@vlplot(
    title="The population per state, engineers per state, and hurricanes per state",
    repeat={
        row=["population", "engineers", "hurricanes"]
    },
    resolve={
        scale={
            color=:independent
        }
    }
) +
@vlplot(
    width=500,
    height=300,
    data=rows,
    transform=[{
        lookup=:id,
        from={
            data={
                values=us10m,
                format={
                    type=:topojson,
                    feature=:states
                }
            },
            key=:id
        },
        as=:geo
    }],
    projection={type=:albersUsa},
    mark=:geoshape,
    shape={
        field=:geo,
        type=:geojson
    },
    color={
        field={repeat=:row},
        type=:quantitative
    }
)
```

## U.S. state capitals overlayed on a map of the U.S

```@example
using VegaLite, VegaDatasets

us10m = dataset("us-10m")
capitals = dataset("us-state-capitals")

@vlplot(width=800, height=500) +
@vlplot(
    mark={
        :geoshape,
        fill=:lightgray,
        stroke=:white
    },
    data={
        values=us10m,
        format={
            type=:topojson,
            feature=:states
        }
    },
    projection={type=:albersUsa},
) +
@vlplot(
    :circle,
    data=capitals,
    longitude="lon:q",
    latitude="lat:q",
    color={value=:orange}
) +
@vlplot(
    mark={
        type=:text,
        dy=-10
    },
    data=capitals,
    longitude="lon:q",
    latitude="lat:q",
    text={
        field=:city,
        type=:nominal
    }
)
```

## Line drawn between airports in the U.S. simulating a flight itinerary

```@example
using VegaLite, VegaDatasets

us10m = dataset("us-10m")
airports = dataset("airports")

@vlplot(width=800, height=500) +
@vlplot(
    mark={
        :geoshape,
        fill="#eee",
        stroke=:white
    },
    data={
        values=us10m,
        format={
            type=:topojson,
            feature=:states
        }
    },
    projection={type=:albersUsa},
) +
@vlplot(
    :circle,
    data=airports,
    projection={type=:albersUsa},
    longitude="longitude:q",
    latitude="latitude:q",
    size={value=5},
    color={value=:gray}
) +
@vlplot(
    :line,
    data={
        values=[
            {airport=:SEA,order=1},
            {airport=:SFO,order=2},
            {airport=:LAX,order=3},
            {airport=:LAS,order=4},
            {airport=:DFW,order=5},
            {airport=:DEN,order=6},
            {airport=:ORD,order=7},
            {airport=:JFK,order=8}
        ]
    },
    transform=[{
        lookup=:airport,
        from={
            data=airports,
            key=:iata,
            fields=["latitude","longitude"]
        }
    }],
    projection={type=:albersUsa},
    longitude="longitude:q",
    latitude="latitude:q",
    order={field=:order,type=:ordinal}
)
```

## Income in the U.S. by state, faceted over income brackets

```@example
using VegaLite, VegaDatasets

us10m = dataset("us-10m")
income = dataset("income")

@vlplot(
    width=500, 
    height=300,
    :geoshape,
    data=income,
    transform=[{
        lookup=:id,
        from={
            data={
                values=us10m,
                format={
                    type=:topojson,
                    feature=:states
                }
            },
            key=:id
        },
        as=:geo
    }],
    projection={type=:albersUsa},
    encoding={
        shape={field=:geo,type=:geojson},
        color={field=:pct,type=:quantitative},
        row={field=:group,type=:nominal}
    }
)
```

## London Tube Lines

```@example
using VegaLite, VegaDatasets

londonBoroughs = dataset("londonBoroughs")
londonCentroids = dataset("londonCentroids")
londonTubeLines = dataset("londonTubeLines")

@vlplot(
    width=700, height=500,
    config={
        view={
            stroke=:transparent
        }
    }
) +
@vlplot(
    data={
        values=londonBoroughs,
        format={
            type=:topojson,
            feature=:boroughs
        }
    },
    mark={
        :geoshape,
        stroke=:white,
        strokeWidth=2
    },
    color={value="#eee"}
) +
@vlplot(
    data=londonCentroids,
    transform=[{
        calculate="indexof (datum.name,' ') > 0  ? substring(datum.name,0,indexof(datum.name, ' ')) : datum.name",
        as=:bLabel
    }],
    mark=:text,
    longitude="cx:q",
    latitude="cy:q",
    text="bLabel:n",
    size={value=8},
    opacity={value=0.6}
) +
@vlplot(
    data={
        values=londonTubeLines,
        format={
            type=:topojson,
            feature=:line
        }
    },
    mark={
        :geoshape,
        filled=false,
        strokeWidth=2
    },
    color={
        "id:n",
        legend={
            title=nothing,
            orient="bottom-right",
            offset=0
        },
        scale={
            domain=[
                "Bakerloo",
                "Central",
                "Circle",
                "District",
                "DLR",
                "Hammersmith & City",
                "Jubilee",
                "Metropolitan",
                "Northern",
                "Piccadilly",
                "Victoria",
                "Waterloo & City"
            ],
            range=[
                "rgb(137,78,36)",
                "rgb(220,36,30)",
                "rgb(255,206,0)",
                "rgb(1,114,41)",
                "rgb(0,175,173)",
                "rgb(215,153,175)",
                "rgb(106,114,120)",
                "rgb(114,17,84)",
                "rgb(0,0,0)",
                "rgb(0,24,168)",
                "rgb(0,160,226)",
                "rgb(106,187,170)"
            ]
        }
    }
)
```
