module PlotlyLightController

using Stipple
using StippleUI
using Dates
using Base64
using JSON3
using PlotlyLight
import Stipple: render

PlotlyLight.Preset.Source.none!()
# PlotlyLight.Preset.Sourc  e.cdn!()
PlotlyLight.Preset.PlotContainer.iframe!()
# PlotlyLight.Preset.PlotContainer.iframe!()
# PlotlyLight.Preset.PlotContainer.responsive!()
# PlotlyLight.Preset.PlotContainer.fillwindow!()

# plt1 = PlotlyLight.Plot(x = 1:20, y = cumsum(randn(20)), type="scatter", mode="lines+markers")

# str1 = PlotlyLight.Cobweb.pretty(plt1)
# ParsedHTMLString(str1)
# str1 = stringmime("text/html", plt1)
# str1 = display("text/html", plt1)

# io = IOBuffer()
# display("text/javascript", plt1)
# display(io, "text/html", plt1)
# display("text/html", plt1)
# show(io, "text/html", plt1)
# str = String(take!(io))
# str = stringmime("text/html", plt1)
function Stipple.render(p::PlotlyLight.Plot)
    # PlotlyLight.display(p)
    return stringmime("text/html", p)
end

@vars MyModel begin
    btn1::Bool = false
    html_1::String = "<span style=\"color: red\">This should be red.</span>"
    html_2::String = "<ul><li>item 1</li><li>item 2</li></ul>"

    plt_1::String = PlotlyLight.Cobweb.pretty(PlotlyLight.Plot(x=sort(rand(4)), y=randn(4)))
    plt_2::PlotlyLight.Plot = PlotlyLight.Plot(
        x=1:20,
        y=cumsum(randn(20)),
        type="scatter",
        mode="lines+markers",
    )
    plt_3 = stringmime("text/html", PlotlyLight.Plot(x=sort(rand(4)), y=randn(4)))

    plt_1_data::Vector{Config} =
        [PlotlyLight.Config(x=sort(rand(10)), y=randn(10), type="scatter")]
    plt_1_layout::Config = PlotlyLight.Config()
end

init() = Stipple.init(MyModel)

function handlers(m)
    on(m.btn1) do _
        m.plt_1[] = PlotlyLight.Cobweb.pretty(PlotlyLight.Plot(x=sort(rand(8)), y=randn(8)))
        m.plt_2[] = PlotlyLight.Plot(
            x=1:10,
            y=cumsum(randn(10)),
            type="scatter",
            mode="lines+markers",
        )
        m.plt_3[] = stringmime("text/html", PlotlyLight.Plot(x=sort(rand(6)), y=randn(6)))

    end
    return m
end

end
