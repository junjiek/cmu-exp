#!/usr/bin/env python

import sys, os.path
from sys import argv
from os import system, remove
from string import *
from subr import *

global train, test, pass_through_options
global labels, features, test_labels

festmulticlass_exe = '../fest/build/festmulticlass'
outDir = "../output/fest/rf/"

# process command line options, set global parameters
def process_options(argv = sys.argv):
    global train, test, pass_through_options

    if len(argv) < 4:
        print "Usage: %s [parameters for fest-train] training_file testing_file id" % argv[0]
        sys.exit(1)

    train = argv[-3]
    test = argv[-2]

    assert os.path.exists(train), "training_file not found."
    assert os.path.exists(test), "testing_file not found."

    pass_through_options = join(argv[1:len(argv)-3], " ")

def read_problem(file):
    assert os.path.exists(file), "%s not found." % (file)

    _labels = []
    _features = []

    in_file = open(file, "r")
    for line in in_file:
        spline = split(line)
        if spline[0].find(':') == -1:
            _labels.append(split(spline[0], ','))
            _features.append(join(spline[1:]))
        else:
            _labels.append([])
            _features.append(join(spline))
    in_file.close()

    return (_labels, _features)

def count_labels(labels):
    _labels = []

    for i in range(len(labels)):
        for lab in labels[i]:
            if (lab not in _labels):
                _labels.append(lab)

    return _labels

# Give me a label
def build_problem(lab):
    # build binary classification problem for label lab
    problem = open(outDir + sys.argv[-1] + "_tmp_binary", "w")

    for t in range(len(labels)):
        if lab in labels[t]:
            problem.write("+1 %s\n" % features[t])
        else:
            problem.write("-1 %s\n" % features[t])

    problem.close()

def train_test_problem(lab):
    # print "Training and Testing problem for label %s..." % lab
    cmd = "%s %s %s %s %s %s" % (festmulticlass_exe, pass_through_options,
                                 outDir + sys.argv[-1] + "_tmp_binary", outDir + sys.argv[-1] + "_tmp_binary_header", outDir + sys.argv[-1] + "_tmp_test", outDir + sys.argv[-1] + "_tmp_output")
    os.system(cmd)

def build_test(testset):
    global test_labels

    (test_labels, x) = read_problem(testset)
    out_test = open(outDir + sys.argv[-1] + "_tmp_test", "w")
    for i in range(len(test_labels)):
        out_test.write("+1 %s\n" % x[i])
    out_test.close()

def get_output(lab):
    index = []

    output = open(outDir + sys.argv[-1] + "_tmp_output", "r");

    t = 0
    for line in output:
        if split(line, '\n')[0] == "1":
            index.append(t)
        t = t + 1

    output.close()

    return index

def main():
    global train, test
    global labels, features, test_labels

    bh = open(outDir + sys.argv[-1] + '_tmp_binary_header', 'w');
    bh.write('+1 -1\n');
    bh.close();
    
    process_options()

    # read problem and get all labels
    (labels, features) = read_problem(train)
    all_labels = count_labels(labels)

    build_test(test)

    predict = []
    for i in range(len(test_labels)):
        predict.append([])

    for i in range(len(all_labels)):
        # train binary problem for the label all_labels[i]
        lab = all_labels[i] 

        build_problem(lab)
        train_test_problem(lab)
        index = get_output(lab)
        for idx in index:
            predict[idx].append("%s" % lab)

    out_predict = open(outDir + sys.argv[-1] + "_tmp_predict", "w")
    for i in range(len(predict)):
        out_predict.write("%s\n" % join(predict[i], ","))
    out_predict.close()

    result = measure(test_labels, predict, all_labels)
    
    print "Exact match ratio: %s" % result[0]
    print "Microaverage F-measure: %s" % result[1]
    print "Macroaverage F-measure: %s" % result[2]

    sys.stdout.flush()

main()
