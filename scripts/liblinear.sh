#!/bin/bash

ROOTDIR=..
DATADIR=$ROOTDIR/datasets
NEW_DATADIR=$ROOTDIR/new_dataset
OUTDIR=$ROOTDIR/output/liblinear
LIBLINEAR_TRAIN=$ROOTDIR/liblinear/build/train
LIBLINEAR_PREDICT=$ROOTDIR/liblinear/build/predict

$LIBLINEAR_TRAIN -c 0.25 -s 2 -v 5 $DATADIR/a9a 1.model
# $OUTDIR/a9a.model
# $LIBLINEAR_PREDICT $DATADIR/a9a.t $OUTDIR/a9a.model $OUTDIR/a9a.prediction

# $LIBLINEAR_TRAIN -c 1 -s 2 $NEW_DATADIR/rcv1_train.binary $OUTDIR/rcv1.model
# $LIBLINEAR_PREDICT $NEW_DATADIR/rcv1_test.binary $OUTDIR/rcv1.model $OUTDIR/rcv1.prediction

