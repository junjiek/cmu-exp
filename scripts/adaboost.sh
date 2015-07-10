#!/bin/bash

if [[ $# != 2 ]]; then
    echo "Usage: adaboost.sh <trainDataFile> <outputFile>"
    exit 0
fi

ROOTDIR=..
DATADIR=$ROOTDIR/datasets/
OUTDIR=$ROOTDIR/output/adaboost
ADABOOST_TRAIN=$ROOTDIR/adaboost/build/abtrain
ADABOOST_PREDICT=$ROOTDIR/adaboost/build/abpredict
ADABOOST_CV=$ROOTDIR/adaboost/build/abcrossvalidate

acc=`(time -p $ADABOOST_CV -t 2 -r 100 -k 5 $1) 2> "adaboost.time"`
realTime=`grep -o "[0-9]*\.[0-9]*" "adaboost.time" | head -1`
rm "adaboost.time"
acc=`echo $acc|grep -o "[0-9]*\.[0-9]*"| head -1`
acc=`echo $acc \* 100 | bc`
eval $(awk 'END {print "sampleNum="NR}' $1)
echo $sampleNum "samples, cv acc = "$acc"%, real time "$realTime"s"
echo $sampleNum,$acc,$realTime >> $2  # append mode

# MODEL_FILE=${1/\//_}.model
# if [[ $# == 2 ]]; then
#     $ADABOOST_TRAIN -t 2 -r 100 -v $DATADIR/$1 $OUTDIR/$MODEL_FILE
#     $ADABOOST_PREDICT -v $DATADIR/$2 $OUTDIR/$MODEL_FILE
# fi


