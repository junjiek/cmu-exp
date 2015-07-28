#!/bin/bash
if [[ $# != 5 ]]; then
    echo "Usage: ./liblinear.sh <trainDataFile> <testDataFile> <testOriginal> <classFile> <id>"
    exit 0
fi

ROOTDIR=..
DATADIR=$ROOTDIR/datasets/
NEW_DATADIR=$ROOTDIR/new_dataset/
OUTDIR=$ROOTDIR/output/sklearn
SK_RUN=$ROOTDIR/sklearn/randomforest.py
MEASURE=$ROOTDIR/tool/measure.py

realtime=`python $SK_RUN $1 $2 $OUTDIR/$5.prediction 2> warning`
realtime=`echo $realtime | grep -o "[0-9]*\.[0-9]*" | tail -1`
realTime=`echo $realtime`
res=`python $MEASURE $3 $OUTDIR/$5.prediction $4`

outinfo=`echo $res | grep -o "[0-9]*\.[0-9]*" | tail -3`
outinfo=`echo $outinfo`
outinfo=`echo ${outinfo// /,}`
echo $outinfo,$realTime