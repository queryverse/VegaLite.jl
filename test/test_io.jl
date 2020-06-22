using Test
using VegaLite
using VegaLite: Vega.getparams
using DataFrames
using Dates
using FileIO

@testset "io" begin

    p = DataFrame(x = [1,2,3], y = [1,2,3]) |> @vlplot(:point, x = "x:q", y = "y:q")
    vgp = getvgplot()
    vlp = getvlplot()

    @testset "$fmt (indent=$(repr(indent)))" for (fmt, plt) in [
    (format"vegalite", vlp)
    # (format"vega", vgp)  # waiting for FileIO
],
    indent in [nothing, 4]

        let json = sprint(io->save(Stream(fmt, io), plt, indent = indent)),
        code = "vg\"\"\"$json\"\"\""
            @test Vega.getparams(include_string(@__MODULE__, code)) == Vega.getparams(plt)
        end

        let io = IOBuffer()
            save(Stream(fmt, io), plt, indent = indent)
            seek(io, 0)
            @test Vega.getparams(load(Stream(fmt, io))) == Vega.getparams(plt)
        end

        let code = repr("text/plain", plt, context = :compact => false)
            @test Vega.getparams(include_string(@__MODULE__, code)) == Vega.getparams(plt)
        end
    end

    Base.Filesystem.mktempdir() do folder
        VegaLite.svg(joinpath(folder, "test1.svg"), p)
        @test isfile(joinpath(folder, "test1.svg"))

        VegaLite.pdf(joinpath(folder, "test1.pdf"), p)
        @test isfile(joinpath(folder, "test1.pdf"))

        VegaLite.png(joinpath(folder, "test1.png"), p)
        @test isfile(joinpath(folder, "test1.png"))

    # VegaLite.eps(joinpath(folder,"test1.eps"), p)
    # @test isfile(joinpath(folder,"test1.eps"))

        VegaLite.savefig(joinpath(folder, "test2.svg"), p)
        @test isfile(joinpath(folder, "test2.svg"))

        VegaLite.savefig(joinpath(folder, "test2.pdf"), p)
        @test isfile(joinpath(folder, "test2.pdf"))

        VegaLite.savefig(joinpath(folder, "test2.png"), p)
        @test isfile(joinpath(folder, "test2.png"))

    # VegaLite.savefig(joinpath(folder,"test2.eps"), p)
    # @test isfile(joinpath(folder,"test2.eps"))

        save(joinpath(folder, "test3.svg"), p)
        @test isfile(joinpath(folder, "test3.svg"))

        save(joinpath(folder, "test3.pdf"), p)
        @test isfile(joinpath(folder, "test3.pdf"))

        save(joinpath(folder, "test3.png"), p)
        @test isfile(joinpath(folder, "test3.png"))

    # save(joinpath(folder,"test2.eps"), p)
    # @test isfile(joinpath(folder,"test2.eps"))

        save(joinpath(folder, "test4.svg"), vgp)
        @test isfile(joinpath(folder, "test4.svg"))

        save(joinpath(folder, "test4.pdf"), vgp)
        @test isfile(joinpath(folder, "test4.pdf"))

        save(joinpath(folder, "test4.png"), vgp)
        @test isfile(joinpath(folder, "test4.png"))

    # save(joinpath(folder,"test4.eps"), vgp)
    # @test isfile(joinpath(folder,"test4.eps"))

        Vega.savespec(joinpath(folder, "test1.vegalite"), p)
        @test isfile(joinpath(folder, "test1.vegalite"))

        @test_throws ArgumentError VegaLite.savefig(joinpath(folder, "test1.foo"), p)

        save(joinpath(folder, "test2.vegalite"), p)
        @test isfile(joinpath(folder, "test2.vegalite"))

        p2 = VegaLite.loadspec(joinpath(folder, "test1.vegalite"))
        @test isa(p2, VegaLite.VLSpec)

        p2 = load(joinpath(folder, "test1.vegalite"))
        @test isa(p2, VegaLite.VLSpec)

        vgpl1 = getvgplot()

        Vega.savespec(joinpath(folder, "test1.vega"), vgpl1, include_data = true)

        vgpl2 = VegaLite.Vega.loadvgspec(joinpath(folder, "test1.vega"))

        @test vgpl1 == vgpl1

    # TODO Enable once FileIO stuff is merged
    # save(joinpath(folder,"test3.vega"), vgpl1)
    # @test isfile(joinpath(folder,"test3.vega"))

    # vgpl3 = load(joinpath(folder,"test3.vega"))
    # @test isa(vgpl2, Vega.VGSpec)

    # save(joinpath(folder,"test4.vega"), vgpl1, include_data=true)
    # @test isfile(joinpath(folder,"test4.vega"))

    end

end
