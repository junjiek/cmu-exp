import sys
import scipy
import numpy as np
import warnings
import sklearn.feature_selection

from scipy import special, stats
from scipy.sparse import issparse
from sklearn.feature_selection import SelectKBest
from sklearn.datasets import load_svmlight_files
from sklearn.utils.validation import check_array
from sklearn.preprocessing import MultiLabelBinarizer
from sklearn.utils.extmath import norm, safe_sparse_dot
# from sklearn.feature_selection import chi2

from svmIO import dump_svmlight_file


def ttest(X, y):
    X = check_array(X, accept_sparse='csr')
    if np.any((X.data if issparse(X) else X) < 0):
        raise ValueError("Input X must be non-negative.")

    Y = MultiLabelBinarizer().fit_transform(y)
    if Y.shape[1] == 1:
        Y = np.append(1 - Y, Y, axis=1)
    negY = 1- Y
    labelNum = Y.shape[1]
#     sampleNum = Y.shape[0]
    featureNum = X.shape[1]
    t = []
    prob = []
    for i in range(featureNum):
        values = X[:,i].T.toarray()[0]
        ti = 0
        probi = 0
        for j in range(labelNum):
            observed = values * Y[:,j]
            notObserved = values * negY[:,j]
            (res0, res1) = scipy.stats.ttest_ind(observed, notObserved)
            ti = ti + res0
            probi = probi + res1
        t.append(ti)
        prob.append(probi)
    t = np.asarray(t)
    prob = np.asarray(prob)
    return t, prob

# def ttest(X, y):
#     X = check_array(X, accept_sparse='csr')
#     if np.any((X.data if issparse(X) else X) < 0):
#         raise ValueError("Input X must be non-negative.")

#     Y = MultiLabelBinarizer().fit_transform(y)
#     if Y.shape[1] == 1:
#         Y = np.append(1 - Y, Y, axis=1)
#     negY = 1- Y
#     labelNum = Y.shape[1]
#     sampleNum = Y.shape[0]
#     featureNum = X.shape[1]
#     t = []
#     prob = []
#     for i in range(featureNum):
#         values = X[:,i]
#         ti = 0
#         probi = 0
#         for j in range(labelNum):
#             observed = values[Y[:,j]==True]
#             notObserved = values[Y[:,j]==False]
#             X1_avg = observed.sum()/sampleNum
#             X2_avg = notObserved.sum()/sampleNum
#             sqr = observed.copy()
#             sqr.data **= 2
#             v1 = sqr.sum()/sampleNum - X1_avg**2
#             sqr = notObserved.copy()
#             sqr.data **= 2
#             v2 = sqr.sum()/sampleNum - X2_avg**2

#             denom = np.sqrt((v1 + v2)/sampleNum)
#             d = X1_avg - X2_avg
#             ti = ti + d / denom
#         t.append(ti)
#         prob.append(1)
#     return np.asarray(t), np.asarray(prob)


def select_feature(trainfilename, testfilename):
    def returnTtest(X, y):
        return tvalue
    X_train, y_train, X_test, y_test = load_svmlight_files((trainfilename, testfilename), multilabel=True)
    
    featureNum = X_train.get_shape()[1]
    tvalue = ttest(X_train, y_train)

    step = featureNum / 20;
    for i in range(1, 21):
        selectNum = step * i
        print "selecting", selectNum, "features"
        selector = SelectKBest(returnTtest, k=selectNum)
        X_train_new = selector.fit_transform(X_train, y_train)
        X_test_new= selector.transform(X_test)
        dump_svmlight_file(X_train_new, y_train, trainfilename + '_' + str(selectNum), zero_based = False)
        dump_svmlight_file(X_test_new, y_test, testfilename + '_' + str(selectNum), zero_based = False)

    
if __name__ == '__main__':
    if len(sys.argv) != 3:
        print 'Usage: python trainfilename testfilename'
        exit(1)
    trainfilename = sys.argv[1]
    testfilename = sys.argv[2]
    select_feature(trainfilename, testfilename)