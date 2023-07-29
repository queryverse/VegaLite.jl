# Bar Charts

## Simple Bar Chart

```@example
using VegaLite, DataFrames

data = DataFrame(
    a=["A","B","C","D","E","F","G","H","I"],
    b=[28,55,43,91,81,53,19,87,52]
)

data |> @vlplot(:bar, x="a:o", y=:b)
```

## Responsive Bar Chart

```@example
using VegaLite, VegaDatasets

dataset("cars") |>
@vlplot(
    height=250,
    width="container",
    :bar,
    x="Origin:n",
    y="count()",
)
```

## Aggregate Bar Chart

```@example
using VegaLite, VegaDatasets

dataset("population") |>
@vlplot(
    height={step=17},
    :bar,
    transform=[{filter="datum.year == 2000"}],
    y="age:o",
    x={"sum(people)", axis={title="population"}}
)
```

## Aggregate Bar Chart (Sorted)

```@example
using VegaLite, VegaDatasets

dataset("population") |>
@vlplot(
    :bar,
    transform=[{filter="datum.year == 2000"}],
    y={"age:o",sort="-x"},
    x={"sum(people)", axis={title="population"}}
)
```

## Grouped Bar Chart

```@example
using VegaLite, VegaDatasets

dataset("population") |>
@vlplot(
    :bar,
    transform=[
        {filter="datum.year == 2000"},
        {calculate="datum.sex == 2 ? 'Female' : 'Male'", as="gender"}
    ],
    column="age:o",
    y={"sum(people)", axis={title="population", grid=false}},
    x={"gender:n", axis={title=""}},
    color={"gender:n", scale={range=["#675193", "#ca8861"]}},
    spacing=10,
    config={
        view={stroke=:transparent},
        axis={domainWidth=1}
    }
)
```

## Grouped Bar Chart (Another Example)

```@example
using VegaLite, VegaDatasets

dataset("seattle-weather") |>
@vlplot(
    :bar,
    column="month(date):o",
    x={"weather:n", axis={title="", labels=false}},
    y={"count()", axis={title="Count", grid=false}},
    color={
        :weather,
        scale={
            domain=["sun","fog","drizzle","rain","snow"],
            range=["#e7ba52","#c7c7c7","#aec7e8","#1f77b4","#9467bd"]
        },
        legend={
            title="Weather type"
        }
    },
    spacing=10,
    config={
        view={stroke=:transparent},
        axis={domainWidth=1}
    }
)
```

## Stacked Bar Chart

This is exactly the same chart as the previous example, except it is stacked instead of grouped.

```@example
using VegaLite, VegaDatasets

dataset("seattle-weather") |>
@vlplot(
    :bar,
    x={"month(date):o", axis={title="Month of the year"}},
    y="count()",
    color={
        :weather,
        scale={
            domain=["sun","fog","drizzle","rain","snow"],
            range=["#e7ba52","#c7c7c7","#aec7e8","#1f77b4","#9467bd"]
        },
        legend={
            title="Weather type"
        }
    }
)
```

## Stacked Bar Chart with Rounded Corners

```@example
using VegaLite, VegaDatasets

dataset("seattle-weather") |>
@vlplot(
    mark={
        :bar,
        cornerRadiusTopLeft=3,
        cornerRadiusTopRight=3
    },
    x={"month(date):o"},
    y="count()",
    color={
        :weather
    }
)
```

## Horizontal Stacked Bar Chart

```@example
using VegaLite, VegaDatasets

dataset("barley") |>
@vlplot(:bar, x="sum(yield)", y=:variety, color=:site)
```

## Normalized (Percentage) Stacked Bar Chart

```@example
using VegaLite, VegaDatasets

dataset("population") |>
@vlplot(
    :bar,
    transform=[
        {filter="datum.year == 2000"},
        {calculate="datum.sex==2 ? 'Female' : 'Male'",as="gender"}
    ],
    y={
        "sum(people)",
        axis={title="population"},
        stack=:normalize
    },
    x="age:o",
    color={
        "gender:n",
        scale={range=["#675193", "#ca8861"]}
    },
    width={step=17}    
)
```

## Gantt Chart (Ranged Bar Marks)

```@example
using VegaLite

@vlplot(
    :bar,
    data={
        values=[
            {task="A",start=1,stop=3},
            {task="B",start=3,stop=8},
            {task="C",start=8,stop=10}
        ]
    },
    y="task:o",
    x="start:q",
    x2="stop:q"
)
```

## A bar chart encoding color names in the data

```@example
using VegaLite

@vlplot(
    :bar,
    data={
        values=[
            {color="red",b=28},
            {color="green",b=55},
            {color="blue",b=43}
        ]
    },
    x="color:n",
    y="b:q",
    color={"color:n",scale=nothing}
)
```

## Layered Bar Chart

