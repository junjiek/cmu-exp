import sys
import numpy as np
import sklearn.feature_selection
from sklearn.feature_selection import SelectKBest
from sklearn.datasets import load_svmlight_files
import sys, os.path
from string import *
from svmIO import dump_svmlight_file

def randomValues(X, y):
    featurenum = X.shape[1]
    return np.random.rand(featurenum,)

def select_feature_multilabel(trainfilename, testfilename):
    def returnIG(X, y):
        return randval, p
    X_train, y_train, X_test, y_test = load_svmlight_files((trainfilename, testfilename),  multilabel=True)

    featurenum = X_train.shape[1]
    randval = randomValues(X_train, y_train)
    p = np.ones((featurenum,1), int)
    p.reshape(featurenum,1)

    featureNum = X_train.get_shape()[1]
    step = featureNum / 20;
    for i in range(1, 21):
        selectNum = step * i
        print "selecting", selectNum, "features"
        selector = SelectKBest(returnIG, k=selectNum)
        X_train_new = selector.fit_transform(X_train, y_train)
        X_test_new = selector.transform(X_test)
        dump_svmlight_file(X_train_new, y_train, trainfilename + '_' + str(selectNum), zero_based = False)
        dump_svmlight_file(X_test_new, y_test, testfilename + '_' + str(selectNum), zero_based = False)



if __name__ == '__main__':
    if len(sys.argv) != 3:
        print 'Usage: python trainfilename testfilename'
        exit(1)
    trainfilename = sys.argv[1]
    testfilename = sys.argv[2]
    select_feature_multilabel(trainfilename, testfilename)