using Test
using VegaLite
using VegaLite: Vega.getparams

@testset "base" begin

    equiv(a::VegaLite.VLSpec, b::VegaLite.VLSpec) = false
    equiv(a::VegaLite.VLSpec, b::VegaLite.VLSpec) =
  ==(Vega.getparams(a), Vega.getparams(b))

###
    @test isa(renderer(), Symbol)
    @test_throws MethodError renderer(456)
    @test_throws ErrorException renderer(:abcd)
    renderer(:canvas)
    @test renderer() == :canvas

    @test isa(actionlinks(), Bool)
    @test_throws MethodError actionlinks(46)
    actionlinks(false)
    @test actionlinks() == false

###
    ts = collect(range(0, stop = 2, length = 100))
    rs = Float64[ rand() * 0.1 + cos(x) for x in ts]
    datvals = [ Dict(:time => t, :res => r) for (t, r) in zip(ts, rs) ]

# @test isa(vlconfig(background="green"), VegaLite.VLSpec{:config})
# @test isa(markline(), VegaLite.VLSpec{:mark})
# @test isa(vldata(values=datvals), VegaLite.VLSpec{:data})
# @test isa(VegaLite.data(values=datvals), VegaLite.VLSpec{:data})
# @test equiv(VegaLite.data(values=datvals), vldata(values=datvals))


# vs = encoding(xquantitative(field=:x, vlbin(maxbins=20),
#                             vlaxis(title="values")),
#               yquantitative(field=:*, aggregate=:count))

# @test length(Vega.getparams(vs)) == 2
# @test haskey(Vega.getparams(vs), "x")
# @test haskey(Vega.getparams(vs), "y")
# @test length(Vega.getparams(vs)["x"]) == 4
# @test get(Vega.getparams(vs)["x"], "axis", "") == Dict("title"=>"values")
# @test get(Vega.getparams(vs)["x"], "field", "") == :x
# @test get(Vega.getparams(vs)["x"], "type", "") == "quantitative"
# @test get(Vega.getparams(vs)["x"], "bin", "") == Dict("maxbins" => 20)
# @test length(Vega.getparams(vs)["y"]) == 3
# @test get(Vega.getparams(vs)["y"], "aggregate", "") == :count
# @test get(Vega.getparams(vs)["y"], "field", "") == :*
# @test get(Vega.getparams(vs)["y"], "type", "") == "quantitative"


# vs2 = xquantitative(field=:x, vlbin(maxbins=20),
#                             vlaxis(title="values")) |>
#       yquantitative(field=:*, aggregate=:count) ;
# vs2 = encoding(vs2) ;
# @test equiv(vs, vs2)


###
# using VegaDatasets

# cars = dataset("cars")

# @test isa(VegaLite.data(cars), VegaLite.VLSpec{:data})
# @test equiv(VegaLite.data(cars) |> plot(width=200),
#             cars |> plot(width=200))

end
