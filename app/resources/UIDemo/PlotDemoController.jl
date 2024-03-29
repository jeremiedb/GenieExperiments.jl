module PlotDemoController

using Stipple
using StippleUI
using Dates

using StipplePlotly
import CairoMakie
import Plots
using Base64

import Stipple: render

# intent: replicate Shiny behavior: https://shiny.rstudio.com/gallery/conditionalpanel-demo.html
# <img width="357.479553222656" height="300" alt="Plot object" src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAb...">
p = Plots.scatter(rand(10), rand(10))
p_static_1 = stringmime("image/png", p)

p = CairoMakie.scatter(randn(20, 2), color = 1:20)
p_static_2 = stringmime("image/png", p)

@vars MyModel begin
    name::String = "MyName"
    btn1::Bool = false
    
    plt_1_data::PlotData = StipplePlotly.PlotData(x = sort(rand(10)), y = randn(10))
    plt_1_layout::PlotLayout = StipplePlotly.PlotLayout()

    plt_static_1::String = "data:image/png;base64," * p_static_1
    plt_static_2::String = "data:image/png;base64," * p_static_2
end

init() = Stipple.init(MyModel)

function handlers(m)
    on(m.isready) do _
        m.name[] = "Initialized Name"
    end

    on(m.btn1) do _

        m.plt_1_data[] = StipplePlotly.PlotData(x = sort(rand(10)), y = randn(10))

        p = Plots.scatter(rand(5), rand(5))
        m.plt_static_1[] = "data:image/png;base64," * stringmime("image/png", p)

        fig = CairoMakie.scatter(randn(20, 2), color = 1:20)
        m.plt_static_2[] = "data:image/png;base64," * stringmime("image/png", fig)
    end
    return m
end

end
