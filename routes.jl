using Genie, Genie.Requests, Genie.Renderer, Genie.Router, Genie.Renderer.Html, Genie.Exceptions
using HistoController
using DashboardsController

route("/") do
  html(:dashboards, :dashboards; layout=:app, context=DashboardsController, DashboardsController.render()...)
end

route("/histo") do
  html(:histo, :histo; layout=:base, context=HistoController, HistoController.render()...)
end
