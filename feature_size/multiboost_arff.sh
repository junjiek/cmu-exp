#!/bin/bash
echo '+ multiboost'

if [[ $# != 5 ]]; then
    echo "Usage: ./multiboost.sh <trainDataFile> <testDataFile> <outputInfoFile> <featureNum> <id>"
    exit 0
fi

ROOTDIR=..
MULTIBOOST=$ROOTDIR/multiboost/build/multiboost 
DATADIR=$ROOTDIR/datasets/
NEW_DATADIR=$ROOTDIR/new_dataset/
OUTDIR=$ROOTDIR/output/multiboost
MODEL_FILE=$OUTDIR/$5.xml
INFO_FILE=$OUTDIR/$5
TIME_FILE=$OUTDIR/$5.time

(time -p $MULTIBOOST \
      --stronglearner AdaBoostMH \
	    --fileformat arff --verbose 0 \
	    --train $1 100 \
	    --learnertype SingleStumpLearner \
	    --outputinfo $INFO_FILE \
      --constant \
	    --shypname $MODEL_FILE \
      --weightpolicy proportional ) \
    2> $TIME_FILE
realTime=`grep -o "[0-9]*\.[0-9]*" $TIME_FILE | head -1`

acc=`$MULTIBOOST \
      --stronglearner AdaBoostMH \
      --fileformat arff --verbose 0 \
      --test $2 $MODEL_FILE 100 \
      --learnertype SingleStumpLearner \
      --outputinfo $INFO_FILE fsc`
acc=`echo $acc|grep -o "[0-9]*\.[0-9]*"| tail -1`
acc=`echo 100 - $acc | bc`

F=`grep "[0-9]*\.[0-9]*" $INFO_FILE | tail -2`
microF=`echo $F | grep -o "[0-9]*\.[0-9]*" | head -1`
macroF=`echo $F | grep -o "[0-9]*\.[0-9]*" | tail -1`


sampleNum=`wc -l $1 | awk '{print int($1)}'`
echo $4" features, "$sampleNum" samples, acc = "$acc"%, microF = "$microF", macroF = "$macroF", time "$realTime"s"
echo $4,$sampleNum,$acc,$microF,$macroF,$realTime >> $3  # append mode

rm $TIME_FILE
rm $MODEL_FILE
rm ${INFO_FILE}*

