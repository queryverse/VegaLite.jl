using Test
using VegaLite

@testset "Shorthand" begin

    @test VegaLite.parse_shortcut("foo") == ["field" => "foo"]

    @test VegaLite.parse_shortcut("foo:q") == ["field" => "foo", "type" => "quantitative"]
    @test VegaLite.parse_shortcut("foo:Q") == ["field" => "foo", "type" => "quantitative"]
    @test VegaLite.parse_shortcut("foo:quantitative") == ["field" => "foo", "type" => "quantitative"]
    @test VegaLite.parse_shortcut("foo:quAntitAtive") == ["field" => "foo", "type" => "quantitative"]

    @test VegaLite.parse_shortcut("foo:n") == ["field" => "foo", "type" => "nominal"]
    @test VegaLite.parse_shortcut("foo:N") == ["field" => "foo", "type" => "nominal"]
    @test VegaLite.parse_shortcut("foo:nominal") == ["field" => "foo", "type" => "nominal"]
    @test VegaLite.parse_shortcut("foo:nOminAl") == ["field" => "foo", "type" => "nominal"]

    @test VegaLite.parse_shortcut("foo:o") == ["field" => "foo", "type" => "ordinal"]
    @test VegaLite.parse_shortcut("foo:O") == ["field" => "foo", "type" => "ordinal"]
    @test VegaLite.parse_shortcut("foo:ordinal") == ["field" => "foo", "type" => "ordinal"]
    @test VegaLite.parse_shortcut("foo:OrDinAl") == ["field" => "foo", "type" => "ordinal"]

    @test VegaLite.parse_shortcut("foo:t") == ["field" => "foo", "type" => "temporal"]
    @test VegaLite.parse_shortcut("foo:T") == ["field" => "foo", "type" => "temporal"]
    @test VegaLite.parse_shortcut("foo:temporal") == ["field" => "foo", "type" => "temporal"]
    @test VegaLite.parse_shortcut("foo:tEmporAl") == ["field" => "foo", "type" => "temporal"]

    @test_throws ArgumentError VegaLite.parse_shortcut("foo:x")
    @test_throws ArgumentError VegaLite.parse_shortcut("foo:bar")

    @test VegaLite.parse_shortcut("sum(foo)") == ["aggregate" => "sum", "field" => "foo", "type" => "quantitative"]
    @test VegaLite.parse_shortcut("sum(foo):o") == ["aggregate" => "sum", "field" => "foo", "type" => "ordinal"]
    @test VegaLite.parse_shortcut("sum(foo):quantitative") == ["aggregate" => "sum", "field" => "foo", "type" => "quantitative"]
    @test_throws ArgumentError VegaLite.parse_shortcut("sum(foo):bar")

    @test VegaLite.parse_shortcut("year(foo)") == ["timeUnit" => "year", "field" => "foo", "type" => "temporal"]
    @test VegaLite.parse_shortcut("month(foo):o") == ["timeUnit" => "month", "field" => "foo", "type" => "ordinal"]
    @test VegaLite.parse_shortcut("yearmonth(foo):quantitative") == ["timeUnit" => "yearmonth", "field" => "foo", "type" => "quantitative"]

    @test VegaLite.parse_shortcut("count()") == ["aggregate" => "count", "type" => "quantitative"]
    @test VegaLite.parse_shortcut("count():o") == ["aggregate" => "count", "type" => "ordinal"]

    @test_throws ArgumentError VegaLite.parse_shortcut("%lijasef9")

    @test_throws ArgumentError VegaLite.parse_shortcut("bar(foo)")

    @test_throws ArgumentError VegaLite.parse_shortcut("bar():lij:lij")

    @test_throws ArgumentError VegaLite.parse_shortcut("count):o:foo")

    @test_throws ArgumentError VegaLite.parse_shortcut("count(bar(:o:foo")

    @test_throws ArgumentError VegaLite.parse_shortcut("count(bar):o:foo")

end
