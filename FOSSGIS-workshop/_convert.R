library(sf)
library(magrittr)

countries <- "FOSSGIS-workshop/data/ne_10m_admin_0_countries.rds" %>%
  readRDS() %>%
  st_as_sf()

fn_out <- "/home/gabbo/tmp/ne_countries.shp"
st_write(countries, fn_out)

world <- st_read(fn_out)
world$POP_EST
