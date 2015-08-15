import sys
import numpy as np
import warnings

from scipy import special, stats
from scipy.sparse import issparse
import sklearn.feature_selection
from sklearn.feature_selection import SelectKBest
from sklearn.datasets import load_svmlight_files
# from sklearn.feature_selection import chi2
from svmIO import dump_svmlight_file
from sklearn.utils.validation import check_array
from sklearn.preprocessing import MultiLabelBinarizer
from sklearn.utils.extmath import norm, safe_sparse_dot

def _chisquare(f_obs, f_exp):
    f_obs = np.asarray(f_obs, dtype=np.float64)

    k = len(f_obs)
    # Reuse f_obs for chi-squared statistics
    chisq = f_obs
    chisq -= f_exp
    chisq **= 2
    chisq /= f_exp
    chisq = chisq.max(axis=0)
    return chisq, special.chdtrc(k - 1, chisq)

def chi2(X, y):
    X = check_array(X, accept_sparse='csr')
    if np.any((X.data if issparse(X) else X) < 0):
        raise ValueError("Input X must be non-negative.")

    Y = MultiLabelBinarizer().fit_transform(y)
    if Y.shape[1] == 1:
        Y = np.append(1 - Y, Y, axis=1)

    observed = safe_sparse_dot(Y.T, X)          # n_classes * n_features

    feature_count = check_array(X.sum(axis=0))
    class_prob = check_array(Y.mean(axis=0))
    expected = np.dot(class_prob.T, feature_count)

    return _chisquare(observed, expected)

def select_feature(trainfilename, testfilename):
    def returnCHI(X, y):
        return chivalue
    X_train, y_train, X_test, y_test = load_svmlight_files((trainfilename, testfilename), multilabel=True)
    
    featureNum = X_train.get_shape()[1]
    chivalue = chi2(X_train, y_train)

    step = featureNum / 20;
    for i in range(1, 21):
        selectNum = step * i
        print "selecting", selectNum, "features"
        selector = SelectKBest(chi2, k=selectNum)
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