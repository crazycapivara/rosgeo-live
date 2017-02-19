library(sp)
library(magrittr)

countries <- readRDS("FOSSGIS-workshop/data/ne_10m_admin_0_countries.rds")
names(countries)
dim(countries)
countries@proj4string
countries@data %>% head()

# subset countries
africa <- subset(countries, CONTINENT == "Africa")
dim(africa)
plot(africa)
sum(africa$POP_EST)
head(africa@data)

airports <- readRDS("FOSSGIS-workshop/data/ne_10m_airports.rds")
airports[africa, ] -> airports_africa
plot(airports_africa, add = TRUE, col = "green")

library(leaflet)

leaflet(data = africa) %>% addTiles() %>%
  addPolygons(popup = ~ as.character(NAME),
              weight = 2,
              opacity = 1) %>%
  addCircles(data = airports_africa, color = "red") %>%
  addMarkers(data = airports_africa,
             clusterOptions = markerClusterOptions(),
             popup = as.character(airports_africa$name))
  
