# using Genie
using Genie.Requests, Genie.Router, Genie.Renderer.Html

using GenieExperiments.UIDemoController
using GenieExperiments.IrisController
using GenieExperiments.PlotDemoController
using GenieExperiments.PlotlyLightController

route("/") do
    html(
        :UIDemo,
        :ui;
        layout = :stipple_demo,
        model = UIDemoController.init() |> UIDemoController.handlers,
        context = UIDemoController,
    )
end

route("/plotdemo") do
    html(
        path"app/resources/UIDemo/views/plot.jl.html",
        layout = path"app/layouts/stipple_demo.jl.html",
        model = PlotDemoController.init() |> PlotDemoController.handlers,
        context = PlotDemoController,
    )
end

route("/plotlylight") do
    html(
        path"app/resources/UIDemo/views/plotlylight.jl.html",
        layout = path"app/layouts/stipple_demo.jl.html",
        model = PlotlyLightController.init() |> PlotlyLightController.handlers,
        context = PlotlyLightController,
    )
end

route("/uidemo1") do
    html(
        path"app/resources/UIDemo/views/ui.jl.html",
        layout = path"app/layouts/stipple_demo.jl.html",
        model = UIDemoController.init() |> UIDemoController.handlers,
        context = UIDemoController,
    )
end

route("/uidemo2") do
    html(
        path"app/resources/UIDemo/views/ui.jl.html",
        layout = path"app/layouts/stipple_partial.jl.html",
        model = UIDemoController.init() |> UIDemoController.handlers,
        context = UIDemoController,
    )
end

route("/uidemo3") do
    html(
        path"app/resources/UIDemo/views/ui.jl.html",
        layout = path"app/layouts/stipple_layout.jl.html",
        model = UIDemoController.init() |> UIDemoController.handlers,
        context = UIDemoController,
    )
end

route("/md1") do
    html(
        path"app/resources/blog/views/blog1.jl.md",
        layout = path"app/layouts/blog.jl.html",
        context = @__MODULE__,
    )
end

route("/md2") do
    html(
        path"app/resources/blog/views/blog1.jl.md",
        layout = path"app/layouts/blog.jl.html",
    )
end

route("/iris") do
    html(
        :dashboards,
        "dashboards.jl";
        layout = :app,
        context = IrisController,
        IrisController.render()...,
    )
end
