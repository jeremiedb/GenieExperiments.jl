page(
    model,
    class = "container",
    [
        row([
            Html.div(
                class = "col-md-3 px-5 py-3",
                [
                    p([
                        "Input: ",
                        input("", @bind(:input), @on("keyup.enter", "process = true"))
                    ]),
                    p([
                        button("UPDATE", @click("process = true"))
                    ]),
                    p([
                        Html.span("", @text(:hist))
                    ])
                ])
        ]),
		
		row([
            Html.div(class = "col-md-6 px-3", [
                cell([
                    plot(:line_plot_data; layout = :plot_layout, config = :plot_config, height = 200)
                ])
            ]),
            Html.div(class = "col-md-6 px-3", [
                cell([
                    plot(:hist_plot_data; layout = :plot_layout, config = :plot_config, height = 200)
                ])
            ])
        ])
    ],
    @iif(:isready)
)
