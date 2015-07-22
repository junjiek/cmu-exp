% function plotting(filename1, filename2)
M1 = csvread('fest_randomforest.out', 1);
M2 = csvread('graph/fest_randomforest.out', 1);
% M3 = csvread('graph/fest_randomforest.out', 1);
    
fig = figure();
subplot(211);
hold on;
g1=plot(M1(:,1), M1(:,2), '-');
g2=plot(M2(:,1), M2(:,2), 'r-');
%     g3=plot(M3(:,1), M3(:,2), 'g-');
%     legend(g1,'liblinear');
%     legend(g2,'FEST boosting');
%     legend(g3,'FEST randomforest');
legend([g1,g2],'RF tree=300','RF tree=100');

%     legend([g1,g2,g3],'liblinear','FEST boosting', 'FEST randomforest');
xlabel('TrainingSampleSize');
ylabel('Testing Accuracy (%)');
subplot(212);
hold on;
g1=plot(M1(:,1), M1(:,3), '-');
g2=plot(M2(:,1), M2(:,3), 'r-');
%     g3=plot(M3(:,1), M3(:,3), 'g-');
%     legend(g1,'liblinear');
%     legend(g2,'FEST boosting');
%     legend(g3,'FEST randomforest');
legend([g1,g2],'RF tree=300','RF tree=100');

%     legend([g1,g2,g3],'liblinear','FEST boosting', 'FEST randomforest');
xlabel('TrainingSampleSize');
ylabel('Running Time (s)');
%     saveas(fig, 'fig', 'png');
% end