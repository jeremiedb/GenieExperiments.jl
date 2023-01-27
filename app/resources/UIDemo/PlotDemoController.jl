module PlotDemoController

using Stipple
using StippleUI
using PlotlyLight
using Dates

PlotlyLight.src!(:cdn)

function write_plotly(o::Plot)
    io = IOBuffer()
    PlotlyLight.write_plot_div(io, o)
    PlotlyLight.write_load_plotly(io)
    println(io, "<script>")
    PlotlyLight.write_newplot(io, o)
    show(io, MIME"text/javascript"(), o.js)
    print(io, "</script>\n")
    plt = String(take!(io))
    return plt
end

@reactive mutable struct MyModel <: ReactiveModel
    name::R{String} = "MyName"
    # input
    # plt_1::R{Plot} = PlotlyLight.Plot(x = sort(rand(8)), y = randn(8))
    plt_1::R{String} = write_plotly(PlotlyLight.Plot(x = sort(rand(8)), y = randn(8)))
    plt_2::R{String} = write_plotly(PlotlyLight.Plot(x = sort(rand(8)), y = randn(8)))
end

init() = Stipple.init(MyModel)

function handlers(m)
    on(m.isready) do _
        m.name[] = "Initialized Name"
    end
    return m
end

end
