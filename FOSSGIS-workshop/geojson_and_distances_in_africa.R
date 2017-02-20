library(rgdal)
library(sp)
library(magrittr)

filename <- "FOSSGIS-workshop/data/africa.js"

# read geojson
ogrListLayers(filename)
africa <- readOGR(filename)

# show some information
africa@data %>% head()
dim(africa)

# get centers
centers <- coordinates(africa)

# plot it
plot(africa)
plot(africa[6, ], add = TRUE, col = "yellow")
points(centers, col = "red")

# get distances
dist <- spDists(centers)[6, ]
nearby <- africa[dist < 10 & dist > 0, ]
plot(nearby, add = TRUE, col = "red")
dim(nearby)

