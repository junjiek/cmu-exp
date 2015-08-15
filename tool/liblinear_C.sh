#!/bin/bash
echo '+ liblinear'
if [[ $# != 2 ]]; then
    echo "Usage: ./liblinear.sh <trainDataFile> <modelFile>"
    exit 0
fi

ROOTDIR=..
DATADIR=$ROOTDIR/datasets
NEW_DATADIR=$ROOTDIR/new_dataset
OUTDIR=$ROOTDIR/output/liblinear
LIBLINEAR_TRAIN=$ROOTDIR/liblinear/build/train

# echo "Finding best c ..."
res=`$LIBLINEAR_TRAIN -C -s 2 -q $1`            # the -C option will cross-validate to find the best c
c=`echo $res|grep -o "[0-9]*\.[0-9]*"| head -1`
# c=`echo $c + 0.00001 | bc`
# echo "Best c:" $c
$LIBLINEAR_TRAIN -c $c -s 2 -q $1 $2