#!/bin/bash
docker run -v $(pwd):/data otbseg otbcli_MeanShiftSmoothing -in /data/lc8.tif -fout /data/lc8_range.tif -foutpos /data/lc8_spat.tif -ranger 30 -spatialr 5 -maxiter 10 -modesearch 0
#docker run -v $(pwd):/data otbseg otbcli_LSMSSegmentation -in /data/lc8_range.tif -inpos /data/lc8_spat.tif -out /data/lc8_seg.tif uint32 -ranger 30 -spatialr 5 -minsize 0 -tilesizex 256 -tilesizey 256
