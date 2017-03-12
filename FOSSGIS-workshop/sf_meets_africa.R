library(sf)
library(magrittr)

fn <- "FOSSGIS-workshop/data/africa.js"
st_layers(fn)
africa <- st_read(fn)
names(africa)
plot(africa$geometry)
plot(st_geometry(africa))

# get some infos
attributes(africa$geometry)
st_bbox(africa)
st_crs(africa)
st_geometry(africa)
africa_subset <- africa[africa$LABELRANK == 3, ]
plot(africa_subset$geometry, add = TRUE, col = "yellow")
centers <- st_centroid(africa)
plot(centers$geometry, add = TRUE)

africa$geometry[1] %>% st_as_text()

# convert to sp
class(africa)
africa_sp <- as(africa, "Spatial")
class(africa_sp)
