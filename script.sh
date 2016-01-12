#!/bin/bash

EXPECTED_ARGS=1

if [ $# -ne $EXPECTED_ARGS ]
then
	echo "Usage : $0 {7,8}"
	exit -1
fi

if [ $1 -eq 8 ] ; then
    # Identifier for LC8
    id=lc8.tif
    idrs=lc8_rs.tif

    # Contrast value
    c=800

	# Overlaps color bands
	gdalbuildvrt -separate -overwrite image.vrt LC81610282015276LGN00_sr_band4.tif LC81610282015276LGN00_sr_band3.tif LC81610282015276LGN00_sr_band2.tif

elif [ $1 -eq 7 ] ; then
    # Identifier for LC8
    id=le7.tif
    idrs=le7_rs.tif

    # Contrast value
    c=200

    # Overlaps color bands
    gdalbuildvrt -separate -overwrite image.vrt LE71610282002312SGS00_B3.tif LE71610282002312SGS00_B2.tif LE71610282002312SGS00_B1.tif

else
    echo "Usage : $0 {7,8}"
    exit -1
fi

	# Translate VRT to TIFF
	gdal_translate image.vrt _image.tif -co "PHOTOMETRIC=RGB"

	# Re-applying geodata
	listgeo _image.tif

	# Contrast
	convert -modulate $c,150 _image.tif $id

	# Remove all useless files
	rm image.vrt _image.tif

    # Resize image
    convert -resize 10% $id $idrs
