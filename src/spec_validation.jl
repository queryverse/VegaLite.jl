####################################################################
#  JSON plot spec validation
####################################################################

function _conforms(x, ps::String, t::Type)
  isa(x, t) && return
  throw("expected '$t' got '$(typeof(x))' in $ps")
end

conforms(x, ps::String, d::IntDef)    = _conforms(x, ps, Int)
conforms(x, ps::String, d::NumberDef) = _conforms(x, ps, Number)
conforms(x, ps::String, d::BoolDef)   = _conforms(x, ps, Bool)
conforms(x, ps::String, d::VoidDef)   = _conforms(x, ps, Void)
conforms(x, ps::String, d::AnyDef)    = nothing

function conforms(x, ps::String, d::StringDef)
  x = isa(x,Symbol) ? string(x) : x
  _conforms(x, ps, String)
  if length(d.enum) > 0
    if ! (x in d.enum)
      svalid = "[" * join(collect(d.enum),",") * "]"
      throw("'$x' is not one of $svalid in $ps")
    end
  end
  nothing
end

function conforms(x, ps::String, d::ArrayDef)
  _conforms(x, ps, Vector)
  for e in x
    conforms(e, ps, d.items)
  end
  nothing
end

function conforms(d, ps::String, spec::ObjDef)
  isa(d, Dict) || throw("expected object got '$d' in $ps")
  for (k,v) in d
    if haskey(spec.props, k)
      conforms(v, "$ps.$k", spec.props[k])
    elseif ! isa(spec.addprops, VoidDef) # if additional properties
      conforms(v, "$ps.$k", spec.addprops)
    elseif length(spec.props) == 0  # if empty object, accept
    else
      throw("unexpected param '$k' in $ps")
    end
  end
  for k in spec.required
    haskey(d, k) || throw("required param '$k' missing in $ps")
  end
end

function tryconform(d, ps::String, spec::SpecDef)
  try
    conforms(d, ps, spec)
  catch e
    return false
  end
  true
end

function conforms(d, ps::String, spec::UnionDef)
  causes = String[]
  for s in spec.items
    tryconform(d, ps, s) && return
    try
      conforms(d, ps, s)
    catch e
      isa(e, String) && push!(causes, e)
    end
  end
  scauses = join(unique(causes), ", ")
  throw("no matching spec found for $ps, possible causes : $scauses")
end

"""
perform final check of plot before rendering
"""
function checkplot(plt::VLSpec{:plot})
  pars = plt.params

  # Of six possible plot specs (unit, layer, repeat, hconcat, vconcat, facet),
  # identify which one applies by their required properties to simplify
  # error messages (i.e. to avoid too many "possible causes" )
  onematch = false
  for spec in rootSpec.items
    if all(r in keys(pars) for r in spec.required)
      conforms(pars, "plot", spec)
      onematch = true
    end
  end

  # if no match print full error message
  onematch || conforms(pars, "plot", rootSpec)

  nothing
end
