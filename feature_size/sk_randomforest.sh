#!/bin/bash
echo '+ scikit-learn random forest'
if [[ $# != 5 ]]; then
    echo "Usage: ./sk_randomforest.sh <trainDataFile> <testDataFile> <outputInfoFile> <featureNum> <id>"
    exit 0
fi

ROOTDIR=..
DATADIR=$ROOTDIR/datasets/
NEW_DATADIR=$ROOTDIR/new_dataset/
OUTDIR=$ROOTDIR/output/sklearn/
SK_RUN=$ROOTDIR/sklearn/randomforest.py


out=`python $SK_RUN $1 $2`

sampleNum=`wc -l $1 | awk '{print int($1)}'`
outinfo=`echo $out | grep -o "[0-9]*\.[0-9]*" | tail -4`
outinfo=`echo $outinfo`
outinfo=`echo ${outinfo// /,}`
echo $4,$sampleNum,$outinfo >> $3  # append mode

echo $4" features, "$sampleNum" samples, "$out