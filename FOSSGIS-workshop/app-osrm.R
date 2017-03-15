library(shiny)
library(leaflet)

wsg84 <- sp::CRS("+proj=longlat +datum=WGS84")

.appv <- reactiveValues(
  flag = TRUE,
  src = NULL,
  dst = NULL
)

set_coords <- function(coords){
  coords <- data.frame(
    lng = coords$lng,
    lat = coords$lat, id = 1
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

view <- fluidPage(
  h1("hi, click it."),
  leafletOutput("map"),
  style = "font-family: ubuntu;"
)

controller <- function(input, output){
  observeEvent(input$map_click, {
    print(input$map_click)
    leafletProxy("map") %>%
      addMarkers(
        lng = input$map_click$lng,
        lat = input$map_click$lat
      )
    set_coords(input$map_click)
    # output current source and destination
    print(.appv$src)
    print(.appv$dst)
    # if source and destination is set then get route
    if(!is.null(.appv$src) & !is.null(.appv$dst)){
      print("get route")
      route <- osrm::osrmRoute(.appv$src, .appv$dst, sp = TRUE)
      print(route)
      leafletProxy("map") %>%
        addPolylines(data = route, weight = 4, color = "red")
    }
  })
  
  output$map <- renderLeaflet({
    leaflet() %>% addTiles() %>% setView(9.4706, 51.2878, 12)
  })
}

shinyApp(view, controller)