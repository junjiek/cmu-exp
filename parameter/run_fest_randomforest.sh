#!/bin/bash
if [[ $# != 2 ]]; then
    echo "Usage: ./run_fest_randomforest.sh <trainDataFile> <id>"
    exit 0
fi

ROOTDIR=..
DATADIR=$ROOTDIR/datasets/
NEW_DATADIR=$ROOTDIR/new_dataset/
OUTDIR=$ROOTDIR/output/fest/rf
FEST_RUN=$ROOTDIR/fest/build/festmulticlass
BINARY=$ROOTDIR/tool/fest_rf/binary_fest.py

round=16
for (( i = 4; i <= 10; i++ )); do
    echo 'featureSize,sampleSize,ExactAcc,microF,macroF,time' > fest_rf_$2_$round.out
    
    num=1
    for trainfile in $1_*; do
        featureNum=`echo $trainfile|grep -o "[0-9][0-9]*"| tail -1`
        testfile=${trainfile/'train'/'test'}
        echo "----- (fest_randomforest) dataset: "$2_$round", round: "$num", featureNum: "$featureNum

        res=`(time -p python $BINARY -c 3 -d 1000 -t $round -e $trainfile $testfile $2_$round) 2> "$OUTDIR/$2_$round.time"`
        realTime=`grep -o "[0-9]*\.[0-9]*" "$OUTDIR/$2_$round.time" | head -1`
        outinfo=`echo $res | grep -o "[0-9]*\.[0-9]*" | tail -3`
        outinfo=`echo $outinfo`
        outinfo=`echo ${outinfo// /,}`

        rm $OUTDIR/$2_$round*

        sampleNum=`wc -l $trainfile | awk '{print int($1)}'`
        echo $featureNum,$sampleNum,$outinfo,$realTime
        echo $featureNum,$sampleNum,$outinfo,$realTime >> fest_rf_$2_$round.out
        num=`echo $num + 1 | bc`
    done;

    round=`echo $round + $round | bc`
done



