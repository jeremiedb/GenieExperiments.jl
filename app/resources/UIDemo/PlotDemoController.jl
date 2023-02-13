module PlotDemoController

using Stipple
using StippleUI
using Dates

using StipplePlotly
using PlotlyLight
import CairoMakie
import Plots
using Base64

import Stipple: render

PlotlyLight.src!(:cdn)
PlotlyLight.Defaults.parent_style[] = ""
PlotlyLight.Defaults.style[] = ""
PlotlyLight.Defaults.layout[].title.text = "Default title3!"

# StipplePlotly.plot(:iris_plot_data; layout = :plot_layout, config = :plot_config)
# plt1 = Plot(x = 1:20, y = cumsum(randn(20)), type="scatter", mode="lines+markers")
# pltc = StipplePlotly.PlotConfig()

# intent: replicate Shiny behavior: https://shiny.rstudio.com/gallery/conditionalpanel-demo.html
# <img width="357.479553222656" height="300" alt="Plot object" src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAb...">
p = Plots.scatter(rand(10), rand(10))
p_static_1 = stringmime("image/png", p)

p = CairoMakie.scatter(randn(20, 2), color = 1:20)
p_static_2 = stringmime("image/png", p)

# f = CairoMakie.Figure()
# ax1 = CairoMakie.Axis(f[1, 1], yticklabelcolor = :black, yaxisposition = :right)
# ax2 = CairoMakie.Axis(f[1, 1], yticklabelcolor = :black, yaxisposition = :left)
# CairoMakie.hidespines!(ax1)
# CairoMakie.hidexdecorations!(ax1)
# CairoMakie.lines!(ax2, 0:10, sin, color = :navy)
# CairoMakie.barplot!(ax1, 0:10, rand(11) .* 100, color = "#3399CC66")
# f
# io = IOBuffer()
# show(io, MIME("image/png"), p)
# str = take!(io)
# base64encode(str)
# io = IOBuffer()
# show(io, MIME("text/html"), p)
# str = take!(io)
# base64encode(str)

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

function Stipple.render(p::PlotlyLight.Plot)
    # PlotlyLight.display(p)
    write_plotly(p)
end

@vars MyModel begin
    name::String = "MyName"
    btn1::Bool = false
    
    plt_1::String = write_plotly(PlotlyLight.Plot(x = sort(rand(4)), y = randn(4)))
    plt_2::PlotlyLight.Plot = PlotlyLight.Plot(x = 1:20, y = cumsum(randn(20)), type="scatter", mode="lines+markers")

    plt_1_data::PlotData = StipplePlotly.PlotData(x = sort(rand(10)), y = randn(10))
    plt_1_layout::PlotLayout = StipplePlotly.PlotLayout()

    plt_2_data::Vector{Config} =
        [PlotlyLight.Config(x = sort(rand(20)), y = randn(20), type = "scatter")]
    plt_2_layout::Config = PlotlyLight.Config()

    plt_3_data::Vector{Config} =
        [PlotlyLight.Config(x = sort(rand(20)), y = randn(20), type = "scatter")]
    plt_3_layout::Config =
        PlotlyLight.Config(template = PlotlyLight.template("plotly_dark"))

    plt_static_1::String = "data:image/png;base64," * p_static_1
    plt_static_2::String = "data:image/png;base64," * p_static_2
end

init() = Stipple.init(MyModel)

function handlers(m)
    on(m.isready) do _
        m.name[] = "Initialized Name"
    end

    on(m.btn1) do _
        m.plt_1[] = write_plotly(PlotlyLight.Plot(x = sort(rand(8)), y = randn(8)))

        p = Plots.scatter(rand(5), rand(5))
        m.plt_static_1[] = "data:image/png;base64," * stringmime("image/png", p)

        fig = CairoMakie.scatter(randn(20, 2), color = 1:20)
        m.plt_static_2[] = "data:image/png;base64," * stringmime("image/png", fig)
    end
    return m
end

end
