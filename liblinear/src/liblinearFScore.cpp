#include <iostream>
#include <sstream>
#include <fstream>
#include <string>
#include <cstdlib>
#include <cstdio>
#include <unordered_map>
using namespace std;


int main(int argc, char *argv[]) {
    if (argc != 3) {
        printf("Usage: ./liblinearFScore testdataFile predictionFile\n");
        exit(0);
    }
    char* testdataFile = argv[1];
    char* predictionFile = argv[2];
    ifstream fin1(testdataFile);
    ifstream fin2(predictionFile);
    string testExample, predictLabel, realLabel;
    unordered_map<string, int> TP, FP, FN;
    while (getline(fin1, testExample)) {
        istringstream iss(testExample);
        iss >> realLabel;
        if (getline(fin2, predictLabel)) {
            // printf("%s, %s\n", realLabel.c_str(), predictLabel.c_str());
            if (realLabel == predictLabel) {
                // printf("equal\n");
                TP[realLabel] ++;
            } else {
                FP[predictLabel] ++;
                FN[realLabel] ++;
            }
        }
    }
    double precision, recall;
    double macroF = 0.0, microF;
    int TP_all = 0, TP_FP_all = 0, TP_FN_all = 0;
    unordered_map<string, int>::iterator iter;
    for (iter = TP.begin(); iter != TP.end(); iter ++ ) {
        string classId = (*iter).first;
        precision = (double)TP[classId] / (TP[classId] + FP[classId]);
        recall = (double)TP[classId] / (TP[classId] + FN[classId]);
        if (precision + recall != 0)
            macroF += 2 * precision * recall / (precision + recall);

        TP_all += TP[classId];
        TP_FP_all += (TP[classId] + FP[classId]);
        TP_FN_all += (TP[classId] + FN[classId]);
    }

    macroF /= TP.size();

    precision = (double)TP_all / TP_FP_all;
    recall = (double)TP_all / TP_FN_all;
    microF = 2 * precision * recall / (precision + recall);

    printf("acc: %.6lf , microF: %.6lf, macroF: %.6lf\n", precision, microF, macroF);
    return 0;
}