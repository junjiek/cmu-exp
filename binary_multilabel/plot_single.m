function plot_single(id)
    M1 = csvread(sprintf('./output/%s/ig/liblinear_%s.out',id,id), 1);
    M2 = csvread(sprintf('./output/%s/ig/fest_boosting_%s.out',id,id), 1);
    M3 = csvread(sprintf('./output/%s/ig/fest_randomforest_%s.out',id,id), 1);
    M4 = csvread(sprintf('./output/%s/ig/svmlight_%s.out',id,id), 1);
    M1=sort(M1(:,:));
    M2=sort(M2(:,:));
    M3=sort(M3(:,:));
    M4=sort(M4(:,:));
    figure();
    subplot(311);
    hold on;
    g1 = plot(M1(:,1), M1(:,4), '-');
    g2 = plot(M2(:,1), M2(:,4), 'r-');
    g3 = plot(M3(:,1), M3(:,4), 'k-');
    g4 = plot(M4(:,1), M4(:,4), 'g-');
    legend([g1,g2,g3,g4],'liblinear', 'FEST boosting','FEST random forest', 'svmlight');
    xlabel('Feature Size');
    ylabel('Micro-F');
    subplot(312);
    hold on;
    g1 = plot(M1(:,1), M1(:,5), '-');
    g2 = plot(M2(:,1), M2(:,5), 'r-');
    g3 = plot(M3(:,1), M3(:,5), 'k-');
    g4 = plot(M4(:,1), M4(:,5), 'g-');
%     legend([g1,g2,g3],'liblinear','FEST boosting', 'FEST random forest');
    xlabel('Feature Size');
    ylabel('Macro-F');
    subplot(313);
    hold on;
    g1 = plot(M1(:,1), M1(:,6), '-');
    g2 = plot(M2(:,1), M2(:,6), 'r-');
    g3 = plot(M3(:,1), M3(:,6), 'k-');
    g4 = plot(M4(:,1), M4(:,6), 'g-');
%     legend([g1,g2,g3],'liblinear','FEST boosting', 'FEST random forest');
    xlabel('Feature Size');
    ylabel('Running Time (s)');

    % liblinear
    figure();hold on;
    subplot(311);
    g1 = plot(M1(:,1), M1(:,4), '-');
    legend(g1,'liblinear');
    xlabel('Feature Size');
    ylabel('Micro-F');
    subplot(312);
    g1 = plot(M1(:,1), M1(:,5), '-');
%     legend(g1,'liblinear');
    xlabel('Feature Size');
    ylabel('Macro-F');
    subplot(313);
    g1 = plot(M1(:,1), M1(:,6), '-');
%     legend(g1,'liblinear');
    xlabel('Feature Size');
    ylabel('Running Time (s)');
    
    
% FEST boosting
    figure();hold on;
    subplot(311);
    g2 = plot(M2(:,1), M2(:,4), 'r-');
    legend(g2,'FEST boosting');
    xlabel('Feature Size');
    ylabel('Micro-F');
    subplot(312);
    g2 = plot(M2(:,1), M2(:,5), 'r-');
%     legend(g2,'FEST boosting');
    xlabel('Feature Size');
    ylabel('Macro-F');
    subplot(313);
    g2 = plot(M2(:,1), M2(:,6), 'r-');
%     legend(g2,'FEST boosting');
    xlabel('Feature Size');
    ylabel('Running Time (s)');

 % FEST random forest
    figure();hold on;
    subplot(311);
    g3 = plot(M3(:,1), M3(:,4), 'k-');
    legend(g3,'FEST random forest');
    xlabel('Feature Size');
    ylabel('Micro-F');
    subplot(312);
    g3 = plot(M3(:,1), M3(:,5), 'k-');
%     legend(g3,'FEST random forest');
    xlabel('Feature Size');
    ylabel('Macro-F');
    subplot(313);
    g3 = plot(M3(:,1), M3(:,6), 'k-');
%     legend(g3,'FEST random forest');
    xlabel('Feature Size');
    ylabel('Running Time (s)');

%   svm light
    figure();hold on;
    subplot(311);
    g4 = plot(M4(:,1), M4(:,4), 'g-');
    legend(g4,'svmlight');
    xlabel('Feature Size');
    ylabel('Micro-F');
    subplot(312);
    g4 = plot(M4(:,1), M4(:,5), 'g-');
%     legend(g3,'FEST random forest');
    xlabel('Feature Size');
    ylabel('Macro-F');
    subplot(313);
    g4 = plot(M4(:,1), M4(:,6), 'g-');
%     legend(g3,'FEST random forest');
    xlabel('Feature Size');
    ylabel('Running Time (s)');
    % saveas(fig, 'fig', 'png');
end

