rosgeo-live
================

Add additional R packages handling spatial data and RStudio to [osgeo-live](http://live.osgeo.org/).

Install dependencies
--------------------

``` bash
$ sudo apt-get install libudunits2-dev libv8-dev
```

Install R packages
------------------

``` bash
$ Rscript -e 'install.packages(c("sf", "leaflet", "osrm", "shiny",
   "lawn", "rmarkdown", "rmapshaper", "gdalUtils", "geojsonio"),
   repos="https://cran.rstudio.com")'
```

Install RStudio
---------------

``` bash
$ wget https://download1.rstudio.org/rstudio-1.0.136-amd64.deb
$ sudo dpkg -i rstudio-1.0.136-amd64.deb
$ sudo apt-get install -f
```
