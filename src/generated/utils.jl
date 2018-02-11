function xordinal(args...; kwargs...) # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 13:
    nkw = [kwargs; (:type, "ordinal")] # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 14:
    vlx(args...; nkw...)
end
export xordinal
@doc @doc(vlx) xordinal
function xnominal(args...; kwargs...) # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 13:
    nkw = [kwargs; (:type, "nominal")] # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 14:
    vlx(args...; nkw...)
end
export xnominal
@doc @doc(vlx) xnominal
function xquantitative(args...; kwargs...) # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 13:
    nkw = [kwargs; (:type, "quantitative")] # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 14:
    vlx(args...; nkw...)
end
export xquantitative
@doc @doc(vlx) xquantitative
function xtemporal(args...; kwargs...) # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 13:
    nkw = [kwargs; (:type, "temporal")] # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 14:
    vlx(args...; nkw...)
end
export xtemporal
@doc @doc(vlx) xtemporal
function rowordinal(args...; kwargs...) # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 13:
    nkw = [kwargs; (:type, "ordinal")] # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 14:
    vlrow(args...; nkw...)
end
export rowordinal
@doc @doc(vlrow) rowordinal
function rownominal(args...; kwargs...) # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 13:
    nkw = [kwargs; (:type, "nominal")] # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 14:
    vlrow(args...; nkw...)
end
export rownominal
@doc @doc(vlrow) rownominal
function rowquantitative(args...; kwargs...) # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 13:
    nkw = [kwargs; (:type, "quantitative")] # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 14:
    vlrow(args...; nkw...)
end
export rowquantitative
@doc @doc(vlrow) rowquantitative
function rowtemporal(args...; kwargs...) # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 13:
    nkw = [kwargs; (:type, "temporal")] # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 14:
    vlrow(args...; nkw...)
end
export rowtemporal
@doc @doc(vlrow) rowtemporal
function opacityordinal(args...; kwargs...) # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 13:
    nkw = [kwargs; (:type, "ordinal")] # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 14:
    vlopacity(args...; nkw...)
end
export opacityordinal
@doc @doc(vlopacity) opacityordinal
function opacitynominal(args...; kwargs...) # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 13:
    nkw = [kwargs; (:type, "nominal")] # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 14:
    vlopacity(args...; nkw...)
end
export opacitynominal
@doc @doc(vlopacity) opacitynominal
function opacityquantitative(args...; kwargs...) # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 13:
    nkw = [kwargs; (:type, "quantitative")] # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 14:
    vlopacity(args...; nkw...)
end
export opacityquantitative
@doc @doc(vlopacity) opacityquantitative
function opacitytemporal(args...; kwargs...) # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 13:
    nkw = [kwargs; (:type, "temporal")] # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 14:
    vlopacity(args...; nkw...)
end
export opacitytemporal
@doc @doc(vlopacity) opacitytemporal
function columnordinal(args...; kwargs...) # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 13:
    nkw = [kwargs; (:type, "ordinal")] # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 14:
    vlcolumn(args...; nkw...)
end
export columnordinal
@doc @doc(vlcolumn) columnordinal
function columnnominal(args...; kwargs...) # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 13:
    nkw = [kwargs; (:type, "nominal")] # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 14:
    vlcolumn(args...; nkw...)
end
export columnnominal
@doc @doc(vlcolumn) columnnominal
function columnquantitative(args...; kwargs...) # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 13:
    nkw = [kwargs; (:type, "quantitative")] # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 14:
    vlcolumn(args...; nkw...)
end
export columnquantitative
@doc @doc(vlcolumn) columnquantitative
function columntemporal(args...; kwargs...) # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 13:
    nkw = [kwargs; (:type, "temporal")] # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 14:
    vlcolumn(args...; nkw...)
end
export columntemporal
@doc @doc(vlcolumn) columntemporal
function shapeordinal(args...; kwargs...) # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 13:
    nkw = [kwargs; (:type, "ordinal")] # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 14:
    vlshape(args...; nkw...)
end
export shapeordinal
@doc @doc(vlshape) shapeordinal
function shapenominal(args...; kwargs...) # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 13:
    nkw = [kwargs; (:type, "nominal")] # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 14:
    vlshape(args...; nkw...)
end
export shapenominal
@doc @doc(vlshape) shapenominal
function shapequantitative(args...; kwargs...) # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 13:
    nkw = [kwargs; (:type, "quantitative")] # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 14:
    vlshape(args...; nkw...)
end
export shapequantitative
@doc @doc(vlshape) shapequantitative
function shapetemporal(args...; kwargs...) # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 13:
    nkw = [kwargs; (:type, "temporal")] # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 14:
    vlshape(args...; nkw...)
end
export shapetemporal
@doc @doc(vlshape) shapetemporal
function yordinal(args...; kwargs...) # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 13:
    nkw = [kwargs; (:type, "ordinal")] # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 14:
    vly(args...; nkw...)
end
export yordinal
@doc @doc(vly) yordinal
function ynominal(args...; kwargs...) # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 13:
    nkw = [kwargs; (:type, "nominal")] # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 14:
    vly(args...; nkw...)
end
export ynominal
@doc @doc(vly) ynominal
function yquantitative(args...; kwargs...) # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 13:
    nkw = [kwargs; (:type, "quantitative")] # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 14:
    vly(args...; nkw...)
