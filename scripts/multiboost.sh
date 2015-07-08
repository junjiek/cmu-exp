#!/bin/sh
ROOTDIR=..
MULTIBOOST=$ROOTDIR/multiboost/build/multiboost 
DATADIR=$ROOTDIR/datasets/
OUTDIR=$ROOTDIR/output/

$MULTIBOOST \
	--fileformat svmlight --verbose 5 \
	--traintest $DATADIR/a9a/svm/a9a.train.svm $DATADIR/a9a/svm/a9a.test.svm  100 \
	--learnertype SingleStumpLearner \
	--outputinfo $OUTDIR/a9a_multi.dta \
	--shypname $OUTDIR/a9a_multi_shyp.xml \

