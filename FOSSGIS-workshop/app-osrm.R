# shiny app using osrm
# click on map to set source and destination points
# author: stefan kuethe
# FOSSGIS 2017
# ---
library(shiny)
library(leaflet)
library(sp)
library(osrm)

wsg84 <- CRS("+proj=longlat +datum=WGS84")

.appv <- reactiveValues(
  flag = TRUE,
  src = NULL,
  dst = NULL
)

set_coords <- function(coords){
  coords <- data.frame(
    lng = coords$lng,
    lat = coords$lat,
    id = sample(1:1000, 1) # set random id
  )
  coordinates(coords) <- ~ lng + lat
  coords@proj4string <- wsg84
  if(.appv$flag){
    .appv$src = coords
    .appv$flag = FALSE
  } else {
    .appv$dst = coords
  }
}

set_marker <- function(coords){
  leafletProxy("map") %>%
    addMarkers(
      lng = coords$lng,
      lat = coords$lat
    )
}

view <- fluidPage(
  h1("osrm"),
  h2("hi, click it to set source and destinations."),
  leafletOutput("map"),
  style = "font-family: ubuntu;"
)

controller <- function(input, output){
  observeEvent(input$map_click, {
    print(input$map_click)
    set_marker(input$map_click)
    set_coords(input$map_click)
    # output current source and destination
    print(.appv$src)
    print(.appv$dst)
    # if source and destination is set then get route
    if(!is.null(.appv$src) & !is.null(.appv$dst)){
      print("get route")
      route <- osrmRoute(.appv$src, .appv$dst, sp = TRUE)
      print(route)
      # update view
      leafletProxy("map") %>%
        addPolylines(data = route, weight = 4, color = "red")
    }
  })
  
  # base view
  output$map <- renderLeaflet({
    leaflet() %>% addTiles() %>% setView(9.4706, 51.2878, 12)
  })
}

shinyApp(view, controller)