end
export yquantitative
@doc @doc(vly) yquantitative
function ytemporal(args...; kwargs...) # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 13:
    nkw = [kwargs; (:type, "temporal")] # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 14:
    vly(args...; nkw...)
end
export ytemporal
@doc @doc(vly) ytemporal
function tooltipordinal(args...; kwargs...) # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 13:
    nkw = [kwargs; (:type, "ordinal")] # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 14:
    vltooltip(args...; nkw...)
end
export tooltipordinal
@doc @doc(vltooltip) tooltipordinal
function tooltipnominal(args...; kwargs...) # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 13:
    nkw = [kwargs; (:type, "nominal")] # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 14:
    vltooltip(args...; nkw...)
end
export tooltipnominal
@doc @doc(vltooltip) tooltipnominal
function tooltipquantitative(args...; kwargs...) # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 13:
    nkw = [kwargs; (:type, "quantitative")] # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 14:
    vltooltip(args...; nkw...)
end
export tooltipquantitative
@doc @doc(vltooltip) tooltipquantitative
function tooltiptemporal(args...; kwargs...) # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 13:
    nkw = [kwargs; (:type, "temporal")] # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 14:
    vltooltip(args...; nkw...)
end
export tooltiptemporal
@doc @doc(vltooltip) tooltiptemporal
function x2ordinal(args...; kwargs...) # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 13:
    nkw = [kwargs; (:type, "ordinal")] # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 14:
    vlx2(args...; nkw...)
end
export x2ordinal
@doc @doc(vlx2) x2ordinal
function x2nominal(args...; kwargs...) # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 13:
    nkw = [kwargs; (:type, "nominal")] # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 14:
    vlx2(args...; nkw...)
end
export x2nominal
@doc @doc(vlx2) x2nominal
function x2quantitative(args...; kwargs...) # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 13:
    nkw = [kwargs; (:type, "quantitative")] # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 14:
    vlx2(args...; nkw...)
end
export x2quantitative
@doc @doc(vlx2) x2quantitative
function x2temporal(args...; kwargs...) # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 13:
    nkw = [kwargs; (:type, "temporal")] # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 14:
    vlx2(args...; nkw...)
end
export x2temporal
@doc @doc(vlx2) x2temporal
function sizeordinal(args...; kwargs...) # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 13:
    nkw = [kwargs; (:type, "ordinal")] # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 14:
    vlsize(args...; nkw...)
end
export sizeordinal
@doc @doc(vlsize) sizeordinal
function sizenominal(args...; kwargs...) # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 13:
    nkw = [kwargs; (:type, "nominal")] # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 14:
    vlsize(args...; nkw...)
end
export sizenominal
@doc @doc(vlsize) sizenominal
function sizequantitative(args...; kwargs...) # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 13:
    nkw = [kwargs; (:type, "quantitative")] # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 14:
    vlsize(args...; nkw...)
end
export sizequantitative
@doc @doc(vlsize) sizequantitative
function sizetemporal(args...; kwargs...) # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 13:
    nkw = [kwargs; (:type, "temporal")] # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 14:
    vlsize(args...; nkw...)
end
export sizetemporal
@doc @doc(vlsize) sizetemporal
function detailordinal(args...; kwargs...) # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 13:
    nkw = [kwargs; (:type, "ordinal")] # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 14:
    vldetail(args...; nkw...)
end
export detailordinal
@doc @doc(vldetail) detailordinal
function detailnominal(args...; kwargs...) # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 13:
    nkw = [kwargs; (:type, "nominal")] # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 14:
    vldetail(args...; nkw...)
end
export detailnominal
@doc @doc(vldetail) detailnominal
function detailquantitative(args...; kwargs...) # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 13:
    nkw = [kwargs; (:type, "quantitative")] # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 14:
    vldetail(args...; nkw...)
end
export detailquantitative
@doc @doc(vldetail) detailquantitative
function detailtemporal(args...; kwargs...) # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 13:
    nkw = [kwargs; (:type, "temporal")] # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 14:
    vldetail(args...; nkw...)
end
export detailtemporal
@doc @doc(vldetail) detailtemporal
function orderordinal(args...; kwargs...) # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 13:
    nkw = [kwargs; (:type, "ordinal")] # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 14:
    vlorder(args...; nkw...)
end
export orderordinal
@doc @doc(vlorder) orderordinal
function ordernominal(args...; kwargs...) # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 13:
    nkw = [kwargs; (:type, "nominal")] # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 14:
    vlorder(args...; nkw...)
end
export ordernominal
@doc @doc(vlorder) ordernominal
function orderquantitative(args...; kwargs...) # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 13:
    nkw = [kwargs; (:type, "quantitative")] # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 14:
    vlorder(args...; nkw...)
end
export orderquantitative
@doc @doc(vlorder) orderquantitative
function ordertemporal(args...; kwargs...) # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 13:
    nkw = [kwargs; (:type, "temporal")] # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 14:
    vlorder(args...; nkw...)
end
export ordertemporal
@doc @doc(vlorder) ordertemporal
function y2ordinal(args...; kwargs...) # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 13:
    nkw = [kwargs; (:type, "ordinal")] # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 14:
    vly2(args...; nkw...)
end
export y2ordinal
@doc @doc(vly2) y2ordinal
function y2nominal(args...; kwargs...) # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 13:
    nkw = [kwargs; (:type, "nominal")] # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 14:
    vly2(args...; nkw...)
