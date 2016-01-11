#!/bin/bash
gdalbuildvrt -separate -overwrite lc8.vrt LC81610282015276LGN00_sr_band4.tif LC81610282015276LGN00_sr_band3.tif LC81610282015276LGN00_sr_band2.tif
gdal_translate lc8.vrt _lc8.tif -co "PHOTOMETRIC=RGB"
convert -modulate 800,150 _lc8.tif lc8.tif
rm lc8.vrt _lc8.tif
