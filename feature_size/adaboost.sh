#!/bin/bash
echo '+ adaboost'

if [[ $# != 4 ]]; then
    echo "Usage: ./adaboost.sh <trainDataFile> <testDataFile> <outputInfoFile> <featureNum>"
    exit 0
fi

ROOTDIR=..
DATADIR=$ROOTDIR/datasets/
OUTDIR=$ROOTDIR/output/adaboost
ADABOOST_TRAIN=$ROOTDIR/adaboost_ori/build/abtrain
ADABOOST_PREDICT=$ROOTDIR/adaboost_ori/build/abpredict
ADABOOST_CV=$ROOTDIR/adaboost_ori/build/abcrossvalidate

(time -p $ADABOOST_TRAIN -t 2 -r 50 $1 $OUTDIR/model3) 2> "$OUTDIR/adaboost3.time"
realTime=`grep -o "[0-9]*\.[0-9]*" "$OUTDIR/adaboost3.time" | head -1`
acc=`$ADABOOST_PREDICT $2 $OUTDIR/model3`
acc=`echo $acc|grep -o "[0-9]*\.[0-9]*"| head -1`
acc=`echo $acc \* 100 | bc`

sampleNum=`wc -l $1 | awk '{print int($1)}'`
echo $4" features, "$sampleNum" samples, testing accuracy = "$acc"%, real time "$realTime"s"
echo $4,$sampleNum,$acc,$realTime >> $3  # append mode

# Clean up
rm "$OUTDIR/adaboost3.time"
rm "$OUTDIR/model3"


# MODEL_FILE=${1/\//_}.model
# if [[ $# == 2 ]]; then
#     $ADABOOST_TRAIN -t 2 -r 100 -v $DATADIR/$1 $OUTDIR/$MODEL_FILE
#     $ADABOOST_PREDICT -v $DATADIR/$2 $OUTDIR/$MODEL_FILE
# fi


