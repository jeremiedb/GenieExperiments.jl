module HistoController

using Genie, Genie.Renderer.Html
using Stipple, StippleUI
using StippleCharts

const hist_plot_opts = (
        chart_type = :bar,
        chart_height = 350,
        chart_toolbar_show = true,
        chart_zoom_enabled = true,
        colors = ["#9933ff"],
        data_labels_enabled = false,
        fill_opacity = 0.8,
        grid_row_colors = ["transparent"],
        grid_show = true,
        grid_yaxis_lines_show = true,
        # plot_options_bar_horizontal = true,
        plot_options_bar_border_radius = 5,
        stroke_width = 0,
        # xaxis_categories = String[],
        xaxis_tick_placement = :on,
        # xaxis_type = :category,
        yaxis_show = true
      )
      

Base.@kwdef mutable struct Model <: ReactiveModel
    process::R{Bool} = false
    input::R{Any} = 0.0
    hist::R{Vector} = []
    hist_plot_data::R{Vector{PlotSeries}} = PlotSeries[]
    hist_plot_opts::R{PlotOptions} = PlotOptions(;hist_plot_opts...)
end

function __init__()
    Stipple.register_components(Model, StippleCharts.COMPONENTS)
end

function render_histo_3()

    model = Stipple.init(Model())

    on(model.process) do _
        if (model.process[])
            input = isa(model.input[], String) ? parse(Float64, model.input[]) : convert(Float64, model.input[])
            model.hist[] = push!(model.hist[], input)

            ps = PlotSeries[]
            push!(ps, PlotSeries("serie-A", PlotData(model.hist[])))
            model.hist_plot_data[] = ps
            model.hist_plot_opts[] = PlotOptions(;hist_plot_opts...)
            model.process[] = false
        else
            nothing
        end
    end

    return (model = model,)
end

end # module
