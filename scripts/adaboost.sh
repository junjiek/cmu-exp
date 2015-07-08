#!/bin/bash

ROOTDIR=..
DATADIR=$ROOTDIR/datasets/
OUTDIR=$ROOTDIR/output/adaboost
ADABOOST_TRAIN=$ROOTDIR/adaboost/build/abtrain
ADABOOST_PREDICT=$ROOTDIR/adaboost/build/abpredict

$ADABOOST_TRAIN -t 2 -r 100 -v $DATADIR/a9a/svm/a9a.train.svm $OUTDIR/a9a.model

$ADABOOST_PREDICT -o $OUTDIR/a9a.score -v $DATADIR/a9a/svm/a9a.test.svm $OUTDIR/a9a.model


