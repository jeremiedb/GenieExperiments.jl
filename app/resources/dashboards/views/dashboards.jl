page(
  model, class = "container", title = "Iris Flowers Clustering", head_content = Genie.Assets.favicon_support(), prepend = style(
    """
    tr:nth-child(even) {
      background: #FAFAFA !important;
    }
    .st-module {
      background-color: #FFF;
      border-radius: 2px;
      box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.04);
    }
    .stipple-core .st-module > h5,
    .stipple-core .st-module > h6 {
      border-bottom: 0px !important;
    }
    """
  ), [
    heading("Iris data k-means clustering"), 
    
    row([
      cell(class = "st-module", [
        h6("Number of clusters"),
        slider(1:1:20,
          @data(:no_of_clusters);
          label = true)
      ]),
      cell(class = "st-module", [
        h6("Number of iterations"),
        slider(10:10:200,
          @data(:no_of_iterations);
          label = true)
      ]),
      cell(class = "st-module", [
        h6("X feature"),
        Stipple.select(:xfeature; options = :features)
      ]),
      cell(class = "st-module", [
        h6("Y feature"),
        Stipple.select(:yfeature; options = :features)
      ])
    ]), 
    
    row([
      cell(class = "st-module", [
        h5("Species clusters"),
        plot(:iris_plot_data; layout = :plot_layout, config = :plot_config)
      ])
      cell(class = "st-module", [
        h5("k-means clusters"),
        plot(:cluster_plot_data; layout = :plot_layout, config = :plot_config)
      ])
    ]), 
    
    row([
      cell(class = "st-module", [
        h5("Iris data"),
        table(:iris_data; pagination = :data_pagination, dense = true, flat = true, style = "height: 350px;")
      ])
    ])
  ],
  @iif(:isready)
)
