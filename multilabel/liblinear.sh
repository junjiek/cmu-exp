#!/bin/bash
if [[ $# != 5 ]]; then
    echo "Usage: ./liblinear.sh <trainDataFile> <testDataFile> <testOriginal> <classFile> <id>"
    exit 0
fi

ROOTDIR=..
DATADIR=$ROOTDIR/datasets
NEW_DATADIR=$ROOTDIR/new_dataset
OUTDIR=$ROOTDIR/output/liblinear
LIBLINEAR_TRAIN=$ROOTDIR/liblinear/build/train
LIBLINEAR_PREDICT=$ROOTDIR/liblinear/build/predict
LIBLINEAR_FSCORE=$ROOTDIR/liblinear/build/liblinearFScore
MEASURE=$ROOTDIR/tool/measure.py

(time -p $LIBLINEAR_TRAIN -c 1 -s 2 -q $1 $OUTDIR/$5.model) 2> "$OUTDIR/$5.time"
realTime=`grep -o "[0-9]*\.[0-9]*" "$OUTDIR/$5.time" | head -1`
acc=`$LIBLINEAR_PREDICT $2 $OUTDIR/$5.model $OUTDIR/$5.prediction`
res=`python $MEASURE $3 $OUTDIR/$5.prediction $4`

outinfo=`echo $res | grep -o "[0-9]*\.[0-9]*" | tail -3`
outinfo=`echo $outinfo`
outinfo=`echo ${outinfo// /,}`
echo $outinfo,$realTime