end
export y2nominal
@doc @doc(vly2) y2nominal
function y2quantitative(args...; kwargs...) # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 13:
    nkw = [kwargs; (:type, "quantitative")] # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 14:
    vly2(args...; nkw...)
end
export y2quantitative
@doc @doc(vly2) y2quantitative
function y2temporal(args...; kwargs...) # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 13:
    nkw = [kwargs; (:type, "temporal")] # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 14:
    vly2(args...; nkw...)
end
export y2temporal
@doc @doc(vly2) y2temporal
function colorordinal(args...; kwargs...) # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 13:
    nkw = [kwargs; (:type, "ordinal")] # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 14:
    vlcolor(args...; nkw...)
end
export colorordinal
@doc @doc(vlcolor) colorordinal
function colornominal(args...; kwargs...) # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 13:
    nkw = [kwargs; (:type, "nominal")] # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 14:
    vlcolor(args...; nkw...)
end
export colornominal
@doc @doc(vlcolor) colornominal
function colorquantitative(args...; kwargs...) # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 13:
    nkw = [kwargs; (:type, "quantitative")] # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 14:
    vlcolor(args...; nkw...)
end
export colorquantitative
@doc @doc(vlcolor) colorquantitative
function colortemporal(args...; kwargs...) # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 13:
    nkw = [kwargs; (:type, "temporal")] # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 14:
    vlcolor(args...; nkw...)
end
export colortemporal
@doc @doc(vlcolor) colortemporal
function textordinal(args...; kwargs...) # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 13:
    nkw = [kwargs; (:type, "ordinal")] # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 14:
    vltext(args...; nkw...)
end
export textordinal
@doc @doc(vltext) textordinal
function textnominal(args...; kwargs...) # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 13:
    nkw = [kwargs; (:type, "nominal")] # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 14:
    vltext(args...; nkw...)
end
export textnominal
@doc @doc(vltext) textnominal
function textquantitative(args...; kwargs...) # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 13:
    nkw = [kwargs; (:type, "quantitative")] # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 14:
    vltext(args...; nkw...)
end
export textquantitative
@doc @doc(vltext) textquantitative
function texttemporal(args...; kwargs...) # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 13:
    nkw = [kwargs; (:type, "temporal")] # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 14:
    vltext(args...; nkw...)
end
export texttemporal
@doc @doc(vltext) texttemporal
function encode_x(field::Symbol, args...; kwargs...) # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 31:
    contains((i->begin  # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 31:
                    i[1]
                end), kwargs, :field) && error("You cannot pass a keyword argument named 'field'.") # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 32:
    nkw = [kwargs; (:field, field)] # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 33:
    encoding(vlx(args...; nkw...))
end
function encode_x(shorthand::String, args...; kwargs...) # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 37:
    parts = match(@r_str("(\\w+)(\\(\\w+\\))?(:[QqOoNnTt])?"), shorthand) # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 39:
    if parts[2] == nothing # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 40:
        field_name = parts[1] # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 41:
        agg_name = nothing
    else  # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 43:
        field_name = (parts[2])[2:end - 1] # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 44:
        agg_name = parts[1]
    end # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 46:
    vl_type = if parts[3] != nothing && uppercase((parts[3])[2:end]) == "Q" # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 47:
            "quantitative"
        else  # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 48:
            if parts[3] != nothing && uppercase((parts[3])[2:end]) == "O" # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 49:
                "ordinal"
            else  # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 50:
                if parts[3] != nothing && uppercase((parts[3])[2:end]) == "N" # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 51:
                    "nominal"
                else  # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 52:
                    if parts[3] != nothing && uppercase((parts[3])[2:end]) == "T" # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 53:
                        "temporal"
                    else  # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 55:
                        nothing
                    end
                end
            end
        end # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 58:
    parts = split(shorthand, ':') # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 60:
    nkw = [kwargs; (:field, Symbol(field_name))] # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 61:
    if vl_type != nothing # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 62:
        nkw = [nkw; (:type, vl_type)]
    end # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 64:
    if agg_name != nothing # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 65:
        nkw = [nkw; (:aggregate, String(agg_name))]
    end # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 68:
    encoding(vlx(args...; nkw...))
end
export encode_x
function encode_row(field::Symbol, args...; kwargs...) # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 31:
    contains((i->begin  # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 31:
                    i[1]
                end), kwargs, :field) && error("You cannot pass a keyword argument named 'field'.") # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 32:
    nkw = [kwargs; (:field, field)] # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 33:
    encoding(vlrow(args...; nkw...))
end
function encode_row(shorthand::String, args...; kwargs...) # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 37:
    parts = match(@r_str("(\\w+)(\\(\\w+\\))?(:[QqOoNnTt])?"), shorthand) # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 39:
    if parts[2] == nothing # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 40:
        field_name = parts[1] # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 41:
        agg_name = nothing
    else  # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 43:
        field_name = (parts[2])[2:end - 1] # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 44:
        agg_name = parts[1]
    end # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 46:
    vl_type = if parts[3] != nothing && uppercase((parts[3])[2:end]) == "Q" # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 47:
            "quantitative"
        else  # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 48:
            if parts[3] != nothing && uppercase((parts[3])[2:end]) == "O" # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 49:
                "ordinal"
            else  # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 50:
                if parts[3] != nothing && uppercase((parts[3])[2:end]) == "N" # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 51:
                    "nominal"
                else  # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 52:
                    if parts[3] != nothing && uppercase((parts[3])[2:end]) == "T" # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 53:
                        "temporal"
                    else  # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 55:
                        nothing
                    end
                end
            end
        end # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 58:
    parts = split(shorthand, ':') # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 60:
    nkw = [kwargs; (:field, Symbol(field_name))] # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 61:
    if vl_type != nothing # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 62:
        nkw = [nkw; (:type, vl_type)]
    end # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 64:
    if agg_name != nothing # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 65:
        nkw = [nkw; (:aggregate, String(agg_name))]
    end # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 68:
    encoding(vlrow(args...; nkw...))
