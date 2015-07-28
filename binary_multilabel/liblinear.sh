#!/bin/bash
if [[ $# != 3 ]]; then
    echo "Usage: ./liblinear.sh <trainDataFile> <testDataFile> <id>"
    exit 0
fi

ROOTDIR=..
DATADIR=$ROOTDIR/datasets
NEW_DATADIR=$ROOTDIR/new_dataset
OUTDIR=$ROOTDIR/output/liblinear
LIBLINEAR_TRAIN=$ROOTDIR/liblinear/build/train
LIBLINEAR_PREDICT=$ROOTDIR/liblinear/build/predict
LIBLINEAR_FSCORE=$ROOTDIR/liblinear/build/liblinearFScore
BINARY=$ROOTDIR/tool/liblinear/binary.py

res=`(time -p python $BINARY -c 1 -s 2 -q $1 $2) 2> "$OUTDIR/$3.time"`
realTime=`grep -o "[0-9]*\.[0-9]*" "$OUTDIR/$3.time" | head -1`
outinfo=`echo $res | grep -o "[0-9]*\.[0-9]*" | tail -3`
outinfo=`echo $outinfo`
outinfo=`echo ${outinfo// /,}`
echo $outinfo,$realTime

rm $OUTDIR/$3.time
rm $OUTDIR/tmp_*