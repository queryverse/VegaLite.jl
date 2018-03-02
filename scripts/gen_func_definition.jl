include("../src/schema_parsing.jl")
include("../src/typedefs.jl")
include("../src/func_definition.jl")


### step 3 : declare functions

open(joinpath(@__DIR__, "..", "src", "generated", "funcs.jl"), "w") do f

    for sfn in keys(funcs)
        println(f, Expr(:export, sfn))
    end

    for sfn in keys(funcs)
        if isdefined(sfn)
            error("This should never happen.")
            mt = @eval typeof($sfn).name.mt
            if isdefined(mt, :module) && mt.module != current_module()
                println("   importing $sfn from $(mt.module)")
                eval( Expr(:import, Symbol(mt.module), sfn) )
            end
        end

        specnm = Symbol(vlname(sfn)) # VegaLite property name

        println(f, :(
            function ($sfn)(args...;kwargs...)
                $(Expr(:curly, :VLSpec, QuoteNode(specnm)))( wrapper($(QuoteNode(sfn)), args...; kwargs...) )
            end
        ))
    end
end
