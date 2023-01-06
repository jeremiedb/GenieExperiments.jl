using Genie
using Genie.Requests, Genie.Router, Genie.Renderer, Genie.Renderer.Html
using GenieExperiments.DemoController
using GenieExperiments.DashboardsController
using GenieExperiments.HistoController

route("/") do
    html(
        :demo,
        :ui;
        layout = :stipple_demo,
        model = DemoController.init() |> DemoController.handlers,
        context = DemoController,
    )
end

route("/iris") do
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
