rosgeo-live
================

Add additional R packages handling spatial data and RStudio to [osgeo-live](http://live.osgeo.org/).

Fast lane
---------

``` bash
$ git clone https://github.com/crazycapivara/rosgeo-live.git
$ cd rosgeo-live
$ ./rosgeo-live_install.sh

# 32-bit
$ ./rosgeo-live_install.sh i386
```

One by one
----------

### Install dependencies

``` bash
# R packages
$ sudo apt-get install libudunits2-dev libv8-dev

# RStudio
sudo apt-get install -y libjpeg62 libedit2 libgstreamer0.10-0\
 libgstreamer-plugins-base0.10-0 libssl1.0.0
```

### Install R packages

``` bash
$ Rscript -e 'install.packages(c("sf", "leaflet", "osrm", "shiny",
   "lawn", "rmarkdown", "rmapshaper", "gdalUtils", "geojsonio"),
   repos="https://cran.rstudio.com")'
```

### Install RStudio

``` bash
# set version and architecture
# 64-bit
$ rstudio=rstudio-1.0.136-amd64.deb
# 32-bit
$ rstudio=rstudio-1.0.136-i386.deb

$ wget https://download1.rstudio.org/$rstudio
$ sudo dpkg -i $rstudio

# in case of missing dependencies run ...
$ sudo apt-get install -f
```
