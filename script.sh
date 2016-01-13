#!/bin/bash

EXPECTED_ARGS=1

if [ $# -ne $EXPECTED_ARGS ]
then
	echo "Usage : $0 {7,8}"
	exit -1
fi

if [ $1 -eq 8 ] ; then
    # Path
    path="LC81610282015276-SC20151211121326/"

    # Identifier for LC8
    id=lc8.tif
    idrs=lc8_rs.tif

    # Contrast value
    c=800

	# Overlaps color band
	gdalbuildvrt -separate -overwrite $path"image".vrt $path"LC81610282015276LGN00_sr_band4".tif $path"LC81610282015276LGN00_sr_band3".tif $path"LC81610282015276LGN00_sr_band2".tif

elif [ $1 -eq 7 ] ; then
    # Path
    path="L7 ETM_ SLC-on _1999-2003_/"

    # Identifier for LC8
    id=le7.tif
    idrs=le7_rs.tif

    # Contrast value
    c=200

    # Overlaps color bands
    gdalbuildvrt -separate -overwrite $path"image".vrt $path"LE71610282002312SGS00_B3".tif $path"LE71610282002312SGS00_B2.tif" $path"LE71610282002312SGS00_B1".tif

else
    echo "Usage : $0 {7,8}"
    exit -1
fi

	# Translate VRT to TIFF
	gdal_translate $path"image".vrt $path"_image".tif -co "PHOTOMETRIC=RGB"

	# Re-applying geodata
	listgeo $path"_image".tif

	# Contrast
	convert -modulate $c,150 $path"_image".tif $path$id

	# Remove all useless files
	rm $path"image".vrt $path"_image".tif

    # Resize image
    convert -resize 10% $path$id $path$idrs
