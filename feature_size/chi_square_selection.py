import sys
import sklearn.feature_selection
from sklearn.feature_selection import SelectKBest
from sklearn.datasets import load_svmlight_files
from sklearn.feature_selection import chi2

def select_feature(trainfilename, testfilename):
    def returnCHI(X, y):
        return chivalue
    X_train, y_train, X_test, y_test = load_svmlight_files((trainfilename, testfilename))
    
    featureNum = X_train.get_shape()[1]
    chivalue = chi2(X_train, y_train)

    step = featureNum / 20;
    for i in range(1, 21):
        selectNum = step * i
        print "selecting", selectNum, "features"
        selector = SelectKBest(chi2, k=selectNum)
        X_train_new = selector.fit_transform(X_train, y_train)
        X_test_new= selector.transform(X_test)
        sklearn.datasets.dump_svmlight_file(X_train_new, y_train, trainfilename + '_' + str(selectNum), zero_based = False)
        sklearn.datasets.dump_svmlight_file(X_test_new, y_test, testfilename + '_' + str(selectNum), zero_based = False)

    
if __name__ == '__main__':
    if len(sys.argv) != 3:
        print 'Usage: python trainfilename testfilename'
        exit(1)
    trainfilename = sys.argv[1]
    testfilename = sys.argv[2]
    select_feature(trainfilename, testfilename)