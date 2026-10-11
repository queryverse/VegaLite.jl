@testitem "@vlmod returns VLMod" begin
    mod = @vlmod(title = "My Plot")
    @test mod isa VegaLite.VLMod
    @test length(mod.ops) == 1
end

@testitem "@vlmod supports pipe and direct-call forms" begin
    p = @vlplot(:point)
    mod = @vlmod(mark.color = :red)

    @test (p |> mod) == (p |> @vlmod(mark.color = :red))
    @test @vlmod(p, mark.color = :red) == (p |> mod)
end

@testitem "@vlmod assignment basics" begin
    using Vega

    p = @vlplot(:point) |> @vlmod(title = "My Plot")
    @test p == @vlplot(:point, title = "My Plot")

    p_mark = @vlplot(:point) |> @vlmod(mark.color = :red)
    @test Vega.getparams(p_mark)["mark"] == Dict{String,Any}(
        "type" => :point,
        "color" => :red
    )
end

@testitem "@vlmod alias normalization and nested assignment" begin
    using Vega

    p1 = @vlplot(:point, x = :foo) |> @vlmod(x.title = "New title")
    p2 = @vlplot(:point, x = :foo) |> @vlmod(encoding.x.title = "New title")

    @test Vega.getparams(p1) == Vega.getparams(p2)
    @test Vega.getparams(p1)["encoding"]["x"] == Dict{String,Any}(
        "field" => "foo",
        "title" => "New title"
    )
end

@testitem "@vlmod creates missing parent objects" begin
    @test (@vlplot(:point) |> @vlmod(x.title = "Hello")) == @vlplot(:point, x = {title = "Hello"})
    @test (@vlplot(:point) |> @vlmod(config.axis.labelFontSize = 14)).config.axis.labelFontSize == 14
end

@testitem "@vlmod mark promotion behavior" begin
    using Vega

    p_symbol = @vlplot(:point) |> @vlmod(mark.color = :red)
    @test Vega.getparams(p_symbol)["mark"] == Dict{String,Any}(
        "type" => :point,
        "color" => :red
    )

    p_string = @vlplot(mark = "point") |> @vlmod(mark.color = :red)
    @test Vega.getparams(p_string)["mark"] == Dict{String,Any}(
        "type" => "point",
        "color" => :red
    )

    p_missing = @vlplot() |> @vlmod(mark.color = :red)
    @test Vega.getparams(p_missing)["mark"] == Dict{String,Any}("color" => :red)
end

@testitem "@vlmod deletion basics and no-op delete" begin
    using Vega

    @test (@vlplot(:point, title = "A") |> @vlmod(delete(title))) == @vlplot(:point)

    p = @vlplot(:point, x = :foo) |> @vlmod(delete(x.title))
    @test Vega.getparams(p)["encoding"]["x"] == Dict{String,Any}("field" => "foo")

    @test (@vlplot(:point) |> @vlmod(delete(y.title))) == @vlplot(:point)
end

@testitem "@vlmod deletion pruning behavior" begin
    @test (@vlplot(:point, x = {title = "A"}) |> @vlmod(delete(x.title))) == @vlplot(:point)
    @test (@vlplot(:point, x = {field = :foo}) |> @vlmod(delete(x))) == @vlplot(:point)
end

@testitem "@vlmod operation order and immutability" begin
    using Vega

    p_order = @vlplot(:point, x = :a) |> @vlmod(
        x.title = "A",
        delete(x.title)
    )
    @test Vega.getparams(p_order)["encoding"]["x"] == Dict{String,Any}("field" => "a")

    p = @vlplot(:point, x = :a)
    p2 = p |> @vlmod(x.title = "A")
    @test p == @vlplot(:point, x = :a)
    @test Vega.getparams(p2)["encoding"]["x"] == Dict{String,Any}(
        "field" => "a",
        "title" => "A"
    )
    @test Vega.getparams(p) !== Vega.getparams(p2)
end

@testitem "@vlmod channel shorthand assignment" begin
    using Vega

    p_shorthand_string = @vlplot(:point) |> @vlmod(x = "foo:q")
    @test Vega.getparams(p_shorthand_string)["encoding"]["x"] == Dict{String,Any}(
        "field" => "foo",
        "type" => "quantitative"
    )

    p_shorthand_symbol = @vlplot(:point) |> @vlmod(x = :foo)
    @test Vega.getparams(p_shorthand_symbol)["encoding"]["x"] == Dict{String,Any}(
        "field" => "foo"
    )

    p_shorthand_explicit = @vlplot(:point) |> @vlmod(encoding.x = "bar:n")
    @test Vega.getparams(p_shorthand_explicit)["encoding"]["x"] == Dict{String,Any}(
        "field" => "bar",
        "type" => "nominal"
    )

    p_nested = @vlplot(:point, x = :a) |> @vlmod(x.title = "foo:q")
    @test Vega.getparams(p_nested)["encoding"]["x"] == Dict{String,Any}(
        "field" => "a",
        "title" => "foo:q"
    )
end

@testitem "@vlmod array indexing set/delete" begin
    using Vega

    p_layer_set = @vlplot(layer = [{mark = :point}, {mark = :bar}]) |> @vlmod(layer[2].mark.color = :red)
    @test Vega.getparams(p_layer_set)["layer"][2]["mark"] == Dict{String,Any}(
        "type" => :bar,
        "color" => :red
    )

    p_layer_delete_field = p_layer_set |> @vlmod(delete(layer[2].mark.color))
    @test Vega.getparams(p_layer_delete_field)["layer"][2]["mark"] == Dict{String,Any}(
        "type" => :bar
    )

    p_delete_element = @vlplot(layer = [{mark = :point}, {mark = :bar}]) |> @vlmod(delete(layer[1]))
    @test length(Vega.getparams(p_delete_element)["layer"]) == 1
    @test Vega.getparams(p_delete_element)["layer"][1]["mark"] == :bar

    p_oob_delete = @vlplot(layer = [{mark = :point}]) |> @vlmod(delete(layer[5].mark.color))
    @test p_oob_delete == @vlplot(layer = [{mark = :point}])
end

@testitem "@vlmod indexing and syntax errors" begin
    @test_throws ArgumentError (@vlplot(:point) |> @vlmod(layer[0].mark.color = :red))
    @test_throws LoadError eval(:(@vlmod()))
    @test_throws LoadError eval(:(@vlmod(delete(title, x))))
    @test_throws LoadError eval(:(@vlmod(layer[i].mark.color = :red)))
    @test_throws LoadError eval(:(@vlmod(1 + 2)))
end
