library(sp)
library(magrittr)

names(quakes)
sp_quakes <- quakes
coordinates(sp_quakes) <- ~ long + lat
class(sp_quakes)
head(sp_quakes)
sp_quakes@coords %>% head()
sp_quakes@data %>% head()
head(quakes)
sp_quakes@proj4string
plot(sp_quakes, axes = TRUE)
sp_quakes@proj4string <- CRS("+init=epsg:4326")
plot(sp_quakes, add = TRUE, col = "yellow")

library(leaflet)

leaflet() %>% addProviderTiles("CartoDB") %>%
  addMarkers(data = sp_quakes, clusterOptions = markerClusterOptions())
