
if [[ $# != 3 ]]; then
    echo './svm_light_prediction.sh scoreFile predictionFile'
fi


# Calculate prediction accuracy
awk -F:  '{if ($1 > 0) print 1; else print -1}' $1  > $2