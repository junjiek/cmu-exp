#!/bin/bash
if [[ $# != 2 ]]; then
    echo "Usage: ./run_liblinear.sh <trainDataFile> <id>"
    exit 0
fi

echo 'featureSize,sampleSize,ExactAcc,microF,macroF,time' > liblinear_$2.out

num=1
for trainfile in $1_*; do
    featureNum=`echo $trainfile|grep -o "[0-9][0-9]*"| tail -1`
    testfile=${trainfile/'train'/'test'}
    echo "----- (liblinear) dataset: "$2", round: "$num", featureNum: "$featureNum
    res=`./liblinear.sh $trainfile $testfile $2`
    sampleNum=`wc -l $trainfile | awk '{print int($1)}'`
    echo $featureNum,$sampleNum,$res
    echo $featureNum,$sampleNum,$res >> liblinear_$2.out
    num=`echo $num + 1 | bc`
done;

