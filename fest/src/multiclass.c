#include "dataset.h"
#include "tree.h"
#include "forest.h"
#include <stdlib.h>
#include <stdio.h>
#include <time.h>
#include <getopt.h>
#include <string.h>

int main(int argc, char* argv[]){
    dataset_t d;
    forest_t* f;
    int option;
    int reportoob=0;
    int quite=0;
    int trees=100;
    int maxdepth=1000;
    int committee=2;
    int classnum;
    int i, j;
    int posCnt, negCnt;
    int* classId = NULL;
    float param=1.0f;
    float w=1.0;
    char* train=0;
    char* header=0;
    char* test=0;
    char* predictionOut=0;
    FILE* fp;
    FILE* fpw;
    time_t tim;

    float* example;
    int maxline,predict,nf,nex;
    short target;
    float p, pmax;
    int* TP;
    int* FP;
    int* FN;
    int TP_all = 0, TP_FP_all = 0, TP_FN_all = 0;
    double precision, recall, microF, macroF = 0.0;
    
    clock_t start, finish;
    double trainTime;
    const char* help="Usage: %s [options] train header test predictionOut \nAvailable options:\n\
    -c <int>  : committee type:\n\
                1 bagging\n\
                2 boosting (default)\n\
                3 random forest\n\
    -e        : quite mode (default: no)\n\
    -d <int>  : maximum depth of the trees (default: 1000)\n\
    -p <float>: parameter for random forests: (default: 1)\n\
                (ratio of features considered over sqrt(features))\n\
    -t <int>  : number of trees (default: 100)\n";
    

    while((option=getopt(argc,argv,"c:d:en:p:t:"))!=EOF){
        switch(option){
            case 'c': committee=atoi(optarg); break;
            case 'd': maxdepth=atoi(optarg); break;
            // case 'e': reportoob=1; break;
            // case 'n': w=atof(optarg); break;
            case 'p': param=atof(optarg); break;
            case 't': trees=atoi(optarg); break;
            case 'e': quite=1;break;
            case '?': fprintf(stderr,help,argv[0]); exit(1); break;
        }
    }
    if(committee!=BAGGING && committee!=BOOSTING && committee!=RANDOMFOREST){
        fprintf(stderr,"Unknown committee type\n");
        exit(1);
    }
    if(maxdepth<=0){
        fprintf(stderr,"Invalid tree depth\n");
        exit(1);
    }
    if(w<0){
        fprintf(stderr,"Invalid weight for negative class\n");
        exit(1);
    }
    if(param<=0){
        fprintf(stderr,"Invalid parameter value\n");
        exit(1);
    }
    if(trees<=0){
        fprintf(stderr,"Invalid number of trees\n");
        exit(1);
    }
    if(argc - optind == 4){
        train = argv[optind];
        header = argv[optind+1];
        test = argv[optind+2];
        predictionOut = argv[optind+3];
    }
    else{
        fprintf(stderr,help,argv[0]); 
        exit(1);
    }

    // ------------ training -------------
    start = clock();
    tim = time(0);
    srand(tim);

    loadData(train,&d);
    classId = malloc(1000*sizeof(int));
    classnum = loadHeader(header, classId);
    f = malloc(classnum*sizeof(forest_t));
    for (i = 0; i < classnum; i++) {
        posCnt = negCnt = 0;
        for (j = 0; j < d.nex; j++) {
            if (d.realtarget[j] == classId[i]) {
                d.target[j] = 1;
                posCnt ++;
            } else {
                d.target[j] = 0;
                negCnt ++;
            }
        }
        w = (double)posCnt / negCnt;
        initForest(&f[i],committee,maxdepth,param,trees,w,reportoob);
        growForest(&f[i], &d);
    }

    finish = clock();
    // ------------ testing -------------
    fp = fopen(test, "r");
    fpw = fopen(predictionOut, "w");
    if (fp == NULL){
        fprintf(stderr,"Could not open test data file\n");
        exit(1);
    }

    maxline = getDimensions(fp,&nex,&nf);
    rewind(fp);
    example=malloc(d.nfeat*sizeof(float));
    TP = malloc(classnum*sizeof(int));
    memset(TP, 0, classnum*sizeof(int));
    FP = malloc(classnum*sizeof(int));
    memset(FP, 0, classnum*sizeof(int));
    FN = malloc(classnum*sizeof(int));
    memset(FN, 0, classnum*sizeof(int));
    while(readExample(fp, maxline, example, d.nfeat, &target)){
        pmax = -1000;
        for (i = 0; i < classnum; i++) {
            p = classifyForest(&f[i],example);
            if (p > pmax) {
                pmax = p;
                predict = i;
            }
            // printf("%d: %f\n", classId[i], p);
        }
        // printf("tar: %d, pre: %d\n========\n", target, classId[predict]);
        fprintf(fpw, "%d\n", classId[predict]);
        if (target == classId[predict]) {
            TP[predict] ++;
        } else {
            FP[predict] ++;
            for (i = 0; i < classnum; i++) {
                if (classId[i] == target) {
                    FN[i]++;
                    break;
                }
                
            }
        }
    }
    if (!quite) {
        for (i = 0; i < classnum; i++) {
            // printf("------- classId %d,  TP:%d, FP:%d FN:%d\n", classId[i], TP[i], FP[i], FN[i]);

            precision = (double) TP[i] / (TP[i] + FP[i]);
            recall = (double) TP[i] / (TP[i] + FN[i]);
            if (precision + recall != 0)
                macroF += 2 * precision * recall / (precision + recall);
            TP_all += TP[i];
            TP_FP_all += (TP[i] + FP[i]);
            TP_FN_all += (TP[i] + FN[i]);
        }

        macroF /= classnum;
        // printf("TP_all: %d, TP_FP_all: %d, TP_FN_all: %d\n", TP_all, TP_FP_all, TP_FN_all);
        precision = (double) TP_all / TP_FP_all;
        recall = (double) TP_all / TP_FN_all;
        microF = 2 * precision * recall / (precision + recall);
        trainTime = (double)(finish - start) / CLOCKS_PER_SEC;
        printf("acc = %.2lf, microF = %.6lf, macroF = %.6lf, time %.2lfs\n", precision*100, microF, macroF, trainTime);
        
    }

    free(example);
    free(TP);
    free(FP);
    free(FN);
    fclose(fp);
    fclose(fpw);

    for (i = 0; i < classnum; i++)
        freeForest(&f[i]);
    freeData(&d);
    return 0;
}