end
export encode_row
function encode_opacity(field::Symbol, args...; kwargs...) # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 31:
    contains((i->begin  # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 31:
                    i[1]
                end), kwargs, :field) && error("You cannot pass a keyword argument named 'field'.") # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 32:
    nkw = [kwargs; (:field, field)] # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 33:
    encoding(vlopacity(args...; nkw...))
end
function encode_opacity(shorthand::String, args...; kwargs...) # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 37:
    parts = match(@r_str("(\\w+)(\\(\\w+\\))?(:[QqOoNnTt])?"), shorthand) # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 39:
    if parts[2] == nothing # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 40:
        field_name = parts[1] # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 41:
        agg_name = nothing
    else  # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 43:
        field_name = (parts[2])[2:end - 1] # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 44:
        agg_name = parts[1]
    end # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 46:
    vl_type = if parts[3] != nothing && uppercase((parts[3])[2:end]) == "Q" # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 47:
            "quantitative"
        else  # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 48:
            if parts[3] != nothing && uppercase((parts[3])[2:end]) == "O" # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 49:
                "ordinal"
            else  # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 50:
                if parts[3] != nothing && uppercase((parts[3])[2:end]) == "N" # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 51:
                    "nominal"
                else  # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 52:
                    if parts[3] != nothing && uppercase((parts[3])[2:end]) == "T" # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 53:
                        "temporal"
                    else  # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 55:
                        nothing
                    end
                end
            end
        end # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 58:
    parts = split(shorthand, ':') # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 60:
    nkw = [kwargs; (:field, Symbol(field_name))] # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 61:
    if vl_type != nothing # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 62:
        nkw = [nkw; (:type, vl_type)]
    end # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 64:
    if agg_name != nothing # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 65:
        nkw = [nkw; (:aggregate, String(agg_name))]
    end # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 68:
    encoding(vlopacity(args...; nkw...))
end
export encode_opacity
function encode_column(field::Symbol, args...; kwargs...) # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 31:
    contains((i->begin  # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 31:
                    i[1]
                end), kwargs, :field) && error("You cannot pass a keyword argument named 'field'.") # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 32:
    nkw = [kwargs; (:field, field)] # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 33:
    encoding(vlcolumn(args...; nkw...))
end
function encode_column(shorthand::String, args...; kwargs...) # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 37:
    parts = match(@r_str("(\\w+)(\\(\\w+\\))?(:[QqOoNnTt])?"), shorthand) # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 39:
    if parts[2] == nothing # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 40:
        field_name = parts[1] # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 41:
        agg_name = nothing
    else  # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 43:
        field_name = (parts[2])[2:end - 1] # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 44:
        agg_name = parts[1]
    end # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 46:
    vl_type = if parts[3] != nothing && uppercase((parts[3])[2:end]) == "Q" # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 47:
            "quantitative"
        else  # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 48:
            if parts[3] != nothing && uppercase((parts[3])[2:end]) == "O" # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 49:
                "ordinal"
            else  # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 50:
                if parts[3] != nothing && uppercase((parts[3])[2:end]) == "N" # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 51:
                    "nominal"
                else  # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 52:
                    if parts[3] != nothing && uppercase((parts[3])[2:end]) == "T" # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 53:
                        "temporal"
                    else  # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 55:
                        nothing
                    end
                end
            end
        end # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 58:
    parts = split(shorthand, ':') # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 60:
    nkw = [kwargs; (:field, Symbol(field_name))] # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 61:
    if vl_type != nothing # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 62:
        nkw = [nkw; (:type, vl_type)]
    end # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 64:
    if agg_name != nothing # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 65:
        nkw = [nkw; (:aggregate, String(agg_name))]
    end # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 68:
    encoding(vlcolumn(args...; nkw...))
end
export encode_column
function encode_shape(field::Symbol, args...; kwargs...) # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 31:
    contains((i->begin  # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 31:
                    i[1]
                end), kwargs, :field) && error("You cannot pass a keyword argument named 'field'.") # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 32:
    nkw = [kwargs; (:field, field)] # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 33:
    encoding(vlshape(args...; nkw...))
