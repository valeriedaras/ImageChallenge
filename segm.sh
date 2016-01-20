#!/bin/bash

cd $1 

docker run -v $(pwd):/data otbseg otbcli_MeanShiftSmoothing -in /data/rgb-corrected-resized.tif -fout /data/filtered-range.tif -foutpos /data/filtered-spat.tif -ranger 8 -spatialr 5 -maxiter 10 -modesearch 0 

docker run -v $(pwd):/data otbseg otbcli_LSMSSegmentation -in /data/filtered-range.tif -inpos /data/filtered-spat.tif -out /data/filtered-seg.tif uint32 -ranger 8 -spatialr 5 -minsize 0 -tilesizex 256 -tilesizey 256

docker run -v $(pwd):/data otbseg otbcli_LSMSSmallRegionsMerging -in /data/filtered-range.tif -inseg /data/filtered-seg.tif -out /data/filtered-seg-corrected.tif uint32 -minsize 1000 -tilesizex 256 -tilesizey 256

docker run -v $(pwd):/data otbseg otbcli_LSMSVectorization -in /data/rgb-corrected-resized.tif -inseg /data/filtered-seg-corrected.tif -out /data/filtered-segmented.shp -tilesizex 256 -tilesizey 256

docker run -v $(pwd):/data otbseg otbcli_ColorMapping -in /data/filtered-seg-corrected.tif -method image -method.image.in /data/rgb-corrected-resized.tif -out /data/filtered-segmented.tif 

rm filtered-range.tif filtered-spat.tif filtered-seg.tif filtered-seg-corrected.tif filtered-segmented.dbf filtered-segmented.prj filtered-segmented.shx

ogr2ogr -f CSV /data/filtered-segmented.csv /data/filtered-segmented.shp -lco GEOMETRY=AS_XYZ

cd .. 
