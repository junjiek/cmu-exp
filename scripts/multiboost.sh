#!/bin/bash
echo '+ multiboost'

if [[ $# != 3 ]]; then
    echo "Usage: ./multiboost.sh <trainDataFile> <testDataFile> <outputInfoFile>"
    exit 0
fi

ROOTDIR=..
MULTIBOOST=$ROOTDIR/multiboost/build/multiboost 
DATADIR=$ROOTDIR/datasets/
NEW_DATADIR=$ROOTDIR/new_dataset/
OUTDIR=$ROOTDIR/output/multiboost
MODEL_FILE=$OUTDIR/model.xml
INFO_FILE=$OUTDIR/info

(time -p $MULTIBOOST \
       --stronglearner AdaBoostMH \
	   --fileformat svmlight --verbose 0 \
	   --train $1 50 \
	   --learnertype SingleSparseStumpLearner \
	   --outputinfo $INFO_FILE \
	   --shypname $MODEL_FILE) \
    2> "$OUTDIR/multiboost.time"
realTime=`grep -o "[0-9]*\.[0-9]*" "$OUTDIR/multiboost.time" | head -1`

acc=`$MULTIBOOST \
        --stronglearner AdaBoostMH \
        --fileformat svmlight --verbose 0 \
        --test $2 $MODEL_FILE 50 \
        --learnertype SingleSparseStumpLearner \
        --outputinfo $INFO_FILE`
acc=`echo $acc|grep -o "[0-9]*\.[0-9]*"| tail -1`
acc=`echo 100 - $acc | bc`

sampleNum=`wc -l $1 | awk '{print int($1)}'`
echo $sampleNum "samples, testing accuracy = "$acc"%, real time "$realTime"s"
echo $sampleNum,$acc,$realTime >> $3  # append mode

rm "$OUTDIR/multiboost.time"
rm $MODEL_FILE
rm ${INFO_FILE}*

# $MULTIBOOST \
#     --fileformat svmlight --verbose 5 \
#     --train $DATADIR/a9a 100 \
#     --learnertype SingleSparseStumpLearner \
#     --outputinfo a9a_multi.dta \
#     --shypname a9a_multi_shyp.xml \

# $MULTIBOOST \
#     --fileformat svmlight --verbose 5 \
#     --test $DATADIR/a9a.t a9a_multi_shyp.xml 100 \
#     --learnertype SingleSparseStumpLearner \
#     --outputinfo a9a_multi.dta \
#     --shypname a9a_multi_shyp.xml \
