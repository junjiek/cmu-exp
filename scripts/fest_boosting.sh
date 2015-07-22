#!/bin/bash
echo '+ fest'

if [[ $# != 3 ]]; then
    echo "Usage: ./fest.sh <trainDataFile> <testDataFile> <outputInfoFile>"
    exit 0
fi

ROOTDIR=..
DATADIR=$ROOTDIR/datasets/
OUTDIR=$ROOTDIR/output/fest
FEST_TRAIN=$ROOTDIR/fest/build/festlearn
FEST_PREDICT=$ROOTDIR/fest/build/festclassify

(time -p $FEST_TRAIN -c 2 -d 5 -t 100 $1 $OUTDIR/model) 2> "$OUTDIR/fest.time"
$FEST_PREDICT $2 $OUTDIR/model $OUTDIR/predictions
realTime=`grep -o "[0-9]*\.[0-9]*" "$OUTDIR/fest.time" | head -1`

# Calculate prediction accuracy
acc=`awk ' NR == FNR { a[NR] = $1 > 0; sampleNum = sampleNum + 1; } \
           NR != FNR { if (a[FNR] == ($1 > 0)) correct = correct + 1; } \
           END {print correct / sampleNum * 100}' $OUTDIR/predictions $2`

sampleNum=`wc -l $1 | awk '{print int($1)}'`
echo $sampleNum "samples, testing accuracy = "$acc"%, real time "$realTime"s"
echo $sampleNum,$acc,$realTime >> $3  # append mode

# Clean up
rm "$OUTDIR/fest.time"
rm "$OUTDIR/model"
rm "$OUTDIR/predictions"


