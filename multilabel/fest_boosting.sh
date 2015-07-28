#!/bin/bash
if [[ $# != 5 ]]; then
    echo "Usage: ./liblinear.sh <trainDataFile> <testDataFile> <testOriginal> <classFile> <id>"
    exit 0
fi

ROOTDIR=..
DATADIR=$ROOTDIR/datasets/
NEW_DATADIR=$ROOTDIR/new_dataset/
OUTDIR=$ROOTDIR/output/fest
FEST_RUN=$ROOTDIR/fest/build/festmulticlass
HEADER_FILE=$NEW_DATADIR$5.h
MEASURE=$ROOTDIR/tool/measure.py

# ------- multilabel

realtime=`$FEST_RUN -c 2 -d 5 -t 100 $1 $HEADER_FILE $2 $OUTDIR/b_$5.prediction`
realtime=`echo $realtime | grep -o "[0-9]*\.[0-9]*" | tail -1`
realTime=`echo $realtime`
res=`python $MEASURE $3 $OUTDIR/b_$5.prediction $4`

outinfo=`echo $res | grep -o "[0-9]*\.[0-9]*" | tail -3`
outinfo=`echo $outinfo`
outinfo=`echo ${outinfo// /,}`
echo $outinfo,$realTime