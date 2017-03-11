library(leaflet)
library(mapedit)

what_we_created <- leaflet() %>%
  addTiles() %>%
  edit_map()

leaflet() %>% 
  addTiles() %>%
  addGeoJSON(what_we_created$finished)