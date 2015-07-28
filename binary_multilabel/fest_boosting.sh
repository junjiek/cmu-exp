#!/bin/bash
if [[ $# != 3 ]]; then
    echo "Usage: ./fest_boosting.sh <trainDataFile> <testDataFile> <id>"
    exit 0
fi

ROOTDIR=..
DATADIR=$ROOTDIR/datasets/
NEW_DATADIR=$ROOTDIR/new_dataset/
OUTDIR=$ROOTDIR/output/fest/b
FEST_RUN=$ROOTDIR/fest/build/festmulticlass
BINARY=$ROOTDIR/tool/fest_bt/binary_fest.py

# ------- multilabel

res=`(time -p python $BINARY -c 2 -d 5 -t 100 -e $1 $2) 2> "$OUTDIR/$3.time"`
realTime=`grep -o "[0-9]*\.[0-9]*" "$OUTDIR/$3.time" | head -1`
outinfo=`echo $res | grep -o "[0-9]*\.[0-9]*" | tail -3`
outinfo=`echo $outinfo`
outinfo=`echo ${outinfo// /,}`
echo $outinfo,$realTime

rm $OUTDIR/$3.time
rm $OUTDIR/tmp_*