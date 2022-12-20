module MiniController

using Stipple
using StippleUI

@reactive mutable struct Model <: ReactiveModel
  name::R{String} = "MyName"
  item::R{String} = "allo"
  item_options::R{Vector} = ["allo", "hello", "bonjour"]
end

# StippleUI.Selects.select(:feature, options = :features)
# html(Stipple.select(:feature, options = :features))

function handlers()

    m = Stipple.init(Model; core_theme = false)

    on(m.isready) do _
        m.item = "hey!"
    end

    return m
end

end

# Stipple.page(m, [
#   Stipple.select(:feature, options = :name),
#   # Stipple.select(:feature, options = :features)
# ])