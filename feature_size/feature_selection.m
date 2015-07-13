function feature_selection(trainfile, testfile, roundnum)
    [train_label_vec, train_feature_mat] = libsvmread(trainfile);
    [test_label_vec, test_feature_mat] = libsvmread(testfile);
    dataTrainG1 = train_feature_mat(train_label_vec==1,:);
    dataTrainG2 = train_feature_mat(train_label_vec==-1,:);
    [h,p,ci,stat] = ttest2(full(dataTrainG1),full(dataTrainG2),'Vartype','unequal');
%     ecdf(p);
%     xlabel('P value'); 
%     ylabel('CDF value')
    [~,featureIdxSortbyP] = sort(p,2); % sort the features
    featureNum=size(featureIdxSortbyP, 2);
    step=floor(featureNum / roundnum);
    for i = step:step:featureNum
        fprintf('feature num %d\n', i);
        fs=featureIdxSortbyP(1:i);
        sample_feature=train_feature_mat(:,fs);
        libsvmwrite(sprintf('%s_%d',trainfile,i), train_label_vec, sample_feature);
        sample_feature=test_feature_mat(:,fs);
        libsvmwrite(sprintf('%s_%d',testfile,i), test_label_vec, sample_feature);
    end
end