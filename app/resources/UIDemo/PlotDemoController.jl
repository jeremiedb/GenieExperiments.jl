module PlotDemoController

using Stipple
using StippleUI
using Dates

using PlotlyLight
using StipplePlotly

PlotlyLight.src!(:none)
PlotlyLight.Defaults.parent_style[] = ""
PlotlyLight.Defaults.style[] = ""
PlotlyLight.Defaults.layout[].title.text = "Default title3!"

# StipplePlotly.plot(:iris_plot_data; layout = :plot_layout, config = :plot_config)
# plt1 = Plot(x = 1:20, y = cumsum(randn(20)), type="scatter", mode="lines+markers")
# pltc = StipplePlotly.PlotConfig()

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
    btn1::R{Bool} = false
    plt_1::R{String} = write_plotly(PlotlyLight.Plot(x = sort(rand(8)), y = randn(8)))
    plt_2::R{String} = write_plotly(PlotlyLight.Plot(x = sort(rand(8)), y = randn(8)))

    plt_1_data::R{PlotData} = StipplePlotly.PlotData(x = sort(rand(10)), y = randn(10))
    plt_1_layout::R{PlotLayout} = StipplePlotly.PlotLayout()

    plt_2_data::R{Vector{Config}} = [PlotlyLight.Config(x = sort(rand(20)), y = randn(20), type = "scatter")]
    plt_2_layout::R{Config} = PlotlyLight.Config()

    plt_3_data::R{Vector{Config}} = [PlotlyLight.Config(x = sort(rand(20)), y = randn(20), type = "scatter")]
    plt_3_layout::R{Config} = PlotlyLight.Config(template = PlotlyLight.template("plotly_dark"))
end

init() = Stipple.init(MyModel)

function handlers(m)
    on(m.isready) do _
        m.name[] = "Initialized Name"
    end

    on(m.btn1) do _
        m.plt_1[] = write_plotly(PlotlyLight.Plot(x = sort(rand(8)), y = randn(8)))
    end
    return m
end

end
