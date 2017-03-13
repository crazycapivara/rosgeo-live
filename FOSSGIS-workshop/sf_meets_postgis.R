library(sf)
library(magrittr)

dsn <- "PG:dbname='natural_earth2' host='localhost' user='user'"
st_layers(dsn)

layers <- st_layers(dsn)
layer <- layers$name[10]
populated_places <- st_read(dsn, layer) %>% subset(megacity == 1)
#plot(populated_places["megacity"])
dim(populated_places)

library(leaflet)

leaflet() %>% addProviderTiles("CartoDB") %>%
  addCircleMarkers(
    data = populated_places, weight = 3, popup = ~ name,
    clusterOptions = markerClusterOptions())
