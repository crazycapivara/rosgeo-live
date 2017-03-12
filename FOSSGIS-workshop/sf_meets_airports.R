library(sf)
library(magrittr)

countries <- readRDS("FOSSGIS-workshop/data/ne_10m_admin_0_countries.rds") %>%
  st_as_sf()
names(countries)
germany <- subset(countries, SUBUNIT == "Germany")
plot(germany[c("LABELRANK")])

fn <- "FOSSGIS-workshop/data/ne_10m_airports/ne_10m_airports.shp"
st_layers(fn)

airports <- st_read(fn)

ap_ger <- st_contains(germany, airports)[[1]] %>% airports[., ]
st_intersects(germany, airports)
plot(ap_ger$geometry, add = TRUE, col = "black")

pts <- airports$geometry[[1]]
class(pts)
pts[1:2]

library(leaflet)

leaflet() %>% addTiles() %>%
  addPolygons(data = germany, weight = 3) %>%
  addMarkers(data = ap_ger, popup = ~ name)
