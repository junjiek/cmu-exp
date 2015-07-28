function bin_compare3(id)
    % random/ig
        
    Mr1 = csvread(sprintf('./output/%s/random/liblinear_%s.out',id,id), 1);
    Mr2 = csvread(sprintf('./output/%s/random/fest_boosting_%s.out',id,id), 1);
    Mr3 = csvread(sprintf('./output/%s/random/fest_randomforest_%s.out',id,id), 1);
    Mr1=sort(Mr1(:,:));
    Mr2=sort(Mr2(:,:));
    Mr3=sort(Mr3(:,:));

    Mig1 = csvread(sprintf('./output/%s/ig/liblinear_%s.out',id,id), 1);
    Mig2 = csvread(sprintf('./output/%s/ig/fest_boosting_%s.out',id,id), 1);
    Mig3 = csvread(sprintf('./output/%s/ig/fest_randomforest_%s.out',id,id), 1);
    Mig1=sort(Mig1(:,:));
    Mig2=sort(Mig2(:,:));
    Mig3=sort(Mig3(:,:));

    figure();
    subplot(321);
    hold on;
    g1 = plot(Mr1(:,1), Mr1(:,3), 'k-');
    g2 = plot(Mig1(:,1), Mig1(:,3), 'r-');
    xlabel('Feature Size');
    ylabel('Testing Accuracy (%)');

    subplot(322);
    hold on;
    g1 = plot(Mr1(:,1), Mr1(:,4), 'k-');
    g2 = plot(Mig1(:,1), Mig1(:,6), 'r-');
    xlabel('Feature Size');
    ylabel('Running Time (s)');
    legend([g1,g2],'liblinear random','liblinear IG');
    
    subplot(323);
    hold on;
    g1 = plot(Mr2(:,1), Mr2(:,3), 'k-');
    g2 = plot(Mig2(:,1), Mig2(:,3), 'r-');
    xlabel('Feature Size');
    ylabel('Testing Accuracy (%)');

    subplot(324);
    hold on;
    g1 = plot(Mr2(:,1), Mr2(:,4), 'k-');
    g2 = plot(Mig2(:,1), Mig2(:,4), 'r-');
    xlabel('Feature Size');
    ylabel('Running Time (s)');
    
    legend([g1,g2],'BT random','BT IG');
    
    
    subplot(325);
    hold on;
    g1 = plot(Mr3(:,1), Mr3(:,3), 'k-');
    g2 = plot(Mig3(:,1), Mig3(:,3), 'r-');
    xlabel('Feature Size');
    ylabel('Testing Accuracy (%)');

    
    subplot(326);
    hold on;
    g1 = plot(Mr3(:,1), Mr3(:,4), 'k-');
    g2 = plot(Mig3(:,1), Mig3(:,4), 'r-');
    xlabel('Feature Size');
    ylabel('Running Time (s)');
    legend([g1,g2],'RF random','RF IG');    
    
end