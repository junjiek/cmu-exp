function compare(id)
    M1 = csvread(sprintf('liblinear_%s.out',id), 1);
    M2 = csvread(sprintf('fest_boosting_%s.out',id), 1);
    M3 = csvread(sprintf('fest_randomforest_%s.out',id), 1);
    M1=sort(M1(:,:));
    M2=sort(M2(:,:));
    M3=sort(M3(:,:));
    
    Mr1 = csvread(sprintf('liblinear_%s_r.out',id), 1);
    Mr2 = csvread(sprintf('fest_boosting_%s_r.out',id), 1);
    Mr3 = csvread(sprintf('fest_randomforest_%s_r.out',id), 1);
    Mr1=sort(Mr1(:,:));
    Mr2=sort(Mr2(:,:));
    Mr3=sort(Mr3(:,:));
    
    figure();
    subplot(321);
    hold on;
    g1 = plot(M1(:,1), M1(:,3), '-');
    g2 = plot(Mr1(:,1), Mr1(:,3), '--');
    xlabel('Feature Size');
    ylabel('Testing Accuracy (%)');

    subplot(322);
    hold on;
    g1 = plot(M1(:,1), M1(:,4), '-');
    g2 = plot(Mr1(:,1), Mr1(:,4), '--');
    xlabel('Feature Size');
    ylabel('Running Time (s)');
    legend([g1,g2],'liblinear sort','liblinear random');
    
    subplot(323);
    hold on;
    g1 = plot(M2(:,1), M1(:,3), 'r-');
    plot(Mr2(:,1), Mr2(:,3), 'r--');
    xlabel('Feature Size');
    ylabel('Testing Accuracy (%)');

    subplot(324);
    hold on;
    g1 = plot(M2(:,1), M2(:,4), 'r-');
    g2 = plot(Mr2(:,1), Mr2(:,4), 'r--');
    xlabel('Feature Size');
    ylabel('Running Time (s)');
    
    legend([g1,g2],'BT sort','BT random');
    
    
    subplot(325);
    hold on;
    g1 = plot(M3(:,1), M3(:,3), 'g-');
    g2 = plot(Mr3(:,1), Mr3(:,3), 'g--');
    xlabel('Feature Size');
    ylabel('Testing Accuracy (%)');

    
    subplot(326);
    hold on;
    g1 = plot(M3(:,1), M3(:,4), 'g-');
    g2 = plot(Mr3(:,1), Mr3(:,4), 'g--');
    xlabel('Feature Size');
    ylabel('Running Time (s)');
    legend([g1,g2],'RF sort','RF random');
    
    
end