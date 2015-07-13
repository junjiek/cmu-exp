#!/bin/bash
if [[ $# != 2 ]]; then
    echo "Usage: ./run_all.sh <trainDataFile> <testDataFile>"
    exit 0
fi

echo 'dataSize,testAcc,time' > liblinear.out
echo 'dataSize,testAcc,time' > adaboost.out
# echo 'dataSize,testAcc,time' > multiboost.out

for (( i = 1; i <= 100; i++ )); do
    echo "i = "$i
    rate=`echo $i \* 0.01 | bc`
    ./sample.sh $1 $rate "tmpSample"
    ./liblinear.sh  "tmpSample" $2 liblinear.out
    ./adaboost.sh   "tmpSample" $2 adaboost.out
    # ./multiboost.sh "tmpSample" $2 multiboost.out
    rm "tmpSample"
done
