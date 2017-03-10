#!/bin/bash
arch=$1

# --- R packages
#sudo apt-get install -y libudunits2-dev libv8-dev

# --- RStudio
rstudio=rstudio-1.0.136-amd64.deb
if [ "$arch" == "i386" ]; then
	rstudio=rstudio-1.0.136-i386.deb
fi
echo $rstudio
#wget https://download1.rstudio.org/$rstudio
#dpkg -I $rstudio
#sudo apt-get install -y libjpeg62 libedit2 libgstreamer0.10-0 libgstreamer-plugins-base0.10-0 libssl1.0.0
#sudo dpkg -i $rstudio

