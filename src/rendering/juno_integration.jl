######################################################################
#
#     Juno Integration
#
######################################################################

using Juno

media(VLSpec{:plot}, Media.Plot)

Juno.@render Juno.PlotPane p::VLSpec{:plot} begin
    HTML(stringmime("image/svg+xml", p))
end
