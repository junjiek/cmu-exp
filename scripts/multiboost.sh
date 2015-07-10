#!/bin/bash

if [[ $# != 2 ]]; then
    echo "Usage: multiboost.sh <trainDataFile> <testDataFile>"
    exit 0
fi

ROOTDIR=..
MULTIBOOST=$ROOTDIR/multiboost/build/multiboost 
DATADIR=$ROOTDIR/datasets/
NEW_DATADIR=$ROOTDIR/new_dataset/
OUTDIR=$ROOTDIR/multiboost/output/
MODEL_FILE=${1/\//_}.xml
INFO_FILE=${1/\//_}.info

(time -p $MULTIBOOST \
	   --fileformat svmlight --verbose 0 \
	   --train $1 50 \
	   --learnertype SingleStumpLearner \
	   --outputinfo $INFO_FILE \
	   --shypname $MODEL_FILE) \
    2> "multiboost.time"
realTime=`grep -o "[0-9]*\.[0-9]*" "multiboost.time" | head -1`
rm "multiboost.time"

acc=`$MULTIBOOST \
        --fileformat svmlight --verbose 0 \
        --test $2 $MODEL_FILE 50 \
        --learnertype SingleStumpLearner \
        --outputinfo $INFO_FILE`

acc=`echo $acc|grep -o "[0-9]*\.[0-9]*"| tail -1`
acc=`echo 100 - $acc | bc`
echo $acc $realTime
rm $MODEL_FILE
rm ${INFO_FILE}*

# $MULTIBOOST \
#     --fileformat svmlight --verbose 5 \
#     --train $DATADIR/a9a 100 \
#     --learnertype SingleStumpLearner \
#     --outputinfo a9a_multi.dta \
#     --shypname a9a_multi_shyp.xml \

# $MULTIBOOST \
#     --fileformat svmlight --verbose 5 \
#     --test $DATADIR/a9a.t a9a_multi_shyp.xml 100 \
#     --learnertype SingleStumpLearner \
#     --outputinfo a9a_multi.dta \
#     --shypname a9a_multi_shyp.xml \
