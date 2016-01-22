# ImageChallenge

In your workspace you should have :
- README.md
- Directory "LE7"
- SubDirectory "LE7/src" with the basic images LE7
- Directory "LC8"
- SubDirectory "LC8/src" with the basic images LC8
- main.sh
- segm.sh
- compile-{lc8,le7}.sh
- color.sh
- cluster-{lc8,le7}.py
- statistics.py

First, verify that you have created the directories "LE7" and "LC8" in your workspace and the subdirectories "LE7/src" and "LC8/src", and that you have copied all band-images in these directories.


Then, you should follow the next points in the same order:

1. Creating and resizing the recomposed images.
For Landsat 7 :
    ./main.sh -c -s LE7

For Landsat 8 :
    ./main.sh -c -s LC8

2. Classifying the images.
For Landsat 7 :
    pyspark cluster-le7.py

For Landsat 8 :
    pyspark cluster-lc8.py

If you encounter some troubles in this step, please launch your spark environment : ./bin/pyspark
Then, copy the content of each file (cluster-{lc8,le7}.py) in your console, except the part of the SparkContext creation.

3. Coloring the segmented images.
For Landsat 7 :
    ./color.sh LE7

For Landsat 8 :
    ./color.sh LC8

4. Getting the final statistics.
    python statistics.py

The final statistics will be stored in statistics.txt created in your workspace at the end of this step.

