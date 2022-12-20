using Genie
using Genie.Requests, Genie.Renderer, Genie.Router, Genie.Renderer.Html, Genie.Exceptions
# using Stipple, StippleUI, StipplePlotly

using GenieExperiments.DashboardsController
using GenieExperiments.HistoController
using GenieExperiments.MiniController

route("/mini") do
    html(
        :mini,
        :ui;
        layout = :app,
        context = MiniController,
        Model = MiniController.handlers(),
    )
end

route("/") do
    html(
        :dashboards,
        "dashboards.jl";
        layout = :app,
        context = DashboardsController,
        DashboardsController.render()...,
    )
end

route("/hist") do
    html(
        :histo,
        "histo.jl";
        layout = :app,
        context = HistoController,
        HistoController.render()...,
    )
end
