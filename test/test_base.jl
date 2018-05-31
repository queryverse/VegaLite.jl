using Base.Test
using VegaLite

@testset "base" begin

equiv(a::VegaLite.VLSpec, b::VegaLite.VLSpec) = false
equiv{T}(a::VegaLite.VLSpec{T}, b::VegaLite.VLSpec{T}) =
  ==(a.params,b.params)

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
ts = collect(linspace(0,2,100))
rs = Float64[ rand()*0.1 + cos(x) for x in ts]
datvals = [ Dict(:time => t, :res => r) for (t,r) in zip(ts, rs) ]

# @test isa(vlconfig(background="green"), VegaLite.VLSpec{:config})
# @test isa(markline(), VegaLite.VLSpec{:mark})
# @test isa(vldata(values=datvals), VegaLite.VLSpec{:data})
# @test isa(VegaLite.data(values=datvals), VegaLite.VLSpec{:data})
# @test equiv(VegaLite.data(values=datvals), vldata(values=datvals))


# vs = encoding(xquantitative(field=:x, vlbin(maxbins=20),
#                             vlaxis(title="values")),
#               yquantitative(field=:*, aggregate=:count))

# @test length(vs.params) == 2
# @test haskey(vs.params, "x")
# @test haskey(vs.params, "y")
# @test length(vs.params["x"]) == 4
# @test get(vs.params["x"], "axis", "") == Dict("title"=>"values")
# @test get(vs.params["x"], "field", "") == :x
# @test get(vs.params["x"], "type", "") == "quantitative"
# @test get(vs.params["x"], "bin", "") == Dict("maxbins" => 20)
# @test length(vs.params["y"]) == 3
# @test get(vs.params["y"], "aggregate", "") == :count
# @test get(vs.params["y"], "field", "") == :*
# @test get(vs.params["y"], "type", "") == "quantitative"


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
