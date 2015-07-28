#!/bin/bash
if [[ $# != 2 ]]; then
    echo "Usage: ./run_sk_randomforest.sh <trainDataFile> <id>"
    exit 0
fi

echo 'featureSize,sampleSize,testAcc,microF,macroF,time' > sk_randomforest_$2.out

num=1
for trainfile in $1_*; do
    featureNum=`echo $trainfile|grep -o "[0-9][0-9]*"| tail -1`
    testfile=${trainfile/'train'/'test'}
    echo "----- (sklearn randomforest) dataset: "$2", round: "$num", featureNum: "$featureNum
    ./sk_randomforest.sh   $trainfile $testfile sk_randomforest_$2.out  $featureNum $2
    num=`echo $num + 1 | bc`
done;
