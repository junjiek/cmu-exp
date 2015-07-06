./build/multiboost --fileformat arff \
--traintest ./dataset/pendigits/pendigitsTrain.arff ./dataset/pendigits/pendigitsTest.arff 100 \
--verbose 3 --learnertype SingleStumpLearner --outputinfo ./output/pendigits/resultsSingleStump.dta \
--shypname ./output/pendigits/shypSingleStump.xml