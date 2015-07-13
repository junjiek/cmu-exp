#!/bin/bash
if [[ $# != 3 ]]; then
    echo "Usage: ./run_adaboost.sh <trainDataFile> <testDataFile> <outputInfoFile>"
    exit 0
fi

echo 'dataSize,cvAcc,time' > $3

for (( i = 1; i <= 100; i++ )); do
    echo "i = "$i
    rate=`echo $i \* 0.01 | bc`
    sh sample.sh $1 $rate "tmpSample"
    sh adaboost.sh "tmpSample" $2 $3
    rm "tmpSample"
done
