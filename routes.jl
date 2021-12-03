using Genie, Genie.Requests, Genie.Renderer, Genie.Router, Genie.Renderer.Html, Genie.Exceptions

using Stipple, StippleUI 
using StippleCharts
using HistoController

route("/") do
  serve_static_file("welcome.html")
end

route("/histo") do
  html(:histo, :histo; layout=:base, context=@__MODULE__, HistoController.render_histo_3()...)
  # HistoController.render_histo_2()
end
