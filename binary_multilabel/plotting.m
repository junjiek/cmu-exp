function plotting(id)
    M1 = csvread(sprintf('output/%s/i/liblinear_%s.out',id,id), 1);
    M2 = csvread(sprintf('output/%s/r/fest_boosting_%s.out',id,id), 1);
    M3 = csvread(sprintf('output/%s/r/fest_randomforest_%s.out',id,id), 1);
%     M4 = csvread(sprintf('output/%s/ig/sk_randomforest_%s.out',id,id), 1);
    M1=sort(M1(:,:));
    M2=sort(M2(:,:));
    M3=sort(M3(:,:));
%     M4=sort(M4(:,:));
    figure();
    title(id);
    subplot(431);
    hold on;
    g1 = plot(M1(:,1), M1(:,4), '-');
    g2 = plot(M2(:,1), M2(:,4), 'r-');
    g3 = plot(M3(:,1), M3(:,4), 'g-');
%     g4 = plot(M4(:,1), M4(:,4), 'm-');
    legend([g1,g2,g3],'liblinear','FEST boosting', 'FEST random forest', 'sklearn randomforest');
    xlabel('Feature Size');
    ylabel('Micro-F');
    subplot(432);
    hold on;
    g1 = plot(M1(:,1), M1(:,5), '-');
    g2 = plot(M2(:,1), M2(:,5), 'r-');
    g3 = plot(M3(:,1), M3(:,5), 'g-');
%     g4 = plot(M4(:,1), M4(:,5), 'm-');
%     legend([g1,g2,g3],'liblinear','FEST boosting', 'FEST random forest');
    xlabel('Feature Size');
    ylabel('Macro-F');
    subplot(433);
    hold on;
    g1 = plot(M1(:,1), M1(:,6), '-');
    g2 = plot(M2(:,1), M2(:,6), 'r-');
    g3 = plot(M3(:,1), M3(:,6), 'g-');
%     g4 = plot(M3(:,1), M3(:,6), 'm-');
%     legend([g1,g2,g3],'liblinear','FEST boosting', 'FEST random forest');
    xlabel('Feature Size');
    ylabel('Running Time (s)');

    % liblinear
    subplot(434);
    g1 = plot(M1(:,1), M1(:,4), '-');
    legend(g1,'liblinear');
    xlabel('Feature Size');
    ylabel('Micro-F');
    subplot(435);
    g1 = plot(M1(:,1), M1(:,5), '-');
%     legend(g1,'liblinear');
    xlabel('Feature Size');
    ylabel('Macro-F');
    subplot(436);
    g1 = plot(M1(:,1), M1(:,6), '-');
%     legend(g1,'liblinear');
    xlabel('Feature Size');
    ylabel('Running Time (s)');
    
% FEST boosting
    subplot(437);
    g2 = plot(M2(:,1), M2(:,4), 'r-');
    legend(g2,'FEST boosting');
    xlabel('Feature Size');
    ylabel('Micro-F');
    subplot(438);
    g2 = plot(M2(:,1), M2(:,5), 'r-');
%     legend(g2,'FEST boosting');
    xlabel('Feature Size');
    ylabel('Macro-F');
    subplot(439);
    g2 = plot(M2(:,1), M2(:,6), 'r-');
%     legend(g2,'FEST boosting');
    xlabel('Feature Size');
    ylabel('Running Time (s)');

 % FEST random forest
    subplot(4,3,10);
    g3 = plot(M3(:,1), M3(:,4), 'g-');
    legend(g3,'FEST random forest');
    xlabel('Feature Size');
    ylabel('Micro-F');
    subplot(4,3,11);
    g3 = plot(M3(:,1), M3(:,5), 'g-');
%     legend(g3,'FEST random forest');
    xlabel('Feature Size');
    ylabel('Macro-F');
    subplot(4,3,12);
    g3 = plot(M3(:,1), M3(:,6), 'g-');
%     legend(g3,'FEST random forest');
    xlabel('Feature Size');
    ylabel('Running Time (s)');

    % sklearn random forest
%     subplot(5,3,13);
%     g4 = plot(M4(:,1), M4(:,4), 'm-');
%     legend(g4,'sklearn random forest');
%     xlabel('Feature Size');
%     ylabel('Micro-F');
%     subplot(5,3,14);
%     g4 = plot(M4(:,1), M4(:,5), 'm-');
% %     legend(g3,'FEST random forest');
%     xlabel('Feature Size');
%     ylabel('Macro-F');
%     subplot(5,3,15);
%     g4 = plot(M4(:,1), M4(:,6), 'm-');
% %     legend(g3,'FEST random forest');
%     xlabel('Feature Size');
%     ylabel('Running Time (s)');
    % saveas(fig, 'fig', 'png');
end

