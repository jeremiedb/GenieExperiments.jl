module UIDemoController

using GenieFramework
# using Stipple
# using StippleUI
using Dates

@vars MyModel begin
    name::String = "MyName"

    # input
    input_text::String = "default"
    input_text_code::String = "<q-input v-model=\"input_text\" label=\"Enter text\" />"
    input_num::Real= 0
    input_num_code::String = "<q-input v-model.number=\"input_num\" type=\"number\" label=\"Enter a number\" />"
    # select
    item::String = ""
    items::Vector{String} = []
    item_options::Vector = ["my", "default", "options"]

    # radio - checkbox - buttons
    radio_item::String = "circle"
    checkbox_item::Bool = false
    slider::Int = 10
    range::Dict = Dict("min" => 10, "max" => 20)

    # buttons and toggle
    button_switch::Bool = false
    button_reset::Bool = false
    button_toggle::String = "two" # not implemented in Stipple yet
    toggle::Bool = false
    toggle_array::Vector{String} = ["red"] # not implemented in Stipple yet

    # dates
    input_date::String = "2022-01-21" # "-" separator is important
    date_picker::String = "2022/01/22" # "/" separator is important
    date_picker_input::String = "2022/01/23" # "/" separator is important
    date_picker_range::Dict = Dict("from" => "2022/01/10", "to" => "2022/01/21")

    flag::Bool = false
end

init() = Stipple.init(MyModel)

function handlers(m)
    on(m.isready) do _
        m.name[] = "Initialized Name"
    end
    on(m.item) do _
        m.name[] = "item was changed"
    end
    on(m.button_reset) do _
        if m.button_reset[]
            m.button_reset[] = false
        end
    end
    return m
end

end
