library(shiny)
library(leaflet)

view <- fluidPage(
  h1("hi, click it."),
  leafletOutput("map"),
  style = "font-family: ubuntu;"
)

controller <- function(input, output){
  observeEvent(input$map_click, {
    print(input$map_click)
    leafletProxy("map") %>% addMarkers(
      lng = input$map_click$lng,
      lat = input$map_click$lat)
  })
  output$map <- renderLeaflet({
    leaflet() %>% addTiles() %>% setView(9.5, 40, 6)
  })
}

shinyApp(view, controller)