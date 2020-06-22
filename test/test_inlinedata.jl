@testset "Inline Data" begin

    @test @vlplot(:point, x = {[1,2,3]}, y = [4,5,6]) ==
    @vlplot(:point, data = DataFrame(x = [1,2,3], y = [4,5,6]), x = {:x, title = nothing}, y = {:y, title = nothing})

    @test @vlplot(:point, x = {[1,2,3], title = :test}, y = [4,5,6]) ==
    @vlplot(:point, data = DataFrame(x = [1,2,3], y = [4,5,6]), x = {:x, title = :test}, y = {:y, title = nothing})

end
