function interactive()
    i->begin
        Vega.getparams(i)["selection"] = OrderedDict{String,Any}()
        Vega.getparams(i)["selection"]["selector001"] = OrderedDict{String,Any}()
        Vega.getparams(i)["selection"]["selector001"]["type"] = "interval"
        Vega.getparams(i)["selection"]["selector001"]["bind"] = "scales"
        Vega.getparams(i)["selection"]["selector001"]["encodings"] = ["x", "y"]
        Vega.getparams(i)["selection"]["selector001"]["on"] = "[mousedown, window:mouseup] > window:mousemove!"
        Vega.getparams(i)["selection"]["selector001"]["translate"] = "[mousedown, window:mouseup] > window:mousemove!"
        Vega.getparams(i)["selection"]["selector001"]["zoom"] = "wheel!"
        Vega.getparams(i)["selection"]["selector001"]["mark"] = OrderedDict("fill" => "#333", "fillOpacity" => 0.125, "stroke" => "white")
        Vega.getparams(i)["selection"]["selector001"]["resolve"] = "global"
        return i
    end
end
