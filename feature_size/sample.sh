#!/bin/bash

if [[ $# != 3 ]]; then
    echo "Usage: sh sample.sh <sampleFile> <sampleRate> <outputFile>"
    exit 0
fi

eval $(awk 'END {print "lineNum="NR}' $1)
echo 'Total' $lineNum 'samples'
sampleNum=`awk 'BEGIN {print int('$lineNum'*'$2')}'`

echo 'Sampling' $sampleNum '...'
awk 'BEGIN {srand()} {print rand() " " $0}' $1 \
    | sort \
    | tail -$sampleNum \
    | sed 's/[^ ]* //' \
    > $3

echo 'Finish Sampling.'