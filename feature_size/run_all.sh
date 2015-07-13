#!/bin/bash
if [[ $# != 2 ]]; then
    echo "Usage: ./run_all.sh <trainDataFile> <testDataFile>"
    exit 0
fi

echo 'featureSize,sampleSize,testAcc,time' > liblinear.out
echo 'featureSize,sampleSize,testAcc,time' > adaboost.out
echo 'featureSize,sampleSize,testAcc,time' > multiboost.out

for ((i = 472; i <= 47200; i += 472))); do
    featureNum=`echo $i|grep -o "[0-9][0-9]*"| tail -1`
    echo "----- "$i
    ./liblinear.sh  $1_$i $2_$i liblinear.out  $featureNum
    ./adaboost.sh   $1_$i $2_$i adaboost.out   $featureNum
    ./multiboost.sh $1_$i $2_$i multiboost.out $featureNum
done;


# for i in $1_*; do
#     featureNum=`echo $i|grep -o "[0-9][0-9]*"| tail -1`
#     echo "----- "$i
#     ./liblinear.sh  $i $2 liblinear.out  $featureNum
#     ./adaboost.sh   $i $2 adaboost.out   $featureNum
#     ./multiboost.sh $i $2 multiboost.out $featureNum
# done;

