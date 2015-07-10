#!/bin/bash
if [[ $# != 2 ]]; then
    echo "Usage ./run_multiboost.sh <trainDataFile> <outputInfo>"
    exit 0
fi

echo 'dataSize,cvAcc,time' > $2

for (( i = 1; i <= 100; i++ )); do
    echo "i = "$i
    rate=`echo $i \* 0.01 | bc`
    sh sample.sh $1 $rate "tmpSample3"
    sh multiboost_cv.sh "tmpSample3" $2
    rm "tmpSample3"
done
