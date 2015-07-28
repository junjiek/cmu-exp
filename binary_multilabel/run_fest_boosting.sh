#!/bin/bash
if [[ $# != 2 ]]; then
    echo "Usage: ./run_fest_boosting.sh <trainDataFile> <id>"
    exit 0
fi

echo 'featureSize,sampleSize,ExactAcc,microF,macroF,time' > fest_boosting$2.out

num=1
for trainfile in $1_*; do
    featureNum=`echo $trainfile|grep -o "[0-9][0-9]*"| tail -1`
    testfile=${trainfile/'train'/'test'}
    echo "----- (fest_boosting) dataset: "$2", round: "$num", featureNum: "$featureNum
    res=`./fest_boosting.sh $trainfile $testfile $2`
    sampleNum=`wc -l $trainfile | awk '{print int($1)}'`
    echo $featureNum,$sampleNum,$res
    echo $featureNum,$sampleNum,$res >> fest_boosting$2.out
    num=`echo $num + 1 | bc`
done;
