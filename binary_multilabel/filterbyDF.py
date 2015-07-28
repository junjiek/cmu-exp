import sys
import numpy as np
import sklearn.feature_selection
from sklearn.feature_selection import SelectKBest
from sklearn.datasets import load_svmlight_files

def documentFrequency(X, y):
    featurenum = X.shape[1]
    s = sum(X).toarray()
    p = np.ones((1,featurenum), int)
    return s.reshape(featurenum,), p.reshape(featurenum,1)
    
if __name__ == '__main__':
    if len(sys.argv) != 4:
        print 'Usage: python threshold trainfilename testfilename'
        exit(1)
    trainfilename = sys.argv[2]
    testfilename = sys.argv[3]
    X_train, y_train, X_test, y_test = load_svmlight_files((trainfilename, testfilename))

    df = sum(X_train).toarray()[0]
    cnt = 0;
    threshold = int(sys.argv[1])
    for i in range(0, len(df)):
        if (df[i] >= threshold):
            cnt = cnt + 1
    selector = SelectKBest(documentFrequency, k=cnt)
    X_train = selector.fit_transform(X_train, y_train)
    X_test= selector.transform(X_test)
    sklearn.datasets.dump_svmlight_file(X_train, y_train, trainfilename + '_' + str(cnt), zero_based = False)
    sklearn.datasets.dump_svmlight_file(X_test, y_test, testfilename + '_' + str(cnt), zero_based = False)
    print cnt, "features selected"