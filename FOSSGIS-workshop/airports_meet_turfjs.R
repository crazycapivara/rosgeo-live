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
sp::spDists(airports_sp)

# use sf to calculate distance
st_distance(airports[1, ], airports[2, ])

# more lawn examples
HB_buffer <- lawn_buffer(geojson_HB, 50)
HB_buffer$type
HB_buffer$geometry
HB_buffer$properties
class(HB_buffer) <- "polygon"
lawn::view(list(geojson_HB, HB_buffer))
a <- lawn::view(HB_buffer)

b <- st_buffer(airports[1, ], 0.5)
a %>% leaflet::addPolygons(data = b, color = "red")

# distance to destination
bearing <- 45
dest <- lawn::lawn_destination(geojson_HB, 100, bearing, "kilometers")
lawn::view(list(geojson_HB, dest))

# circle around point
circle_HB <- lawn_circle(airports_sp@coords[1, ], 5, steps = 20)
view(list(circle_HB, geojson_HB))

# read geojson to feature collection
js_africa <- readr::read_file("FOSSGIS-workshop/data/africa.js") %>%
  lawn_featurecollection()

lawn_area(js_africa)
lawn_bbox(js_africa)
lawn_center(js_africa) %>% view()
lawn_centroid(js_africa) %>% view()

africa <- sf::st_read("FOSSGIS-workshop/data/africa.js")
sf::st_area(africa) %>% sum()
sf::st_bbox(africa)
