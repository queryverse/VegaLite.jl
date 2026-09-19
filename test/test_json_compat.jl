@testitem "json compat" begin
    using DataFrames
    using JSON
    using Vega
    using Vega: getparams

    # Key order of the original document must survive parsing.
    spec = vl"""{"width": 1, "height": 2, "padding": 3}"""
    @test collect(keys(getparams(spec))) == ["width", "height", "padding"]

    # JSON has no NaN/Inf, so they have to come out as `null`.
    df = DataFrame(a=[1.0, NaN, Inf, -Inf], b=["A", "B", "C", "D"])

    # Table data is held as a `DataValuesNode`, which has its own writer.
    p = @vlplot(mark = "point", data = df)
    @test getparams(p)["data"]["values"] isa Vega.DataValuesNode

    values = JSON.parse(sprint(VegaLite.our_json_print, p))["data"]["values"]
    @test [row["a"] for row in values] == [1.0, nothing, nothing, nothing]
    @test [row["b"] for row in values] == ["A", "B", "C", "D"]

    # `savespec` writes the spec itself rather than going through
    # `our_json_print`, both compact and pretty printed.
    for indent in [nothing, 4]
        written = sprint(io -> Vega.savespec(io, p, include_data=true, indent=indent))
        @test JSON.parse(written)["data"]["values"][2]["a"] === nothing
    end

    # Non-finite numbers elsewhere in the spec go through the generic writer.
    p2 = @vlplot(mark = "point", encoding = {x = {datum = NaN}})
    @test JSON.parse(sprint(VegaLite.our_json_print, p2))["encoding"]["x"]["datum"] === nothing
end
