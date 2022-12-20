# using Genie
# using Genie.Requests, Genie.Renderer, Genie.Router, Genie.Renderer.Html, Genie.Exceptions
using Stipple
# , StippleUI, StipplePlotly

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

Stipple.Pages.Page("/mini2", view = "/mini/views/ui.jl.html", model = MiniController.handlers(), context = MiniController)

module App

using Stipple
using Stipple.ReactiveTools
using StippleUI

@reactive mutable struct Model <: ReactiveModel
  name::R{String} = "MyName"
  item::R{String} = "allo"
  item_options::R{Vector} = ["allo", "hello", "bonjour"]
end

function handlers()
    m = Stipple.init(Model; core_theme = false)
    on(m.isready) do _
        m.item = "hey!"
    end
    return m
end
@page("/mini3", "ui.jl.html")
Stipple.Pages.Page("/mini4", view = "ui.jl.html", model = handlers(), context = @__MODULE__)
Stipple.Pages.Page("/mini5", view = "ui.jl.html", model = handlers(), context = @__MODULE__)
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
