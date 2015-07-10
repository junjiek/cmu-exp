#!/bin/bash
if [[ $# != 2 ]]; then
    echo "Usage ./run_liblinear.sh <sampleDataFile> <outputInfo>"
    exit 0
fi

echo 'dataSize,cvAcc,time' > $2

for (( i = 1; i <= 1000; i++ )); do
    echo "i = "$i
    rate=`echo $i \* 0.001 | bc`
    sh sample.sh $1 $rate "tmpSample"
    sh liblinear.sh "tmpSample" $2
    rm "tmpSample"
done
