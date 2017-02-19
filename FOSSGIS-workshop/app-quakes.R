library(shiny)
library(leaflet)

view <- fluidPage(
  h1("quakes"),
  leafletOutput("map"),
  style = "font-family: ubuntu;"
)

controller <- function(input, output){
  output$map <- renderLeaflet({
    leaflet(data = quakes[1:10, ]) %>% addTiles() %>%
      addMarkers(popup = ~ sprintf("%s, %s</br><b>%s</b>", long, lat, mag))
  })
}

shinyApp(view, controller)
