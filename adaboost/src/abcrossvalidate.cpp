#include <iostream>
#include <string>
#include <cstdlib>
#include "AdaBoost.h"

struct ParameterABCrossValidate {
    bool verbose;
    std::string trainingDataFilename;
    int boostingType;
    int roundTotal;
    int k_cv;
};

// Prototype declaration
void exitWithUsage();
ParameterABCrossValidate parseCommandline(int argc, char* argv[]);

void exitWithUsage() {
    std::cerr << "usage: abtrain [options] training_set_file [model_file]" << std::endl;
    std::cerr << "options:" << std::endl;
    std::cerr << "   -t: type of boosting (0:discrete, 1:real, 2:gentle) [default:2]" << std::endl;
    std::cerr << "   -r: the number of rounds [default:100]" << std::endl;
    std::cerr << "   -v: verbose" << std::endl;
    std::cerr << "   -k: k-fold cross-valiation" << std::endl;    
    exit(1);
}

ParameterABCrossValidate parseCommandline(int argc, char* argv[]) {
    ParameterABCrossValidate parameters;
    parameters.verbose = false;
    parameters.boostingType = 2;
    parameters.roundTotal = 100;
    parameters.k_cv = 5;
    // Options
    int argIndex;
    for (argIndex = 1; argIndex < argc; ++argIndex) {
        if (argv[argIndex][0] != '-') break;
        
        switch (argv[argIndex][1]) {
            case 'v':
                parameters.verbose = true;
                break;
            case 't':
            {
                ++argIndex;
                if (argIndex >= argc) exitWithUsage();
                int boostingType = atoi(argv[argIndex]);
                if (boostingType < 0 || boostingType > 2) {
                    std::cerr << "error: invalid type of boosting" << std::endl;
                    exitWithUsage();
                }
                parameters.boostingType = boostingType;
                break;
            }
            case 'r':
            {
                ++argIndex;
                if (argIndex >= argc) exitWithUsage();
                int roundTotal = atoi(argv[argIndex]);
                if (roundTotal < 0) {
                    std::cerr << "error: negative number of rounds" << std::endl;
                    exitWithUsage();
                }
                parameters.roundTotal = roundTotal;
                break;
            }
            case 'k':  // k-fold cross-valiation
            {
                ++argIndex;
                if (argIndex >= argc) exitWithUsage();
                int k_cv = atoi(argv[argIndex]);
                if (k_cv < 0) {
                    std::cerr << "error: negative k" << std::endl;
                    exitWithUsage();
                }
                parameters.k_cv = k_cv;
                break;
            }
            default:
                std::cerr << "error: undefined option" << std::endl;
                exitWithUsage();
                break;
        }
    }
    
    // Training data file
    if (argIndex >= argc) exitWithUsage();
    parameters.trainingDataFilename = argv[argIndex];
    
    return parameters;
}

int main(int argc, char* argv[]) {
    ParameterABCrossValidate parameters = parseCommandline(argc, argv);
    
    if (parameters.verbose) {
        std::string boostingTypeName[3] = {"discrete", "real", "gentle"};
        std::cerr << std::endl;
        std::cerr << "Traing data:  " << parameters.trainingDataFilename << std::endl;
        std::cerr << "   Type:      " << boostingTypeName[parameters.boostingType] << std::endl;
        std::cerr << "   #rounds:   " << parameters.roundTotal << std::endl;
        std::cerr << "   #" << parameters.k_cv << " fold cross-valiation" << std::endl;
        std::cerr << std::endl;
    }
    
    AdaBoost adaBoost;
    adaBoost.setBoostingType(parameters.boostingType);
    adaBoost.readAllSamples(parameters.trainingDataFilename, parameters.k_cv);
    double accuracyAll = 0.0;
    for (int i = 0; i < parameters.k_cv; i++) {
        if (parameters.verbose)
            std::cout << "====== CV Round " << i << " ======" << std::endl;
        adaBoost.setCrossValidationSampels(i, parameters.k_cv);
        adaBoost.train(parameters.roundTotal, parameters.verbose);
        TestResult res = adaBoost.test(false, "");
        accuracyAll += res.accuracyAll;
        if (parameters.verbose) {
            std::cout << "Accuracy = " << res.accuracyAll << std::endl;
            std::cout << "  precision: " << res.precision << " , negative: " << res.recall << std::endl;

        }
    }
    std::cout << "\nCross Validation Accuracy: " << accuracyAll / parameters.k_cv << std::endl;
}
