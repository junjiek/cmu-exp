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
#include <cstring>

int main(int argc, char* argv[]){
    float* example;
    int maxline,target,nf,nex;
    float p;
    forest_t f;
    FILE* fp;
    FILE* fq;
    FILE* fth;
    int trees=0;
    char* input=0;
    char* model=0;
    char* th=0;
    char* preds=0;
    int option;

    const char* help="Usage: %s [options] data model threhold predictions\nAvailable options:\n\
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
    if(argc - optind == 4){
        input = argv[optind];
        model = argv[optind+1];
        th = argv[optind+2];
        preds = argv[optind+3];
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
    fq = fopen(preds,"w");
    if (fq == NULL){
        fprintf(stderr,"Could not open predictions file\n");
        exit(1);
    }
    fth = fopen(th,"r");
    if (fth == NULL){
        fprintf(stderr,"Could not open threhold file\n");
        exit(1);
    }
    char* line = (char*)malloc(100*sizeof(char));
    float threhold = 1.0;
    if (fgets(line,100,fth)!= NULL) {
        sscanf(line, "%f", &threhold);
        // printf("threhold: %f\n", threhold);
    }

    maxline = getDimensions(fp,&nex,&nf);
    rewind(fp);
    example=(float*)malloc(f.nfeat*sizeof(float));
    while(readExample(fp, maxline, example, f.nfeat, &target)){
        p=classifyForest(&f,example);
        if (p > threhold)
            fprintf(fq,"1\n");
        else
            fprintf(fq, "-1\n");
    }
    free(example);
    fclose(fp);
    fclose(fq);
    freeForest(&f);
    return 0;
}
