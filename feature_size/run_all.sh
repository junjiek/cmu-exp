#!/bin/bash
if [[ $# != 2 ]]; then
    echo "Usage: ./run_all.sh <trainDataFile> <id>"
    exit 0
fi

echo 'featureSize,sampleSize,testAcc,microF,macroF,time' > liblinear_$2.out
echo 'featureSize,sampleSize,testAcc,microF,macroF,time' > fest_randomforest_$2.out
echo 'featureSize,sampleSize,testAcc,microF,macroF,time' > fest_boosting_$2.out
# echo 'featureSize,sampleSize,testAcc,microF,macroF,time' > multiboost_$2.out

num=1
for trainfile in $1_*; do
    featureNum=`echo $trainfile|grep -o "[0-9][0-9]*"| tail -1`
    testfile=${trainfile/'train'/'test'}
    echo "----- dataset: "$2", round: "$num", featureNum: "$featureNum
    ./liblinear.sh         $trainfile $testfile liblinear_$2.out         $featureNum $2
    ./fest_randomforest.sh $trainfile $testfile fest_randomforest_$2.out $featureNum $2
    ./fest_boosting.sh     $trainfile $testfile fest_boosting_$2.out     $featureNum $2
    # ./multiboost.sh        $trainfile $testfile multiboost_$2.out        $featureNum $2
    num=`echo $num + 1 | bc`
done;


# for ((i = 472; i <= 47200; i += 472)); do
#     featureNum=`echo $i|grep -o "[0-9][0-9]*"| tail -1`
#     echo "----- "$i
#     ./liblinear.sh         $1_$i $2_$i liblinear.out         $featureNum
#     ./fest_boosting.sh     $1_$i $2_$i fest_boosting.out     $featureNum
#     ./fest_randomforest.sh $1_$i $2_$i fest_randomforest.out $featureNum
# done;
