#!/bin/bash

ROOTDIR=..
DATADIR=$ROOTDIR/datasets/
OUTDIR=$ROOTDIR/output/adaboost
ADABOOST_TRAIN=$ROOTDIR/adaboost/build/abtrain
ADABOOST_PREDICT=$ROOTDIR/adaboost/build/abpredict
ADABOOST_CV=$ROOTDIR/adaboost/build/abcrossvalidate
MODEL_FILE=${1/\//_}.model

cd $ROOTDIR/adaboost/build

make

cd ../../scripts

if [[ $# == 2 ]]; then
    $ADABOOST_TRAIN -t 2 -r 100 -v $DATADIR/$1 $OUTDIR/$MODEL_FILE
    $ADABOOST_PREDICT -v $DATADIR/$2 $OUTDIR/$MODEL_FILE
fi

if [[ $# == 1 ]]; then
    $ADABOOST_CV -t 2 -r 100 $DATADIR/$1
fi

