using Base.Test
using VegaLite
using DataFrames

@testset "io" begin

p = DataFrame(x = [1,2,3], y=[1,2,3]) |> @vlplot(:point, x="x:q", y="y:q")

Base.Filesystem.mktempdir() do folder
    svg(joinpath(folder,"test1.svg"), p)
    @test isfile(joinpath(folder,"test1.svg"))

    pdf(joinpath(folder,"test1.pdf"), p)
    @test isfile(joinpath(folder,"test1.pdf"))

    png(joinpath(folder,"test1.png"), p)
    @test isfile(joinpath(folder,"test1.png"))

    VegaLite.eps(joinpath(folder,"test1.eps"), p)
    @test isfile(joinpath(folder,"test1.eps"))

    savefig(joinpath(folder,"test2.svg"), p)
    @test isfile(joinpath(folder,"test2.svg"))

    savefig(joinpath(folder,"test2.pdf"), p)
    @test isfile(joinpath(folder,"test2.pdf"))

    savefig(joinpath(folder,"test2.png"), p)
    @test isfile(joinpath(folder,"test2.png"))

    savefig(joinpath(folder,"test2.eps"), p)
    @test isfile(joinpath(folder,"test2.eps"))

    VegaLite.savespec(joinpath(folder,"test1.vegalite"), p)
    @test isfile(joinpath(folder,"test1.vegalite"))

    # TODO Enable once FileIO registration is merged
    # save(p, joinpath(folder,"test2.vegalite"))
    # @test isfile(joinpath(folder,"test2.vegalite"))

    p2 = VegaLite.loadspec(joinpath(folder,"test1.vegalite"))
    @test isa(p2, VegaLite.VLSpec)

    # TODO Enable once FileIO registration is merged
    # p2 = load(joinpath(folder,"test1.vegalite"))
    # @test isa(p2, VLSpec)
end

end
