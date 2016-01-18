#!/bin/bash

cd LE7

for BAND in {3,2,1}; do
  gdalwarp -t_srs EPSG:3857 src/LE71610282002312SGS00_B$BAND.TIF $BAND-projected.tif
done

convert -combine {3,2,1}-projected.tif rgb.tif

#convert -depth 8 -modulate 200,150 rgb.tif rgb-corrected.tif
#convert -modulate 350,250 rgb.tif rgb-corrected.tif
convert -channel RGB -modulate 300,150 -sigmoidal-contrast 4x50% rgb.tif rgb-corrected.tif

#listgeo -tfw 4-projected.tif

#mv 4-projected.tfw rgb-corrected.tfw

#gdal_edit.py -a_srs EPSG:3857 rgb-corrected.tif

convert -resize 10% rgb-corrected.tif rgb-corrected-resized.tif

cd ..
