#!/bin/bash

if [[ $# != 2 ]]; then
    echo "Usage: ./liblinear.sh <trainDataFile> <outputFile>"
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
acc=`(time -p $LIBLINEAR_TRAIN -c $c -s 2 -v 5 -q $1) 2> "liblinear.time"`
realTime=`grep -o "[0-9]*\.[0-9]*" "liblinear.time" | head -1`
rm "liblinear.time"
acc=`echo $acc|grep -o "[0-9]*\.[0-9]*"| head -1`
eval $(awk 'END {print "sampleNum="NR}' $1)
echo $sampleNum "samples, cv acc = "$acc"%, real time "$realTime"s"
echo $sampleNum,$acc,$realTime >> $2  # append mode

# $LIBLINEAR_TRAIN -c 1 -s 2 $NEW_DATADIR/rcv1_train.binary $OUTDIR/rcv1.model
# $LIBLINEAR_PREDICT $NEW_DATADIR/rcv1_test.binary $OUTDIR/rcv1.model $OUTDIR/rcv1.prediction

