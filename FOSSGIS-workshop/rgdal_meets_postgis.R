library(rgdal)
library(magrittr)

dsn <- "PG:dbname='natural_earth2' host='localhost' user='user'"
ogrListLayers(dsn)

layers <- ogrListLayers(dsn)
subset(layers, grepl("points", layers))

layer <- layers[5]
print(layer)
pts <- readOGR(dsn, layer)
names(pts)
dim(pts)

fn <- "FOSSGIS-workshop/data/africa.js"
ogrListLayers(fn)
africa <- readOGR(fn, "OGRGeoJSON")
plot(africa)

africa[pts, ] -> whatever
dim(whatever)
names(whatever)
plot(whatever, col = "yellow", add = TRUE)

pts_africa <- pts[africa, ]
plot(pts_africa, add = TRUE, col = "green")
dim(pts_africa)
plot(pts_africa, col = "green", add = TRUE)
