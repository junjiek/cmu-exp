#!/bin/bash

echo '+ liblinear'
if [[ $# != 5 ]]; then
    echo "Usage: ./liblinear.sh <trainDataFile> <testDataFile> <outputInfoFile> <featureNum> <id>"
    exit 0
fi

ROOTDIR=..
DATADIR=$ROOTDIR/datasets
NEW_DATADIR=$ROOTDIR/new_dataset
OUTDIR=$ROOTDIR/output/liblinear
LIBLINEAR_TRAIN=$ROOTDIR/liblinear/build/train
LIBLINEAR_PREDICT=$ROOTDIR/liblinear/build/predict

echo "Finding best c ..."
res=`$LIBLINEAR_TRAIN -C -s 2 -q $1`            # the -C option will cross-validate to find the best c
c=`echo $res|grep -o "[0-9]*\.[0-9]*"| head -1`
echo "Best c:" $c
(time -p $LIBLINEAR_TRAIN -c $c -s 2 -q $1 $OUTDIR/$5.model) 2> "$OUTDIR/$5.time"
realTime=`grep -o "[0-9]*\.[0-9]*" "$OUTDIR/$5.time" | head -1`
acc=`$LIBLINEAR_PREDICT $2 $OUTDIR/$5.model $OUTDIR/$5.prediction`

acc=`echo $acc|grep -o "[0-9]*\.[0-9]*"| head -1`
sampleNum=`wc -l $1 | awk '{print int($1)}'`
echo $4" features, "$sampleNum" samples, testing accuracy = "$acc"%, real time "$realTime"s"
echo $4,$sampleNum,$acc,$realTime >> $3  # append mode

# Clean up
rm "$OUTDIR/$5.time"
rm "$OUTDIR/$5.prediction"
rm "$OUTDIR/$5.model"

# $LIBLINEAR_TRAIN -c 1 -s 2 $NEW_DATADIR/rcv1_train.binary $OUTDIR/rcv1.model
# $LIBLINEAR_PREDICT $NEW_DATADIR/rcv1_test.binary $OUTDIR/rcv1.model $OUTDIR/rcv1.prediction

