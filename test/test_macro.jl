@testitem "macro" begin
    using VegaLite: Vega.getparams
    using Vega
    using JSON

    spec = vl"""
  {
    "data": {
      "values": [
        {"a": "A","b": 28}, {"a": "B","b": 55}
      ]
    },
    "mark": "bar",
    "encoding": {
      "x": {"field": "a", "type": "ordinal"},
      "y": {"field": "b", "type": "quantitative"}
    }
  }
  """

    @test isa(spec, VegaLite.VLSpec)
    @test Vega.getparams(spec) == JSON.parse("""
    {
      "data": {
        "values": [
          {"a": "A","b": 28}, {"a": "B","b": 55}
        ]
      },
      "mark": "bar",
      "encoding": {
        "x": {"field": "a", "type": "ordinal"},
        "y": {"field": "b", "type": "quantitative"}
      }
    }
    """)

end
