@testitem "base" begin
    using VegaLite: Vega.getparams

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

    ts = collect(range(0, stop=2, length=100))
    rs = Float64[rand() * 0.1 + cos(x) for x in ts]
    datvals = [Dict(:time => t, :res => r) for (t, r) in zip(ts, rs)]
end
