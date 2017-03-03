#!/bin/bash

while read var; do
    # get the data for this variable for all the models
    bash pull_data.sh $var "mon" pca_mods.txt
    # now pull the data into R, compress it, and store it
    Rscript compress.R "$var"
    # finally delete all the data for this variable,
    # no need for it to be taking up space...
    rm -rf cmip5-ng
done < pca_variables.txt

# melt and concatenate all the compressed data:
Rscript merge_data.R

# run the mds and save an image
Rscript doMDS.R

# remove "compressed" files
# rm *_compressed.csv
