#!/bin/bash
if [[ $# != 3 ]]; then
    echo "Usage: ./run_liblinear.sh <trainDataFile> <testDataFile> <outputInfoFile>"
    exit 0
fi

echo 'dataSize,testAcc,time' > $3

for (( i = 1; i <= 1000; i++ )); do
    echo "i = "$i
    rate=`echo $i \* 0.001 | bc`
    sh sample.sh $1 $rate "tmpSample"
    sh liblinear.sh "tmpSample" $2 $3
    rm "tmpSample"
done