end
function encode_shape(shorthand::String, args...; kwargs...) # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 37:
    parts = match(@r_str("(\\w+)(\\(\\w+\\))?(:[QqOoNnTt])?"), shorthand) # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 39:
    if parts[2] == nothing # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 40:
        field_name = parts[1] # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 41:
        agg_name = nothing
    else  # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 43:
        field_name = (parts[2])[2:end - 1] # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 44:
        agg_name = parts[1]
    end # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 46:
    vl_type = if parts[3] != nothing && uppercase((parts[3])[2:end]) == "Q" # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 47:
            "quantitative"
        else  # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 48:
            if parts[3] != nothing && uppercase((parts[3])[2:end]) == "O" # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 49:
                "ordinal"
            else  # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 50:
                if parts[3] != nothing && uppercase((parts[3])[2:end]) == "N" # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 51:
                    "nominal"
                else  # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 52:
                    if parts[3] != nothing && uppercase((parts[3])[2:end]) == "T" # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 53:
                        "temporal"
                    else  # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 55:
                        nothing
                    end
                end
            end
        end # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 58:
    parts = split(shorthand, ':') # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 60:
    nkw = [kwargs; (:field, Symbol(field_name))] # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 61:
    if vl_type != nothing # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 62:
        nkw = [nkw; (:type, vl_type)]
    end # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 64:
    if agg_name != nothing # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 65:
        nkw = [nkw; (:aggregate, String(agg_name))]
    end # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 68:
    encoding(vlshape(args...; nkw...))
end
export encode_shape
function encode_y(field::Symbol, args...; kwargs...) # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 31:
    contains((i->begin  # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 31:
                    i[1]
                end), kwargs, :field) && error("You cannot pass a keyword argument named 'field'.") # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 32:
    nkw = [kwargs; (:field, field)] # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 33:
    encoding(vly(args...; nkw...))
end
function encode_y(shorthand::String, args...; kwargs...) # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 37:
    parts = match(@r_str("(\\w+)(\\(\\w+\\))?(:[QqOoNnTt])?"), shorthand) # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 39:
    if parts[2] == nothing # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 40:
        field_name = parts[1] # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 41:
        agg_name = nothing
    else  # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 43:
        field_name = (parts[2])[2:end - 1] # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 44:
        agg_name = parts[1]
    end # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 46:
    vl_type = if parts[3] != nothing && uppercase((parts[3])[2:end]) == "Q" # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 47:
            "quantitative"
        else  # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 48:
            if parts[3] != nothing && uppercase((parts[3])[2:end]) == "O" # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 49:
                "ordinal"
            else  # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 50:
                if parts[3] != nothing && uppercase((parts[3])[2:end]) == "N" # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 51:
                    "nominal"
                else  # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 52:
                    if parts[3] != nothing && uppercase((parts[3])[2:end]) == "T" # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 53:
                        "temporal"
                    else  # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 55:
                        nothing
                    end
                end
            end
        end # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 58:
    parts = split(shorthand, ':') # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 60:
    nkw = [kwargs; (:field, Symbol(field_name))] # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 61:
    if vl_type != nothing # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 62:
        nkw = [nkw; (:type, vl_type)]
    end # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 64:
    if agg_name != nothing # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 65:
        nkw = [nkw; (:aggregate, String(agg_name))]
    end # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 68:
    encoding(vly(args...; nkw...))
end
export encode_y
function encode_tooltip(field::Symbol, args...; kwargs...) # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 31:
    contains((i->begin  # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 31:
                    i[1]
                end), kwargs, :field) && error("You cannot pass a keyword argument named 'field'.") # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 32:
    nkw = [kwargs; (:field, field)] # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 33:
    encoding(vltooltip(args...; nkw...))
end
function encode_tooltip(shorthand::String, args...; kwargs...) # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 37:
    parts = match(@r_str("(\\w+)(\\(\\w+\\))?(:[QqOoNnTt])?"), shorthand) # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 39:
    if parts[2] == nothing # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 40:
        field_name = parts[1] # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 41:
        agg_name = nothing
    else  # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 43:
        field_name = (parts[2])[2:end - 1] # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 44:
        agg_name = parts[1]
    end # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 46:
    vl_type = if parts[3] != nothing && uppercase((parts[3])[2:end]) == "Q" # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 47:
            "quantitative"
        else  # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 48:
            if parts[3] != nothing && uppercase((parts[3])[2:end]) == "O" # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 49:
                "ordinal"
            else  # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 50:
                if parts[3] != nothing && uppercase((parts[3])[2:end]) == "N" # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 51:
                    "nominal"
                else  # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 52:
                    if parts[3] != nothing && uppercase((parts[3])[2:end]) == "T" # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 53:
                        "temporal"
                    else  # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 55:
                        nothing
                    end
                end
            end
        end # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 58:
    parts = split(shorthand, ':') # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 60:
    nkw = [kwargs; (:field, Symbol(field_name))] # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 61:
    if vl_type != nothing # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 62:
        nkw = [nkw; (:type, vl_type)]
    end # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 64:
    if agg_name != nothing # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 65:
        nkw = [nkw; (:aggregate, String(agg_name))]
    end # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 68:
    encoding(vltooltip(args...; nkw...))
end
export encode_tooltip
function encode_x2(field::Symbol, args...; kwargs...) # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 31:
    contains((i->begin  # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 31:
                    i[1]
                end), kwargs, :field) && error("You cannot pass a keyword argument named 'field'.") # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 32:
    nkw = [kwargs; (:field, field)] # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 33:
    encoding(vlx2(args...; nkw...))
