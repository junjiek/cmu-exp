import sys
import numpy as np
import sklearn.feature_selection
from sklearn.feature_selection import SelectKBest
from sklearn.datasets import load_svmlight_files

def information_gain(X, y):
    
    def _calIg():
        entropy_x_set = 0
        entropy_x_not_set = 0
        for c in classCnt:
            probs = classCnt[c] / float(featureTot)
            entropy_x_set = entropy_x_set - probs * np.log(probs)
            if (classTotCnt[c] != classCnt[c] and tot != featureTot):
                probs = (classTotCnt[c] - classCnt[c]) / float(tot - featureTot)
                entropy_x_not_set = entropy_x_not_set - probs * np.log(probs)
        for c in classTotCnt:
            if c not in classCnt:
                probs = classTotCnt[c] / float(tot - featureTot)
                entropy_x_not_set = entropy_x_not_set - probs * np.log(probs)
        return entropy_before - ((featureTot / float(tot)) * entropy_x_set
                             +  ((tot - featureTot) / float(tot)) * entropy_x_not_set)
    
    tot = X.shape[0]
    classTotCnt = {}
    entropy_before = 0
    for i in y:
        if i not in classTotCnt:
            classTotCnt[i] = 1
        else:
            classTotCnt[i] = classTotCnt[i] + 1
    for c in classTotCnt:
        probs = classTotCnt[c] / float(tot)
        entropy_before = entropy_before - probs * np.log(probs)
    
    nz = X.T.nonzero()
    pre = 0
    classCnt = {}
    featureTot = 0
    information_gain = []
    for i in range(0, len(nz[0])):
        if (i != 0 and nz[0][i] != pre):
            for notappear in range(pre+1, nz[0][i]):
                information_gain.append(0)
            ig = _calIg()
            information_gain.append(ig)
            pre = nz[0][i]
            classCnt = {}
            featureTot = 0
        featureTot = featureTot + 1
        yclass = y[nz[1][i]]
        if yclass not in classCnt:
            classCnt[yclass] = 1
        else:
            classCnt[yclass] = classCnt[yclass] + 1
    ig = _calIg()
    information_gain.append(ig)
    featurenum = X.shape[1]
    for notappear in range(pre + 1, featurenum):
        information_gain.append(0)
    return np.asarray(information_gain)

def select_feature(trainfilename, testfilename):
    def returnIG(X, y):
        return ig, p
    X_train, y_train, X_test, y_test = load_svmlight_files((trainfilename, testfilename))

    featurenum = X_train.shape[1]
    ig = information_gain(X_train, y_train)
    ig = ig.reshape(featurenum,)
    p = np.ones((1,featurenum), int)
    p.reshape(featurenum,1)

    featureNum = X_train.get_shape()[1]
    step = featureNum / 20;
    for i in range(1, 21):
        selectNum = step * i
        print "selecting", selectNum, "features"
        selector = SelectKBest(returnIG, k=selectNum)
        X_train_new = selector.fit_transform(X_train, y_train)
        X_test_new = selector.transform(X_test)
        sklearn.datasets.dump_svmlight_file(X_train_new, y_train, trainfilename + '_' + str(selectNum), zero_based = False)
        sklearn.datasets.dump_svmlight_file(X_test_new, y_test, testfilename + '_' + str(selectNum), zero_based = False)


if __name__ == '__main__':
    if len(sys.argv) != 3:
        print 'Usage: python trainfilename testfilename'
        exit(1)
    trainfilename = sys.argv[1]
    testfilename = sys.argv[2]
    select_feature(trainfilename, testfilename)