% function plotting(filename1, filename2)
    M1 = csvread('liblinear.out', 1);
    M2 = csvread('adaboost.out', 1);
    M3 = csvread('multiboost.out', 1);
    
%     fig = figure('visible','off');
    fig = figure();
    subplot(211);
    hold on;
    plot(M1(:,1), M1(:,2), '-');
    plot(M2(:,1), M2(:,2), 'r-');
%     plot(M3(:,1), M3(:,2), 'g-');
    xlabel('TrainingSampleSize');
    ylabel('Testing Accuracy (%)');
    subplot(212);
    hold on;
    plot(M1(:,1), M1(:,3), '-');
    plot(M2(:,1), M2(:,3), 'r-');
%     plot(M3(:,1), M3(:,3), 'g-');
    xlabel('TrainingSampleSize');
    ylabel('Running Time (s)');
    saveas(fig, 'fig', 'png');
% end