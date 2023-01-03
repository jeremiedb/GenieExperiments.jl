# using Genie
# using Genie.Requests, Genie.Renderer, Genie.Router, Genie.Renderer.Html, Genie.Exceptions
using Stipple
using GenieExperiments.MiniController

route("/mini1A") do
    html(
        :mini,
        :ui1;
        layout = :app,
        context = MiniController,
        Model = MiniController.handlers(),
    )
end
Stipple.Pages.Page("/mini1B", view = "/mini/views/ui1.jl.html", model = MiniController.handlers(), context = MiniController)

route("/mini2A") do
    html(
        :mini,
        :ui2;
        layout = :app,
        context = MiniController,
        Model = MiniController.handlers(),
    )
end
Stipple.Pages.Page("/mini2B", view = "/mini/views/ui2.jl.html", model = MiniController.handlers(), context = MiniController)

module App

using Stipple
using Stipple.ReactiveTools
using StippleUI

@reactive mutable struct Model <: ReactiveModel
  name::R{String} = "MyName"
  item::R{String} = "allo"
  item_options::R{Vector} = ["salut", "bonjour"]
end

function handlers()
    m = Stipple.init(Model)
    on(m.isready) do _
        m.item = "hey!"
    end
    return m
end
@page("/mini3A", "ui1.jl.html")
Stipple.Pages.Page("/mini3B", view = "ui1.jl.html", model = handlers(), context = @__MODULE__)

@page("/mini4A", "ui2.jl.html")
Stipple.Pages.Page("/mini4B", view = "ui2.jl.html", model = handlers(), context = @__MODULE__)

end


using GenieExperiments.DashboardsController
using GenieExperiments.HistoController

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
