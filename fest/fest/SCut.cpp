/***************************************************************************
 * Author: Nikos Karampatziakis <nk@cs.cornell.edu>, Copyright (C) 2008    *
 *                                                                         *
 * Description: Classification module.                                     *
 *                                                                         *
 * License: See LICENSE file that comes with this distribution             *
 ***************************************************************************/

#include "dataset.h"
#include "tree.h"
#include "forest.h"
#include <cstdlib>
#include <cstdio>
#include <getopt.h>
#include <vector>

using namespace std;

bool pariCmp (pair<float, int> i, pair<float, int> j) { return (i.first > j.first); }

int main(int argc, char* argv[]){
    float* example;
    int maxline,target,nf,nex;
    float p;
    forest_t f;
    FILE* fp;
    FILE* fq;
    int trees=0;
    char* input=0;
    char* model=0;
    char* outfile=0;
    int option;

    const char* help="Usage: %s [options] data model outfile\nAvailable options:\n\
            -t <int>  : number of trees to use (default: 0 = all)\n";

    while((option=getopt(argc,argv,"t:"))!=EOF){
        switch(option){
            case 't': trees=atoi(optarg); break;
            case '?': fprintf(stderr,help,argv[0]); exit(1); break;
        }
    }
    if(trees < 0){
        fprintf(stderr,"Invalid number of trees\n");
        exit(1);
    }
    if(argc - optind == 3){
        input = argv[optind];
        model = argv[optind+1];
        outfile = argv[optind+2];
    }
    else{
        fprintf(stderr,help,argv[0]); 
        exit(1);
    }
    readForest(&f, model);
    if(trees > f.ngrown){
        fprintf(stderr,"Too many trees specified for this ensemble\n");
        fprintf(stderr,"Adjusting to %d\n",f.ngrown);
        trees = f.ngrown;
    }
    if(trees > 0)
        f.ngrown=trees;
    fp = fopen(input,"r");
    if (fp == NULL){
        fprintf(stderr,"Could not open test data file\n");
        exit(1);
    }
    fq = fopen(outfile,"w");
    if (fq == NULL){
        fprintf(stderr,"Could not open predictions file\n");
        exit(1);
    }

    maxline = getDimensions(fp,&nex,&nf);
    rewind(fp);
    example=(float*)malloc(f.nfeat*sizeof(float));
    vector<pair<float, int> > samples;
    int actualPos = 0;
    while(readExample(fp, maxline, example, f.nfeat, &target)){
        p=classifyForest(&f,example);
        actualPos += target;
        samples.push_back(make_pair(p, target));
    }
    sort(samples.begin(), samples.end(), pariCmp);
    int tp = 0;
    int maxIdx = 0;
    double maxF = 0.0;
    if (actualPos == 0) {
        // printf("no pos examples\n");
        maxIdx = 0;
    }
    else {
        for (int i = 0; i < samples.size(); i++) {
            tp += samples[i].second;
            double precision = (double)tp / (i+1);
            double recall = (double)tp / (actualPos);
            double f = 2 * precision * recall / (precision + recall);
            if (f > maxF) {
                maxF = f;
                maxIdx = i;
            }
            // if (i < 10) {
            //     printf("%d: %f| f=%.4lf, p=%.4lf, r=%.4lf\n", samples[i].second, samples[i].first, f, precision, recall);
            // }
        }
    }
    // printf("%d %f\n", maxIdx, samples[maxIdx].first);
    fprintf(fq,"%f\n",samples[maxIdx].first);
    free(example);
    fclose(fp);
    fclose(fq);
    freeForest(&f);
    return 0;
}
