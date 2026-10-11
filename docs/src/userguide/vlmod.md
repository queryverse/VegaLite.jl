# `@vlmod`: Immutable Spec Modifications

`@vlmod` is a VegaLite.jl-native way to modify existing `VLSpec` objects immutably.

It is designed for:
1. small, explicit edits to existing specs
2. path-based modifications (`x.title`, `mark.color`, `layer[2].mark.color`)
3. deletion of fields (`delete(x.title)`)
4. reusable modification bundles

## Why use `@vlmod`

`@vlplot` is ideal for constructing a spec.
`@vlmod` is ideal for editing a spec after it already exists.

Compared with generic immutable update tools, `@vlmod` adds VegaLite-specific behavior:
1. channel aliases (`x` means `encoding.x`)
2. mark scalar-to-object promotion (`mark = :point` + `mark.color = :red`)
3. pruning empty parent objects after deletion
4. channel shorthand parsing for direct channel assignment (`x = "Acceleration:q"`)

## Basic usage

Use it in a pipeline:

```julia
using VegaLite

spec2 = spec |>
    @vlmod(
        title = "Updated title",
        x.title = "Horsepower",
        mark.color = :red
    )
```

Use it directly:

```julia
spec2 = @vlmod(spec, title = "Updated title")
```

## `VLMod` objects

`@vlmod(op1, op2, ...)` returns a `VLMod` object that stores the operations.

```julia
mod = @vlmod(
    x.title = "Acceleration",
    delete(title)
)

spec2 = spec |> mod
spec3 = otherspec |> mod
```

This is useful when the same edits should be applied to multiple specs.

## Operations

`@vlmod` supports two operation kinds.

### 1. Assignment

```julia
@vlmod(
    title = "My Plot",
    mark.color = :red,
    encoding.y.scale.zero = false
)
```

### 2. Deletion

```julia
@vlmod(
    delete(title),
    delete(x.title),
    delete(layer[2].encoding.color)
)
```

Deletion removes keys instead of writing `null`.

## Path syntax

### Dotted field paths

```julia
mark.color
encoding.x.title
config.axis.labelFontSize
```

### Channel alias paths

If the first path segment is a channel name, it is expanded to `encoding.<channel>`.

Examples:
1. `x.title` -> `encoding.x.title`
2. `color.scale.scheme` -> `encoding.color.scale.scheme`
3. `encoding.x.title` remains unchanged

### Array indexing paths

`@vlmod` supports indexing into arrays with integer literals.

```julia
layer[2].mark.color = :red
delete(layer[1].encoding.tooltip)
transform[3].calculate = "datum.a + datum.b"
```

Indexing is 1-based (Julia-style). Index `0` and negative indices throw an `ArgumentError`.

## Channel shorthand assignment

When assigning directly to a channel path (`x` or `encoding.x`), shorthand parsing is applied:

```julia
@vlmod(x = "Horsepower:q")
@vlmod(y = :Miles_per_Gallon)
@vlmod(encoding.color = "Origin:n")
```

These expand to channel objects:
1. `x = "Horsepower:q"` -> `encoding.x = {field="Horsepower", type="quantitative"}`
2. `y = :Miles_per_Gallon` -> `encoding.y = {field="Miles_per_Gallon"}`

This shorthand parsing is only applied when setting a channel directly.
For example, `x.title = "Horsepower:q"` sets a literal title string.

## VegaLite-specific normalization behavior

### Missing parents are created

```julia
@vlplot(:point) |> @vlmod(x.title = "Acceleration")
```

If `encoding` or `encoding.x` is missing, they are created.

### Mark promotion

If `mark` is scalar and you assign a nested mark field, `mark` is promoted:

```julia
@vlplot(:point) |> @vlmod(mark.color = :red)
```

Resulting mark is object-form with `type` preserved:
`mark = {type=:point, color=:red}`.

### Deletion pruning

After deleting a field, empty parent objects are pruned.

Example:
1. start with `encoding.x = {title="A"}`
2. apply `delete(x.title)`
3. `encoding.x` is removed (empty)
4. if `encoding` becomes empty, it is also removed

## Operation order

Operations are applied in sequence and later operations see earlier results.

```julia
spec2 = spec |> @vlmod(
    x.title = "A",
    delete(x.title)
)
```

Final `x.title` is absent.

## Immutability

`@vlmod` returns a new `VLSpec` and does not mutate the original spec.

```julia
s1 = @vlplot(:point, x=:a)
s2 = s1 |> @vlmod(x.title = "A")
# s1 unchanged, s2 modified
```

## Error behavior

`@vlmod` is permissive for normal editing:
1. deleting absent fields is a no-op
2. missing parents are created automatically

It throws `ArgumentError` for malformed or unsupported syntax:
1. invalid macro form
2. non-integer or non-literal array indices in paths
3. index `<= 0`

## More examples

### Recolor an overlay layer

```julia
base = @vlplot(layer=[
    {mark=:line, x=:x, y=:y},
    {mark=:point, x=:x, y=:y}
])

recolored = base |> @vlmod(layer[2].mark.color = :orange)
```

### Remove titles globally in a reusable modifier

```julia
strip_titles = @vlmod(
    delete(title),
    delete(x.title),
    delete(y.title)
)

clean = spec |> strip_titles
```

### Start from a simple plot and incrementally refine

```julia
p = @vlplot(:point, x=:Horsepower, y=:Miles_per_Gallon)

p2 = p |> @vlmod(
    x.title = "HP",
    y.title = "MPG",
    mark.opacity = 0.5
)
```

## Relationship to Setfield.jl

Setfield is still useful as a general immutable update tool.
`@vlmod` is preferred when editing VegaLite specs because it captures VegaLite-specific semantics such as aliasing, shorthand channel assignments, mark promotion, and deletion pruning.
