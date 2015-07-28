from sklearn.datasets import load_svmlight_files
from sklearn.ensemble import RandomForestClassifier
from sklearn.metrics import f1_score
from sklearn.metrics import accuracy_score
import time,sys

if __name__ == '__main__':
    if len(sys.argv) != 4:
        print 'Usage: python trainfilename testfilename predictionOutput'
        exit(1)
    trainfilename = sys.argv[1]
    testfilename = sys.argv[2]
    predictionOut = sys.argv[3]
    X_train, y_train, X_test, y_test = load_svmlight_files((trainfilename, testfilename))
    clf = RandomForestClassifier(n_estimators=100)
    start = time.clock()
    clf = clf.fit(X_train, y_train)
    finish = time.clock()
    trainTime = finish - start
    y_pred = clf.predict(X_test)
    y_pred = y_pred.astype(int)
    fout = open(predictionOut, 'w')
    for i in y_pred:
        fout.write(str(i)+'\n')
    acc = accuracy_score(y_test, y_pred) * 100
    macroF = f1_score(y_test, y_pred, average='macro')
    microF = f1_score(y_test, y_pred, average='micro')
    print("acc = %.2lf, microF = %.6lf, macroF = %.6lf, time = %.2lf s" % (acc, microF, macroF, trainTime))