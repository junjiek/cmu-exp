#!/bin/bash
if [[ $# != 2 ]]; then
    echo "Usage: ./run_svmlight.sh <trainDataFile> <id>"
    exit 0
fi

echo 'featureSize,sampleSize,ExactAcc,microF,macroF,time' > svmlight_$2.out

num=1
for trainfile in $1_*; do
    featureNum=`echo $trainfile|grep -o "[0-9][0-9]*"| tail -1`
    testfile=${trainfile/'train'/'test'}
    echo "----- (svmlight) dataset: "$2", round: "$num", featureNum: "$featureNum
    res=`./svmlight.sh $trainfile $testfile $2`
    sampleNum=`wc -l $trainfile | awk '{print int($1)}'`
    echo $featureNum,$sampleNum,$res
    echo $featureNum,$sampleNum,$res >> svmlight_$2.out
    num=`echo $num + 1 | bc`
done;

