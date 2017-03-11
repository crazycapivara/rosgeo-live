library(sp)
library(rmapshaper)
library(magrittr)

fn <- "FOSSGIS-workshop/data/ne_10m_admin_0_countries.rds"
countries <- readRDS(fn)

object.size(countries) %>% format(units = "MB")

system.time({
  countries_simple <- ms_simplify(countries)
})

object.size(countries_simple) %>% format(units = "MB")
plot(countries)
plot(countries_simple, add = TRUE, col = "yellow")

library(mapview)
mapview(countries_simple)
