library(sp)

world <- readRDS("FOSSGIS-workshop/data/ne_10m_admin_0_countries.rds")
names(world)
continents <- split(world, world$CONTINENT)
length(continents)
names(continents)
plot(continents$Asia)

library(leaflet)

leaflet() %>% addTiles() %>%
  addPolygons(data = continents$`South America`,
              popup = as.character(continents$`South America`$NAME),
              weight = 2,
              opacity = 1,
              color = "yellow")