end
function encode_x2(shorthand::String, args...; kwargs...) # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 37:
    parts = match(@r_str("(\\w+)(\\(\\w+\\))?(:[QqOoNnTt])?"), shorthand) # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 39:
    if parts[2] == nothing # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 40:
        field_name = parts[1] # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 41:
        agg_name = nothing
    else  # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 43:
        field_name = (parts[2])[2:end - 1] # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 44:
        agg_name = parts[1]
    end # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 46:
    vl_type = if parts[3] != nothing && uppercase((parts[3])[2:end]) == "Q" # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 47:
            "quantitative"
        else  # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 48:
            if parts[3] != nothing && uppercase((parts[3])[2:end]) == "O" # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 49:
                "ordinal"
            else  # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 50:
                if parts[3] != nothing && uppercase((parts[3])[2:end]) == "N" # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 51:
                    "nominal"
                else  # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 52:
                    if parts[3] != nothing && uppercase((parts[3])[2:end]) == "T" # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 53:
                        "temporal"
                    else  # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 55:
                        nothing
                    end
                end
            end
        end # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 58:
    parts = split(shorthand, ':') # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 60:
    nkw = [kwargs; (:field, Symbol(field_name))] # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 61:
    if vl_type != nothing # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 62:
        nkw = [nkw; (:type, vl_type)]
    end # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 64:
    if agg_name != nothing # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 65:
        nkw = [nkw; (:aggregate, String(agg_name))]
    end # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 68:
    encoding(vlx2(args...; nkw...))
end
export encode_x2
function encode_size(field::Symbol, args...; kwargs...) # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 31:
    contains((i->begin  # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 31:
                    i[1]
                end), kwargs, :field) && error("You cannot pass a keyword argument named 'field'.") # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 32:
    nkw = [kwargs; (:field, field)] # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 33:
    encoding(vlsize(args...; nkw...))
end
function encode_size(shorthand::String, args...; kwargs...) # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 37:
    parts = match(@r_str("(\\w+)(\\(\\w+\\))?(:[QqOoNnTt])?"), shorthand) # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 39:
    if parts[2] == nothing # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 40:
        field_name = parts[1] # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 41:
        agg_name = nothing
    else  # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 43:
        field_name = (parts[2])[2:end - 1] # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 44:
        agg_name = parts[1]
    end # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 46:
    vl_type = if parts[3] != nothing && uppercase((parts[3])[2:end]) == "Q" # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 47:
            "quantitative"
        else  # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 48:
            if parts[3] != nothing && uppercase((parts[3])[2:end]) == "O" # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 49:
                "ordinal"
            else  # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 50:
                if parts[3] != nothing && uppercase((parts[3])[2:end]) == "N" # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 51:
                    "nominal"
                else  # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 52:
                    if parts[3] != nothing && uppercase((parts[3])[2:end]) == "T" # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 53:
                        "temporal"
                    else  # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 55:
                        nothing
                    end
                end
            end
        end # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 58:
    parts = split(shorthand, ':') # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 60:
    nkw = [kwargs; (:field, Symbol(field_name))] # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 61:
    if vl_type != nothing # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 62:
        nkw = [nkw; (:type, vl_type)]
    end # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 64:
    if agg_name != nothing # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 65:
        nkw = [nkw; (:aggregate, String(agg_name))]
    end # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 68:
    encoding(vlsize(args...; nkw...))
end
export encode_size
function encode_detail(field::Symbol, args...; kwargs...) # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 31:
    contains((i->begin  # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 31:
                    i[1]
                end), kwargs, :field) && error("You cannot pass a keyword argument named 'field'.") # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 32:
    nkw = [kwargs; (:field, field)] # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 33:
    encoding(vldetail(args...; nkw...))
end
function encode_detail(shorthand::String, args...; kwargs...) # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 37:
    parts = match(@r_str("(\\w+)(\\(\\w+\\))?(:[QqOoNnTt])?"), shorthand) # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 39:
    if parts[2] == nothing # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 40:
        field_name = parts[1] # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 41:
        agg_name = nothing
    else  # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 43:
        field_name = (parts[2])[2:end - 1] # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 44:
        agg_name = parts[1]
    end # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 46:
    vl_type = if parts[3] != nothing && uppercase((parts[3])[2:end]) == "Q" # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 47:
            "quantitative"
        else  # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 48:
            if parts[3] != nothing && uppercase((parts[3])[2:end]) == "O" # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 49:
                "ordinal"
            else  # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 50:
                if parts[3] != nothing && uppercase((parts[3])[2:end]) == "N" # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 51:
                    "nominal"
                else  # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 52:
                    if parts[3] != nothing && uppercase((parts[3])[2:end]) == "T" # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 53:
                        "temporal"
                    else  # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 55:
                        nothing
                    end
                end
            end
        end # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 58:
    parts = split(shorthand, ':') # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 60:
    nkw = [kwargs; (:field, Symbol(field_name))] # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 61:
    if vl_type != nothing # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 62:
        nkw = [nkw; (:type, vl_type)]
    end # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 64:
    if agg_name != nothing # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 65:
        nkw = [nkw; (:aggregate, String(agg_name))]
    end # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 68:
    encoding(vldetail(args...; nkw...))
end
export encode_detail
function encode_order(field::Symbol, args...; kwargs...) # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 31:
    contains((i->begin  # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 31:
                    i[1]
                end), kwargs, :field) && error("You cannot pass a keyword argument named 'field'.") # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 32:
    nkw = [kwargs; (:field, field)] # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 33:
    encoding(vlorder(args...; nkw...))
