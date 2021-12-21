module DashboardsController

using Stipple, StippleUI, StipplePlotly

using DataFrames
using Clustering
using StatsBase
import RDatasets: dataset

const data = DataFrames.insertcols!(dataset("datasets", "iris"), :Cluster => zeros(Int, 150))
const iris_features = ["SepalLength", "SepalWidth", "PetalLength", "PetalWidth"]
# definition of the reactive model
const iris_colors = Dict(
  "setosa" => "#13c2ff",
  "versicolor" => "#e43dff",
  "virginica" => "#2401e2")

@reactive mutable struct IrisModel <: ReactiveModel
  iris_data::R{DataTable} = DataTable(data) # iris_data has data -> dataframe defined at line 13

  data_pagination::DataTablePagination = DataTablePagination(rows_per_page = 50) # DataTable, DataTablePagination are part of StippleUI which helps us set Data Table UI

  # plot data
  iris_plot_data::R{Vector{PlotData}} = PlotData[]   # PlotSeries is structure used to store data
  cluster_plot_data::R{Vector{PlotData}} = PlotData[]

  # plot_layout and config: Plotly specific 
  plot_layout::PlotLayout = PlotLayout()
  plot_config::R{PlotConfig} = PlotConfig(displaylogo = false)

  features::R{Vector{String}} = iris_features #iris dataset have following columns: https://www.kaggle.com/lalitharajesh/iris-dataset-exploratory-data-analysis/data
  xfeature::R{String} = iris_features[1]
  yfeature::R{String} = iris_features[2]

  no_of_clusters::R{Int} = 3
  no_of_iterations::R{Int} = 10
end

#= Computation =#
function plot_data(group::Symbol, model::IrisModel)
  result = PlotData[]
  isempty(model.xfeature[]) || isempty(model.yfeature[]) && return result
  for s in unique(data[:, group])
    subdata = data[data[!, group].==s, :]
    if group == :Species
      push!(result, PlotData(x = subdata[:, model.xfeature[]], y = subdata[:, model.yfeature[]],
        plot = "scatter", mode = "markers", marker = PlotDataMarker(color = iris_colors[s]), name = string(s)))
    else
      push!(result, PlotData(x = subdata[:, model.xfeature[]], y = subdata[:, model.yfeature[]],
        plot = "scatter", mode = "markers", name = string(s)))
    end
  end
  return result
end

function compute_clusters!(model::IrisModel)
  features = collect(Matrix(data[:, [Symbol(c) for c in model.features[]]])')
  result = kmeans(features, model.no_of_clusters[]; maxiter = model.no_of_iterations[])
  data[!, :Cluster] = assignments(result)
  model.iris_data[] = DataTable(data)
  model.cluster_plot_data[] = plot_data(:Cluster, model)
  return nothing
end

"""
  function render()
The render function returns the model that is fed into the view to render the Dashboard.
"""
function render()
  model = init(IrisModel)

  onany(model.xfeature, model.yfeature, model.no_of_clusters, model.no_of_iterations, model.isready) do (_...)
    model.iris_plot_data[] = plot_data(:Species, model)
    compute_clusters!(model)
  end

  return (model = model,)
end

end