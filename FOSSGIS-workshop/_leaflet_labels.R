library(leaflet)

leaflet(data = quakes[1:20,]) %>% addTiles() %>%
  addLabelOnlyMarkers(
    ~long, ~lat,
    label =  ~as.character(mag),
    clusterOptions = markerClusterOptions(),
    labelOptions = labelOptions(
      noHide = TRUE,
      direction = 'top',
      textOnly = TRUE
      )
    )