end
function encode_order(shorthand::String, args...; kwargs...) # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 37:
    parts = match(@r_str("(\\w+)(\\(\\w+\\))?(:[QqOoNnTt])?"), shorthand) # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 39:
    if parts[2] == nothing # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 40:
        field_name = parts[1] # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 41:
        agg_name = nothing
    else  # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 43:
        field_name = (parts[2])[2:end - 1] # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 44:
        agg_name = parts[1]
    end # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 46:
    vl_type = if parts[3] != nothing && uppercase((parts[3])[2:end]) == "Q" # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 47:
            "quantitative"
        else  # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 48:
            if parts[3] != nothing && uppercase((parts[3])[2:end]) == "O" # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 49:
                "ordinal"
            else  # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 50:
                if parts[3] != nothing && uppercase((parts[3])[2:end]) == "N" # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 51:
                    "nominal"
                else  # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 52:
                    if parts[3] != nothing && uppercase((parts[3])[2:end]) == "T" # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 53:
                        "temporal"
                    else  # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 55:
                        nothing
                    end
                end
            end
        end # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 58:
    parts = split(shorthand, ':') # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 60:
    nkw = [kwargs; (:field, Symbol(field_name))] # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 61:
    if vl_type != nothing # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 62:
        nkw = [nkw; (:type, vl_type)]
    end # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 64:
    if agg_name != nothing # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 65:
        nkw = [nkw; (:aggregate, String(agg_name))]
    end # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 68:
    encoding(vlorder(args...; nkw...))
end
export encode_order
function encode_y2(field::Symbol, args...; kwargs...) # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 31:
    contains((i->begin  # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 31:
                    i[1]
                end), kwargs, :field) && error("You cannot pass a keyword argument named 'field'.") # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 32:
    nkw = [kwargs; (:field, field)] # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 33:
    encoding(vly2(args...; nkw...))
end
function encode_y2(shorthand::String, args...; kwargs...) # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 37:
    parts = match(@r_str("(\\w+)(\\(\\w+\\))?(:[QqOoNnTt])?"), shorthand) # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 39:
    if parts[2] == nothing # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 40:
        field_name = parts[1] # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 41:
        agg_name = nothing
    else  # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 43:
        field_name = (parts[2])[2:end - 1] # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 44:
        agg_name = parts[1]
    end # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 46:
    vl_type = if parts[3] != nothing && uppercase((parts[3])[2:end]) == "Q" # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 47:
            "quantitative"
        else  # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 48:
            if parts[3] != nothing && uppercase((parts[3])[2:end]) == "O" # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 49:
                "ordinal"
            else  # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 50:
                if parts[3] != nothing && uppercase((parts[3])[2:end]) == "N" # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 51:
                    "nominal"
                else  # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 52:
                    if parts[3] != nothing && uppercase((parts[3])[2:end]) == "T" # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 53:
                        "temporal"
                    else  # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 55:
                        nothing
                    end
                end
            end
        end # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 58:
    parts = split(shorthand, ':') # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 60:
    nkw = [kwargs; (:field, Symbol(field_name))] # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 61:
    if vl_type != nothing # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 62:
        nkw = [nkw; (:type, vl_type)]
    end # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 64:
    if agg_name != nothing # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 65:
        nkw = [nkw; (:aggregate, String(agg_name))]
    end # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 68:
    encoding(vly2(args...; nkw...))
end
export encode_y2
function encode_color(field::Symbol, args...; kwargs...) # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 31:
    contains((i->begin  # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 31:
                    i[1]
                end), kwargs, :field) && error("You cannot pass a keyword argument named 'field'.") # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 32:
    nkw = [kwargs; (:field, field)] # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 33:
    encoding(vlcolor(args...; nkw...))
end
function encode_color(shorthand::String, args...; kwargs...) # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 37:
    parts = match(@r_str("(\\w+)(\\(\\w+\\))?(:[QqOoNnTt])?"), shorthand) # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 39:
    if parts[2] == nothing # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 40:
        field_name = parts[1] # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 41:
        agg_name = nothing
    else  # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 43:
        field_name = (parts[2])[2:end - 1] # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 44:
        agg_name = parts[1]
    end # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 46:
    vl_type = if parts[3] != nothing && uppercase((parts[3])[2:end]) == "Q" # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 47:
            "quantitative"
        else  # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 48:
            if parts[3] != nothing && uppercase((parts[3])[2:end]) == "O" # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 49:
                "ordinal"
            else  # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 50:
                if parts[3] != nothing && uppercase((parts[3])[2:end]) == "N" # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 51:
                    "nominal"
                else  # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 52:
                    if parts[3] != nothing && uppercase((parts[3])[2:end]) == "T" # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 53:
                        "temporal"
                    else  # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 55:
                        nothing
                    end
                end
            end
        end # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 58:
    parts = split(shorthand, ':') # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 60:
    nkw = [kwargs; (:field, Symbol(field_name))] # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 61:
    if vl_type != nothing # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 62:
        nkw = [nkw; (:type, vl_type)]
    end # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 64:
    if agg_name != nothing # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 65:
        nkw = [nkw; (:aggregate, String(agg_name))]
    end # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 68:
    encoding(vlcolor(args...; nkw...))
end
export encode_color
function encode_text(field::Symbol, args...; kwargs...) # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 31:
    contains((i->begin  # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 31:
                    i[1]
                end), kwargs, :field) && error("You cannot pass a keyword argument named 'field'.") # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 32:
    nkw = [kwargs; (:field, field)] # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 33:
    encoding(vltext(args...; nkw...))
