using Test
using VegaLite

@testset "show" begin

    vl = @vlplot(:point)
    vg = Vega.VGSpec(Dict{String,Any}())

    @test sprint(show, vl) == "VegaLite.VLSpec"

    @test sprint(show, "text/plain", vl) == "@vlplot(\n    mark=\"point\"\n)"

    @test sprint(show, vg) == "Vega.VGSpec"

    @test sprint(show, "text/plain", vg) == "@vgplot(\n\n)"

    @test_throws ArgumentError sprint(show, "image/svg+xml", @vlplot())

    @test istextmime("application/vnd.vegalite.v4+json")

    @test istextmime("application/vnd.vega.v5+json")

    @test sprint(show, "application/vnd.vegalite.v4+json", @vlplot(:point)) == "{\"mark\":\"point\"}"

    @test sprint(show, "application/vnd.vega.v5+json", vg"{}") == "{}"

end
