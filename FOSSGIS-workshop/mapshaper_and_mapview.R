library(sp)
library(sf)
library(rmapshaper)
library(leaflet)
library(mapview)

fn <- "FOSSGIS-workshop/data/africa.js"
africa <- st_read(fn) %>% as("Spatial")

africa_dissolved <- ms_dissolve(africa, "LABELRANK", sum_fields = "POP_EST")
plot(africa_dissolved)

# dissolve polygons
africa_dissolved@data
africa[africa$LABELRANK == 3, ]$POP_EST %>% sum()
africa_dissolved$POP_EST[africa_dissolved$LABELRANK == 3]

# simplify polygons
africa_simple <- ms_simplify(africa)

plot(africa)
plot(africa_simple, add = TRUE, col = "yellow")

leaflet() %>% addTiles() %>%
  addPolygons(data = africa, weight = 2, group = "basic") %>%
  addPolygons(data = africa_simple, weight = 2, group = "simple", color = "red") %>%
  addLayersControl(overlayGroups = c("basic", "simple"))

# check chnage of size
object.size(africa) %>% format(units = "MB")
object.size(africa_simple) %>% format(units = "MB")

# mapview
mapview(africa_dissolved)
mapview(africa_dissolved, zcol = "LABELRANK", at = 2:7, burst = TRUE, legend = TRUE)
mapview(breweries91, zcol = "founded", at = seq(1400, 2200, 200),  legend = TRUE)
