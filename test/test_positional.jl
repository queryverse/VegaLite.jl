@testset "Positional shortcuts" begin

    df = DataFrame(a = [1,2,3], b = [4,5,6])

    @test @vlplot(:point, [1,2,3]) == @vlplot(:point, x = [1,2,3])
    @test @vlplot(:point, {[1,2,3]}) == @vlplot(:point, x = [1,2,3])
    @test @vlplot(:point, [1,2,3], [4,5,6]) == @vlplot(:point, x = [1,2,3], y = [4,5,6])
    @test @vlplot(:point, {[1,2,3]}, {[4,5,6]}) == @vlplot(:point, x = [1,2,3], y = [4,5,6])
    @test @vlplot(:point, :a, data = df) == @vlplot(:point, x = :a, data = df)
    @test @vlplot(:point, :a, :b, data = df) == @vlplot(:point, x = :a, y = :b, data = df)
    @test @vlplot(:point, {:a}, data = df) == @vlplot(:point, x = :a, data = df)
    @test @vlplot(:point, {:a}, {:b}, data = df) == @vlplot(:point, x = :a, y = :b, data = df)
    @test @vlplot(:point, {"a:q"}, {"b:q"}, data = df) == @vlplot(:point, x = "a:q", y = "b:q", data = df)

end
