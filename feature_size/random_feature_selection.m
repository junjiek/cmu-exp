function random_feature_selection(trainfile, testfile)
    [train_label_vec, train_feature_mat] = libsvmread(trainfile);
    [test_label_vec, test_feature_mat] = libsvmread(testfile);
    featureNum=min(size(train_feature_mat,2), size(test_feature_mat,2));
    featureIdxRandom=randperm(featureNum); % generate a random sequence of features
    fprintf('Total feature num %d\n', featureNum);
    step=floor(featureNum/20);
    for i = 1:1:20
        select=i*step;
        fprintf('  %d: feature num %d\n', i, select);
        fs=featureIdxRandom(1:select);
        sample_feature=train_feature_mat(:,fs);
        libsvmwrite(sprintf('%s_r%c_%d',trainfile,'a'+i-1,select), train_label_vec, sample_feature);
        sample_feature=test_feature_mat(:,fs);
        libsvmwrite(sprintf('%s_r%c_%d',testfile,'a'+i-1,select), test_label_vec, sample_feature);
    end
end