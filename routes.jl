# using Genie
using Genie.Requests, Genie.Router, Genie.Renderer.Html

using GenieExperiments.DemoController
using GenieExperiments.DashboardsController
using GenieExperiments.HistoController

using GenieExperiments.UIDemoController

route("/") do
    html(
        :demo,
        :ui;
        layout = :stipple_demo,
        model = DemoController.init() |> DemoController.handlers,
        context = DemoController,
    )
end

route("/demo") do
    html(
        path"views/stipple/demo1.jl.html",
        layout = path"layouts/stipple.jl.html",
        model = DemoController.init() |> DemoController.handlers,
        context = DemoController,
    )
end

route("/uidemo") do
    html(
        path"app/resources/UIDemo/views/ui.jl.html",
        layout = path"app/layouts/stipple_demo.jl.html",
        model = UIDemoController.init() |> UIDemoController.handlers,
        context = UIDemoController,
    )
end

route("/md1") do
    html(
        path"views/markdown/blog1.jl.md",
        layout = path"layouts/markdown.jl.html",
        context = @__MODULE__,
    )
end

route("/md2") do
    html(
        path"views/markdown/blog1.jl.md",
        layout = path"layouts/markdown.jl.html",
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
