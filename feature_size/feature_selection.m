function feature_selection(trainfile, testfile)
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
    fprintf('Total feature num %d\n', featureNum);
    step=floor(featureNum/20);
    for i = 1:1:20
        select=i*step;
        fprintf('  %d: feature num %d\n', i, select);
        fs=featureIdxSortbyP(1:select);
        sample_feature=train_feature_mat(:,fs);
        libsvmwrite(sprintf('%s_%c_%d',trainfile,'a'+i-1,select), train_label_vec, sample_feature);
        sample_feature=test_feature_mat(:,fs);
        libsvmwrite(sprintf('%s_%c_%d',testfile,'a'+i-1,select), test_label_vec, sample_feature);
    end
end