```@example
using VegaLite, VegaDatasets

dataset("population") |>
@vlplot(
    :bar,
    transform=[
        {filter="datum.year==2000"},
        {calculate="datum.sex==2 ? 'Female' : 'Male'",as="gender"}
    ],
    x="age:o",
    y={"sum(people)", axis={title="population"}, stack=nothing},
    color={"gender:n", scale={range=["#675193", "#ca8861"]}},
    opacity={value=0.7},
    width={step=17}
)
```

## Diverging Stacked Bar Chart (Population Pyramid)

```@example
using VegaLite, VegaDatasets

dataset("population") |>
@vlplot(
    width=300,
    height=200,
    :bar,
    transform=[
        {filter="datum.year==2000"},
        {calculate="datum.sex==2 ? 'Female' : 'Male'", as="gender"},
        {calculate="datum.sex==2 ? -datum.people : datum.people", "as"="signed_people" }
    ],
    x={"sum(signed_people)", axis={title="population", format=:s} },
    y={"age:o", axis=nothing, sort="descending" },
    color={"gender:n", scale={range=["#675193", "#ca8861"]},legend={orient=:top,title=nothing}},
    config={view={stroke=nothing},axis={grid=false}}
)
```

## Diverging Stacked Bar Chart (with Neutral Parts)

```@example
using VegaLite, DataFrames

data = DataFrame(
    question=["Question $(div(i,5)+1)" for i in 0:39],
    type=repeat(["Strongly disagree", "Disagree", "Neither agree nor disagree",
        "Agree", "Strongly agree"],outer=8),
    value=[24, 294, 594, 1927, 376, 2, 2, 0, 7, 11, 2, 0, 2, 4, 2, 0, 2, 1, 7,
        6, 0, 1, 3, 16, 4, 1, 1, 2, 9, 3, 0, 0, 1, 4, 0, 0, 0, 0, 0, 2],
    percentage=[0.7, 9.1, 18.5, 59.9, 11.7, 18.2, 18.2, 0, 63.6, 0, 20, 0, 20,
        40, 20, 0, 12.5, 6.3, 43.8, 37.5, 0, 4.2, 12.5, 66.7, 16.7, 6.3, 6.3,
        12.5, 56.3, 18.8, 0, 0, 20, 80, 0, 0, 0, 0, 0, 100],
    percentage_start=[-19.1, -18.4, -9.2, 9.2, 69.2, -36.4, -18.2, 0, 0, 63.6,
        -30, -10, -10, 10, 50, -15.6, -15.6, -3.1, 3.1, 46.9, -10.4, -10.4,
        -6.3, 6.3, 72.9, -18.8, -12.5, -6.3, 6.3, 62.5, -10, -10, -10, 10, 90,
        0, 0, 0, 0, 0],
    percentage_end=[-18.4, -9.2, 9.2, 69.2, 80.9, -18.2, 0, 0, 63.6, 63.6, -10,
        -10, 10, 50, 70, -15.6, -3.1, 3.1, 46.9, 84.4, -10.4, -6.3, 6.3, 72.9,
        89.6, -12.5, -6.3, 6.3, 62.5, 81.3, -10, -10, 10, 90, 90, 0, 0, 0, 0, 100]
)

data |> @vlplot(
    :bar,
    x={:percentage_start, axis={title="Percentage"}},
    x2=:percentage_end,
    y={
        :question, axis={
            title="Question",
            offset=5,
            ticks=false,
            minExtent=60,
            domain=false
        }
    },
    color={
        :type,
        legend={title="Response"},
        scale={
            domain=[
                "Strongly disagree",
                "Disagree",
                "Neither agree nor disagree",
                "Agree",
                "Strongly agree"
            ],
            range=["#c30d24", "#f3a583", "#cccccc", "#94c6da", "#1770ab"],
            type=:ordinal
        }
    }
)
```

## Bar Chart with Labels

```@example
using VegaLite

@vlplot(
    data={
        values=[
            {a="A",b=28},
            {a="B",b=55},
            {a="C",b=43}
        ]
    },
    y="a:o",
    x="b:q"
) +
@vlplot(:bar) +
@vlplot(
    mark={
        :text,
        align=:left,
        baseline=:middle,
        dx=3
    },
    text="b:q"
)
```

## Bar Chart with Label Overlays

```@example
using VegaLite, VegaDatasets

dataset("movies") |>
@vlplot(
    width=200,
    height={step=16},
    y={:Major_Genre,axis=nothing}
) +
@vlplot(
    mark={:bar,color="#ddd"},
    x={"mean(IMDB_Rating)",axis={title="Mean IMDB Ratings"},scale={domain=[0,10]}},
) +
@vlplot(
    mark={:text,align="left",x=5},
    text="Major_Genre:n",
    detail={aggregate="count",type="quantitative"}
)
```

## Bar Chart showing Initials of Month Names

```@example
using VegaLite, VegaDatasets

dataset("seattle-weather") |>
@vlplot(
    :bar,
    x={"date:t",timeUnit="month",axis={labelAlign="left",labelExpr="datum.label[0]"}},
    y={"mean(precipitation)"}
)
```
