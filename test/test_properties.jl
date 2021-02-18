using Test
using VegaLite
using Setfield

@testset "properties" begin

    vgp = getvgplot()
    @test vgp.width isa Number
    @static if VERSION >= v"1.3"
        @test vgp.var"$schema" isa String
    end

    vlp = getvlplot()
    @test vlp.mark isa String
    @test vlp.encoding.x.field isa String
    @test_deprecated vlp.params["mark"] isa String

    @test (@set vlp.mark = :point).mark == :point
    @test vlp.mark == "bar"  # not mutated

end
