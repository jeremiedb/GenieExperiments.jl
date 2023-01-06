module DemoController

using Stipple
using StippleUI

@reactive mutable struct MyModel <: ReactiveModel
    name::R{String} = "MyName"
    item::R{String} = "allo"
    item_options::R{Vector} = ["my", "default", "options"]
    flag::R{Bool} = false
end

init() = Stipple.init(MyModel)

function handlers(m)
    on(m.isready) do _
        m.name[] = "Initialized Name"
    end
    on(m.flag) do _
        m.name[] = "bottom clicked while $(m.flag[])"
    end
    on(m.item) do _
        m.name[] = "item was changed"
    end
    return m
end

end
