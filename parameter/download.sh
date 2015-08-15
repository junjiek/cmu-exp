#!/bin/bash
if [[ $# != 1 ]]; then
    echo "Usage: ./download.sh <id>"
    exit 0
fi

mkdir $1
scp junjiek@bonda.lti.cs.cmu.edu:binary_multilabel/liblinear_$1.out         $1
scp junjiek@bonda.lti.cs.cmu.edu:binary_multilabel/fest_boosting_$1.out     $1
scp junjiek@bonda.lti.cs.cmu.edu:binary_multilabel/fest_randomforest_$1.out $1
scp junjiek@bonda.lti.cs.cmu.edu:binary_multilabel/multiboost_$1.out        $1
scp junjiek@bonda.lti.cs.cmu.edu:binary_multilabel/sk_randomforest_$1.out        $1
