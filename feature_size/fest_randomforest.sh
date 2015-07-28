#!/bin/bash
echo '+ fest random forest'
if [[ $# != 5 ]]; then
    echo "Usage: ./liblinear.sh <trainDataFile> <testDataFile> <outputInfoFile> <featureNum> <id>"
    exit 0
fi

ROOTDIR=..
DATADIR=$ROOTDIR/datasets/
NEW_DATADIR=$ROOTDIR/new_dataset/
OUTDIR=$ROOTDIR/output/fest
FEST_RUN=$ROOTDIR/fest/build/festmulticlass
HEADER_FILE=$NEW_DATADIR$5.h

out=`$FEST_RUN -c 3 -d 1000 -t 100 $1 $HEADER_FILE $2`

sampleNum=`wc -l $1 | awk '{print int($1)}'`
outinfo=`echo $out | grep -o "[0-9]*\.[0-9]*" | tail -4`
outinfo=`echo $outinfo`
outinfo=`echo ${outinfo// /,}`
echo $4,$sampleNum,$outinfo >> $3  # append mode

echo $4" features, "$sampleNum" samples, "$out

# ROOTDIR=..
# DATADIR=$ROOTDIR/datasets/
# OUTDIR=$ROOTDIR/output/fest
# FEST_TRAIN=$ROOTDIR/fest/build/festlearn
# FEST_PREDICT=$ROOTDIR/fest/build/festclassify

# (time -p $FEST_TRAIN -c 3 -t 100 $1 $OUTDIR/rf$5.model) 2> "$OUTDIR/rf$5.time"
# $FEST_PREDICT $2 $OUTDIR/rf$5.model $OUTDIR/rf$5.prediction
# realTime=`grep -o "[0-9]*\.[0-9]*" "$OUTDIR/rf$5.time" | head -1`

# # Calculate prediction accuracy
# acc=`awk ' NR == FNR { a[NR] = $1 > 0.5; sampleNum = sampleNum + 1; } \
#            NR != FNR { if (a[FNR] == ($1 > 0)) correct = correct + 1; } \
#            END {print correct / sampleNum * 100}' $OUTDIR/rf$5.prediction $2`

# sampleNum=`wc -l $1 | awk '{print int($1)}'`
# echo $4" features, "$sampleNum "samples, testing accuracy = "$acc"%, real time "$realTime"s"
# echo $4,$sampleNum,$acc,$realTime >> $3  # append mode

# # Clean up
# rm "$OUTDIR/rf$5.time"
# rm "$OUTDIR/rf$5.model"
# rm "$OUTDIR/rf$5.prediction"


