#!/bin/bash
if [[ $# != 1 ]]; then
    echo "Usage: ./download.sh <id>"
    exit 0
fi

scp junjiek@bonda.lti.cs.cmu.edu:feature_size/liblinear_$1.out .
scp junjiek@bonda.lti.cs.cmu.edu:feature_size/fest_boosting_$1.out .
scp junjiek@bonda.lti.cs.cmu.edu:feature_size/fest_randomforest_$1.out .