end
function encode_text(shorthand::String, args...; kwargs...) # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 37:
    parts = match(@r_str("(\\w+)(\\(\\w+\\))?(:[QqOoNnTt])?"), shorthand) # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 39:
    if parts[2] == nothing # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 40:
        field_name = parts[1] # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 41:
        agg_name = nothing
    else  # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 43:
        field_name = (parts[2])[2:end - 1] # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 44:
        agg_name = parts[1]
    end # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 46:
    vl_type = if parts[3] != nothing && uppercase((parts[3])[2:end]) == "Q" # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 47:
            "quantitative"
        else  # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 48:
            if parts[3] != nothing && uppercase((parts[3])[2:end]) == "O" # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 49:
                "ordinal"
            else  # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 50:
                if parts[3] != nothing && uppercase((parts[3])[2:end]) == "N" # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 51:
                    "nominal"
                else  # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 52:
                    if parts[3] != nothing && uppercase((parts[3])[2:end]) == "T" # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 53:
                        "temporal"
                    else  # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 55:
                        nothing
                    end
                end
            end
        end # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 58:
    parts = split(shorthand, ':') # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 60:
    nkw = [kwargs; (:field, Symbol(field_name))] # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 61:
    if vl_type != nothing # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 62:
        nkw = [nkw; (:type, vl_type)]
    end # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 64:
    if agg_name != nothing # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 65:
        nkw = [nkw; (:aggregate, String(agg_name))]
    end # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 68:
    encoding(vltext(args...; nkw...))
end
export encode_text
function markpoint(args...; kwargs...) # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 81:
    nkw = [kwargs; (:type, "point")] # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 82:
    vlmark(args...; nkw...)
end
export markpoint
@doc @doc(vlmark) markpoint
function markline(args...; kwargs...) # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 81:
    nkw = [kwargs; (:type, "line")] # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 82:
    vlmark(args...; nkw...)
end
export markline
@doc @doc(vlmark) markline
function markbar(args...; kwargs...) # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 81:
    nkw = [kwargs; (:type, "bar")] # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 82:
    vlmark(args...; nkw...)
end
export markbar
@doc @doc(vlmark) markbar
function marktick(args...; kwargs...) # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 81:
    nkw = [kwargs; (:type, "tick")] # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 82:
    vlmark(args...; nkw...)
end
export marktick
@doc @doc(vlmark) marktick
function markrect(args...; kwargs...) # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 81:
    nkw = [kwargs; (:type, "rect")] # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 82:
    vlmark(args...; nkw...)
end
export markrect
@doc @doc(vlmark) markrect
function markarea(args...; kwargs...) # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 81:
    nkw = [kwargs; (:type, "area")] # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 82:
    vlmark(args...; nkw...)
end
export markarea
@doc @doc(vlmark) markarea
function markcircle(args...; kwargs...) # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 81:
    nkw = [kwargs; (:type, "circle")] # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 82:
    vlmark(args...; nkw...)
end
export markcircle
@doc @doc(vlmark) markcircle
function marksquare(args...; kwargs...) # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 81:
    nkw = [kwargs; (:type, "square")] # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 82:
    vlmark(args...; nkw...)
end
export marksquare
@doc @doc(vlmark) marksquare
function markrule(args...; kwargs...) # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 81:
    nkw = [kwargs; (:type, "rule")] # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 82:
    vlmark(args...; nkw...)
end
export markrule
@doc @doc(vlmark) markrule
function marktext(args...; kwargs...) # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 81:
    nkw = [kwargs; (:type, "text")] # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 82:
    vlmark(args...; nkw...)
end
export marktext
@doc @doc(vlmark) marktext
function config(args...; kwargs...) # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 100:
    vlconfig(args...; kwargs...)
end
export config
@doc @doc(vlconfig) config
function data(args...; kwargs...) # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 100:
    vldata(args...; kwargs...)
end
export data
@doc @doc(vldata) data
function transform(args...; kwargs...) # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 100:
    vltransform(args...; kwargs...)
end
export transform
@doc @doc(vltransform) transform
function selection(args...; kwargs...) # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 100:
    vlselection(args...; kwargs...)
end
export selection
@doc @doc(vlselection) selection
function encoding(args...; kwargs...) # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 100:
    vlencoding(args...; kwargs...)
end
export encoding
@doc @doc(vlencoding) encoding
function layer(args...; kwargs...) # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 100:
    vllayer(args...; kwargs...)
end
export layer
@doc @doc(vllayer) layer
function spec(args...; kwargs...) # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 100:
    vlspec(args...; kwargs...)
end
export spec
@doc @doc(vlspec) spec
function facet(args...; kwargs...) # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 100:
    vlfacet(args...; kwargs...)
end
export facet
@doc @doc(vlfacet) facet
function hconcat(args...; kwargs...) # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 100:
    vlhconcat(args...; kwargs...)
end
export hconcat
@doc @doc(vlhconcat) hconcat
function vconcat(args...; kwargs...) # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 100:
    vlvconcat(args...; kwargs...)
end
export vconcat
@doc @doc(vlvconcat) vconcat
function repeat(args...; kwargs...) # C:\Users\david\.julia\v0.6\VegaLite\scripts\func_utils.jl, line 100:
    vlrepeat(args...; kwargs...)
end
export repeat
@doc @doc(vlrepeat) repeat
