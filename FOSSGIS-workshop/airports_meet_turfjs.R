library(sf)
library(lawn) # turfjs wrapper
library(magrittr)

fn <- "FOSSGIS-workshop/data/ne_10m_airports/ne_10m_airports.shp"
st_layers(fn)

# get airports in Bremen and Hamburg
airports <- st_read(fn) %>% subset(name %in% c("Bremen", "Hamburg"))
dim(airports)
class(airports)

points <- airports$geometry
class(points)

# convert to geojson
geojson_HB <- lawn_point(
  points[[1]], properties = list(name = "Bremen"))

geojson_HH <- lawn_point(
  points[[2]], properties = list(name = "Hamburg"))

# show geojson on leaflet map
lawn::view(list(geojson_HB, geojson_HH))

# do the same in one step ...
geojson <- lapply(points, lawn_point)

lawn::view(geojson)

# use turf to calculate distance
lawn_distance(geojson_HB, geojson_HH)

# use sp to calculate distance
airports_sp <- airports %>% as("Spatial")
spDists(airports_sp)

# use sf to calculate distance
st_distance(airports[1, ], airports[2, ])
