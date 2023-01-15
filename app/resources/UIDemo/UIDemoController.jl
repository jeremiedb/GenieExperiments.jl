module UIDemoController

using Stipple
using StippleUI
using Dates

@reactive mutable struct MyModel <: ReactiveModel
    name::R{String} = "MyName"

    # select
    input_text::R{String} = "default"
    input_text_code::String = "some code"
    input_num::R{Real} = 0
    # input_date::R{String} = ""
    input_date::R{Date} = Dates.today()
    # input_date::R{Real} = ""

    # select
    item::R{String} = ""
    item::R{String} = ""
    item_options::R{Vector} = ["my", "default", "options"]

    radio_item::R{String} = "circle"
    checkbox_item::R{Bool} = false

    flag::R{Bool} = false
end

init() = Stipple.init(MyModel)

function handlers(m)
    on(m.isready) do _
        m.name[] = "Initialized Name"
    end
    on(m.item) do _
        m.name[] = "item was changed"
    end
    # on(m.flag) do _
    #     m.name[] = "bottom clicked while $(m.flag[])"
    # end
    # on(m.flag) do _
    #     m.name[] = "bottom clicked while $(m.flag[])"
    # end
    return m
end

end
