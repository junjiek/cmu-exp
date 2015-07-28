function plottingbin(id)
    M1 = csvread(sprintf('./output/%s/ig/liblinear_%s.out',id,id), 1);
    M2 = csvread(sprintf('./output/%s/ig/fest_boosting_%s.out',id,id), 1);
    M3 = csvread(sprintf('./output/%s/ig/fest_randomforest_%s.out',id,id), 1);
    M1=sort(M1(:,:));
    M2=sort(M2(:,:));
    M3=sort(M3(:,:));

    figure();
    title(id);
    subplot(421);
    hold on;
    g1 = plot(M1(:,1), M1(:,3), '-');
    g2 = plot(M2(:,1), M2(:,3), 'r-');
    g3 = plot(M3(:,1), M3(:,3), 'g-');
    legend([g1,g2,g3],'liblinear','FEST boosting', 'FEST random forest');
    xlabel('Feature Size');
    ylabel('Testing accuracy (%)');
    subplot(422);
    hold on;
    g1 = plot(M1(:,1), M1(:,6), '-');
    g2 = plot(M2(:,1), M2(:,4), 'r-');
    g3 = plot(M3(:,1), M3(:,4), 'g-');
    xlabel('Feature Size');
    ylabel('Running Time (s)');

    % liblinear
    subplot(423);
    g1 = plot(M1(:,1), M1(:,3), '-');
    legend(g1,'liblinear');
    xlabel('Feature Size');
    ylabel('Testing Accuracy (%)');
    subplot(424);
    g1 = plot(M1(:,1), M1(:,6), '-');
    xlabel('Feature Size');
    ylabel('Running Time (s)');
    
% FEST boosting
    subplot(425);
    g2 = plot(M2(:,1), M2(:,3), 'r-');
    legend(g2,'FEST boosting');
    xlabel('Feature Size');
    ylabel('Testing Accuracy (%)');
    subplot(426);
    g2 = plot(M2(:,1), M2(:,4), 'r-');
    xlabel('Feature Size');
    ylabel('Running Time (s)');

 % FEST random forest
    subplot(427);
    g3 = plot(M3(:,1), M3(:,3), 'g-');
    legend(g3,'FEST random forest');
    xlabel('Feature Size');
    ylabel('Testing Accuracy (%)');
    subplot(428);
    g3 = plot(M3(:,1), M3(:,4), 'g-');
    xlabel('Feature Size');
    ylabel('Running Time (s)');


end

