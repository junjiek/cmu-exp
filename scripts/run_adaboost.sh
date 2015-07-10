#!/bin/bash
if [[ $# != 2 ]]; then
    echo "Usage ./run.sh <sampleDataFile> <outputInfo>"
    exit 0
fi

echo 'dataSize,cvAcc,time' > $2

for (( i = 1; i <= 100; i++ )); do
    echo "i = "$i
    rate=`echo $i \* 0.01 | bc`
    sh sample.sh $1 $rate "tmpSample2"
    sh adaboost.sh "tmpSample2" $2
    rm "tmpSample2"
done
