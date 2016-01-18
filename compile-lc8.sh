#!/bin/bash

cd LC8

for BAND in {4,3,2}; do
  gdalwarp -t_srs EPSG:3857 src/LC81610282015276LGN00_sr_band$BAND.tif $BAND-projected.tif
done

convert -combine {4,3,2}-projected.tif rgb.tif

#convert -depth 8 -modulate 800,150 rgb.tif rgb-corrected.tif
convert -modulate 800,150 rgb.tif rgb-corrected.tif

listgeo -tfw 4-projected.tif

mv 4-projected.tfw rgb-corrected.tfw

gdal_edit.py -a_srs EPSG:3857 rgb-corrected.tif

convert -resize 10% rgb-corrected.tif rgb-corrected-resized.tif

cd ..
