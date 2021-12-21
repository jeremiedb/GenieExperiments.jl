using Genie, Stipple, StippleUI, StipplePlotly
using Genie.Requests, Genie.Renderer, Genie.Router, Genie.Renderer.Html, Genie.Exceptions
using DashboardsController
using HistoController

if isprod()
  for m in [Genie, Stipple, StippleUI, StipplePlotly]
    m.assets_config.host = "https://cdn.statically.io/gh/GenieFramework"
  end
end

route("/") do
  html(:dashboards, "dashboards.jl"; layout=:app, context=DashboardsController, DashboardsController.render()...)
end

route("/histo") do
  html(:histo, "histo.jl"; layout=:app, context=HistoController, HistoController.render()...)
end
