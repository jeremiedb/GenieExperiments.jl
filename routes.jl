# using Genie
using Genie.Requests, Genie.Router, Genie.Renderer.Html

using GenieExperiments.UIDemoController
using GenieExperiments.IrisController

route("/") do
    html(
        :UIDemo,
        :ui;
        layout = :stipple_demo,
        model = UIDemoController.init() |> UIDemoController.handlers,
        context = UIDemoController,
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
