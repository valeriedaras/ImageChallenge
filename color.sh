#!/bin/bash

cd $1

docker run -v $(pwd):/data otbseg otbcli_ColorMapping -in /data/filtered-seg-corrected.tif -method custom -method.custom.lut /data/custom.txt -out /data/clustered.tif 

cd ..
