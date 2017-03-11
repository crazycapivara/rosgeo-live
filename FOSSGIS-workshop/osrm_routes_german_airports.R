library(sp)
library(osrm)
library(magrittr)

fn <- "FOSSGIS-workshop/data/ne_10m_airports.rds"
airports <- readRDS(fn)
class(airports)

fnc <- "FOSSGIS-workshop/data/ne_10m_admin_0_countries.rds"
germany <- readRDS(fnc) %>% subset(SUBUNIT == "Germany")
plot(germany)

airports_germany <- airports[germany, ]
plot(airports_germany, add = TRUE, col = "blue")

# get duration(s) matrix
dt_airports <- osrmTable(airports_germany)
dt_airports
airports_germany@data

# get route ...
airports_germany$name
src <- airports_germany[1, ] # Bremen
dst <- airports_germany[7, ] # Hamburg
#rbind(src, dst)@data
airport_route <- osrmRoute(src, dst, sp = TRUE)
airport_route@data[c("duration", "distance")]

airport_route_full <- osrmRoute(src, dst, overview = "full", sp = TRUE)

# ... and show it on leaflet map
library(leaflet)

leaflet() %>% addTiles() %>%
  addMarkers(data = rbind(src, dst), popup = ~ name) %>%
  addCircleMarkers(data = src, color = "green") %>%
  addPolylines(data = airport_route_full) %>%
  addControl(sprintf(
    "<b>duration:</b> %s min</br><b>dist:</b> %s km",
    airport_route$duration,
    airport_route$distance))

