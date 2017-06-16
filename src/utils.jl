###################################################################
#  Common definitions
###################################################################

type VegaLiteVis
    vis::Dict{}
end

+(a::VegaLiteVis, b::VegaLiteVis) = VegaLiteVis(softmerge(a.vis, b.vis))
*(a::VegaLiteVis, b::VegaLiteVis) = VegaLiteVis(merge(a.vis, b.vis))

if VERSION>=v"0.5.0"
    include_string("""
        function (a::VegaLiteVis)(b::VegaLiteVis)
            return a + b
        end
    """)
end

function softmerge(a::Dict, b::Dict)
    ck = intersect(keys(a), keys(b))
    nd = merge(a, b)
    for k in ck
        nd[k] = softmerge(a[k], b[k])
    end
    nd
end
softmerge(a::Dict, b::Any) = a
softmerge(a::Any, b::Dict) = b
softmerge(a, b) = b





#  Switch for plotting in SVGs or canvas
SVG = true
svg() = SVG
svg(b::Bool) = (global SVG ; SVG = b)




#  Switch for showing or not the "save as PNG buttons"
SAVE_BUTTONS = true
buttons() = SAVE_BUTTONS
buttons(b::Bool) = (global SAVE_BUTTONS ; SAVE_BUTTONS = b)







# build Dict from kwargs, checks against signature
function _mkdict(signature, properties)
  d = Dict()
  for (p,v) in properties
    haskey(signature, p) || error("unknown property $p")
    isa(v, signature[p]) || error("property $p : expected $(signature[p]), got $(typeof(v))")
    d[p] = v
  end
  d
end

function _mkvis(pos::Tuple, signature, properties)
  d = _mkdict(signature, properties)
  for k in reverse(pos)
    d = Dict(k => d)
  end
  VegaLiteVis(d)
end
