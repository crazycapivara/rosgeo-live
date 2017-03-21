library(sp)
library(cartography)

route <- readRDS("FOSSGIS-workshop/data/route_bremen-hamburg.rds")

stamenbw <- getTiles(route, type = "stamenbw")
stamenwc <- getTiles(route, type = "stamenwatercolor", crop = TRUE)

class(stamenwc)
# just set extent
#plot(route, col = "red")
tilesLayer(stamenwc)
plot(route, border = NA, col = NA, bg = "#A6CAE0")
tilesLayer(stamenwc, add = TRUE)
plot(route, col = "red", add = TRUE)

leaflet() %>% addTiles() %>%
  addPolylines(data = route)