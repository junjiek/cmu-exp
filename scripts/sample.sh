#!/bin/sh
eval $(awk 'END {print "LineNum="NR}' $1)
echo 'Total' $LineNum 'lines'
SampleNum=`awk 'BEGIN {print int('$LineNum'*'$3')}'`

echo 'Sampling' $SampleNum 'lines...'
awk 'BEGIN {srand()} {print rand() " " $0}' $1 \
    | sort \
    | tail -$SampleNum \
    | sed 's/[^ ]* //' \
    > $2 \

echo 'Finish!'