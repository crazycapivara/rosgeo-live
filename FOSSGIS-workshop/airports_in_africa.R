library(sp)
library(magrittr)

# read countries
countries <- readRDS("FOSSGIS-workshop/data/ne_10m_admin_0_countries.rds")

# show some information
names(countries)
dim(countries)
countries@proj4string
countries@data %>% head()

# subset countries
africa <- subset(countries, CONTINENT == "Africa")

# show some information
dim(africa)
plot(africa)
sum(africa$POP_EST)
head(africa@data)

# read airports
airports <- readRDS("FOSSGIS-workshop/data/ne_10m_airports.rds")

# get all airports in africa
airports[africa, ] -> airports_africa
plot(airports_africa, add = TRUE, col = "green")

library(leaflet)

# put africa and its airports to leaflet map
leaflet(data = africa) %>% addTiles() %>%
  addPolygons(popup = ~ as.character(NAME),
              weight = 2,
              opacity = 1) %>%
  addCircles(data = airports_africa, color = "red") %>%
  addMarkers(data = airports_africa,
             clusterOptions = markerClusterOptions(),
             popup = as.character(airports_africa$name))

## ------------------------------------------
# some statistics
table(airports$type, airports$location)
table(airports$type, airports$scalerank)

levels(airports$type)
table(airports$type)[c("mid", "major", "small")]
table(airports$type)[c("mid", "military major", "major")] %>%
  prop.table() #%>% pie()

plot(airports$type, col = rainbow(20))
pie(table(airports_africa$type)[c("mid", "military major", "major")])
pie(table(airports$type)[c("mid", "military major", "major")])
