module HistoController

using Stipple, StippleUI, StipplePlotly
using StatsBase

@reactive mutable struct Model <: ReactiveModel
    process::R{Bool} = false
    input::R{Any} = 0.0
    hist::R{Vector} = []

    line_plot_data::R{Vector{PlotData}} = PlotData[]
    hist_plot_data::R{Vector{PlotData}} = PlotData[]
    plot_layout::PlotLayout = PlotLayout()
    plot_config::R{PlotConfig} = PlotConfig(displaylogo = false)
end

function render()

    model = init(Model)

    onany(model.process, model.isready) do (_...)
        if (model.process[])

            input = isa(model.input[], String) ? parse(Float64, model.input[]) : convert(Float64, model.input[])
            model.hist[] = push!(model.hist[], input)

            pd1 = PlotData[]
            push!(pd1, PlotData(x = collect(1:length(model.hist[])), y = model.hist[],
                plot = "scatter", mode = "markers+lines", marker = PlotDataMarker(color = "darkred"), name = "Numbers sequence"))
            model.line_plot_data[] = pd1

            # hist data
            data = Float64.(model.hist[])
            range_raw = extrema(data)
            range_ext = (range_raw[1] - 0.01 * (range_raw[2] - range_raw[1]), range_raw[2] + 0.01 * (range_raw[2] - range_raw[1]))
            edges = range(range_ext[1], range_ext[2], length = 11)
            cdf = ecdf(Float64.(data))
            hist_val = diff(cdf.(edges))
            # hist plot
            pd2 = PlotData[]
            # push!(pd2, PlotData(x = edges[2:end], y = hist_val,
            #     plot = "scatter", mode = "lines", marker = PlotDataMarker(color = "darkred"), name = "Numbers sequence"))
            push!(pd2, PlotData(x = model.hist[], plot = "histogram", name = "Numbers sequence"))
            model.hist_plot_data[] = pd2

            model.process[] = false
        else
            nothing
        end
    end

    return (model = model,)
end

end # module
