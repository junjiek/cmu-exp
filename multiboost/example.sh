# ./build/multiboost --fileformat arff \
# --traintest ./dataset/pendigits/pendigitsTrain.arff ./dataset/pendigits/pendigitsTest.arff 100 \
# --verbose 3 --learnertype SingleStumpLearner --outputinfo ./output/pendigits/resultsSingleStump.dta \
# --shypname ./output/pendigits/shypSingleStump.xml

# ./build/multiboost --fileformat svmlight \
# --traintest ./dataset/sparse/train.txt ./dataset/sparse/test.txt 1000 \
# --verbose 5 --learnertype SingleSparseStumpLearner --outputinfo \
# ./output/sparse/resultsSparseStump.dta --constant --shypname ./output/sparse/shypSparseStump.xml \
#  --weightpolicy proportional

./build/multiboost --fileformat svmlight \
--train ../dataset/news20.binary 1000 \
--verbose 5 --learnertype SingleSparseStumpLearner --outputinfo \
./output/sparse/resultsSparseStump.dta --constant --shypname ./output/sparse/shypSparseStump.xml \
 --weightpolicy proportional


# 服务器端跑的rcv1
# ./multiboost/build/multiboost --fileformat svmlight \
# --traintest ./new_dataset/rcv1_train.binary ./new_dataset/rcv1_test.binary 100 \
# --verbose 5 --learnertype SingleSparseStumpLearner --outputinfo \
# ./output/rcv1_multiboost.dta --constant --shypname ./output/rcv1_multiboost_shyp.xml \
# --weightpolicy proportional


./multiboost/build/multiboost --fileformat svmlight \
--train ./new_dataset/news20.binary 100 \
--verbose 5 --learnertype SingleSparseStumpLearner --outputinfo \
./output/news20_multiboost.dta --constant --shypname ./output/news20_multiboost_shyp.xml \
--weightpolicy proportional