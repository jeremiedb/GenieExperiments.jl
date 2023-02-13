module PlotlyLightController

using Stipple
using StippleUI
using Dates
using Base64

using PlotlyLight
import Stipple: render

PlotlyLight.src!(:cdn)
PlotlyLight.Defaults.parent_style[] = ""
PlotlyLight.Defaults.style[] = ""
PlotlyLight.Defaults.layout[].title.text = "Default title 3"

# plt1 = PlotlyLight.Plot(x = 1:20, y = cumsum(randn(20)), type="scatter", mode="lines+markers")
# io = IOBuffer()
# show(io, plt1)
# str = String(take!(io))

# io = IOBuffer()
# display("text/javascript", plt1)
# display(io, "text/html", plt1)
# display("text/html", plt1)
# show(io, "text/html", plt1)
# str = String(take!(io))
# str = stringmime("text/html", plt1)

function write_plotly(p::Plot)
    io = IOBuffer()
    PlotlyLight.write_plot_div(io, p)
    PlotlyLight.write_load_plotly(io)
    println(io, "<script>")
    PlotlyLight.write_newplot(io, p)
    show(io, MIME"text/javascript"(), p.js)
    print(io, "</script>\n")
    plt = String(take!(io))
    return plt
end

function Stipple.render(p::PlotlyLight.Plot)
    # PlotlyLight.display(p)
    # write_plotly(p)
    return stringmime("text/html", p)
end

@vars MyModel begin
    btn1::Bool = false

    plt_1::String = write_plotly(PlotlyLight.Plot(x = sort(rand(4)), y = randn(4)))
    plt_2::PlotlyLight.Plot = PlotlyLight.Plot(
        x = 1:20,
        y = cumsum(randn(20)),
        type = "scatter",
        mode = "lines+markers",
    )
    plt_3 = stringmime("text/html", PlotlyLight.Plot(x = sort(rand(4)), y = randn(4)))

    plt_1_data::Vector{Config} =
        [PlotlyLight.Config(x = sort(rand(10)), y = randn(10), type = "scatter")]
    plt_1_layout::Config = PlotlyLight.Config()
end

init() = Stipple.init(MyModel)

function handlers(m)
    on(m.btn1) do _
        m.plt_1[] = write_plotly(PlotlyLight.Plot(x = sort(rand(8)), y = randn(8)))
        m.plt_2[] = PlotlyLight.Plot(
            x = 1:10,
            y = cumsum(randn(10)),
            type = "scatter",
            mode = "lines+markers",
        )
        m.plt_3[] = stringmime("text/html", PlotlyLight.Plot(x = sort(rand(4)), y = randn(4)))

    end
    return m
end

end
