# This little snippet can randomize a file.
# from http://www.commandlinefu.com/commands/view/2320/randomize-lines-in-a-file
# awk 'BEGIN{srand()}{print rand(),$0}' SOMEFILE | sort -n | cut -d ' ' -f2-

if [[ $# != 2 ]]; then
  echo "Usage: ./multiboost_cv.sh <trainDataFile> <outputInfo>"
  exit 0
fi

PREFIX=iris
sampleNum=`wc -l $1 | awk '{print int($1)}'`
LINES=`expr $sampleNum / 5`
MODEL_FILE=${1/\//_}.model

# Clean up
# rm train.a*
# rm test.a*

# Create the train and test data
split -l $LINES $1 del.train.
for i in del.train.*; do
  l=`wc -l $i | awk '{print $1}'`
  if [[ $l != $LINES ]]; then
    continue
  fi
  cat `(ls del.train.* | grep -v $i)` > ${i//del./}.dat;
  cp $i ${i//del.train/test}.dat;
done;
rm del.train.*

num=0
accAll=0.0
timeAll=0.0
for i in train.*.dat; do
  num=`echo $num + 1 | bc`
  echo '-- cv round '$num
  res=`sh multiboost.sh $i ${i//train/test}`
  acc=`echo $res|grep -o "[0-9]*\.[0-9]*"| head -1`
  realTime=`echo $res|grep -o "[0-9]*\.[0-9]*"| tail -1`
  # echo "   "$acc'%', $realTime's'
  accAll=`echo $accAll + $acc | bc`
  timeAll=`echo $timeAll + $realTime | bc`
done;

accAll=`echo "scale=2; $accAll / $num" | bc`
realTime=`echo "scale=2; $timeAll / $num" | bc`

echo $sampleNum "samples, cv acc = "$accAll"%, real time "$realTime"s"
echo $sampleNum,$accAll,$realTime >> $2  # append mode

# Clean up
rm train.a*
rm test.a*
