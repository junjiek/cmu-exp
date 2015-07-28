function bin_compare3(id)
    % random/ig/chi or t
        
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

    
    Mchi1 = csvread(sprintf('./output/%s/chi/liblinear_%s.out',id,id), 1);
    Mchi2 = csvread(sprintf('./output/%s/chi/fest_boosting_%s.out',id,id), 1);
    Mchi3 = csvread(sprintf('./output/%s/chi/fest_randomforest_%s.out',id,id), 1);
    Mchi1=sort(Mchi1(:,:));
    Mchi2=sort(Mchi2(:,:));
    Mchi3=sort(Mchi3(:,:));
    
    % Mt1 = csvread(sprintf('./output/%s/t/liblinear_%s.out',id,id), 1);
    % Mt2 = csvread(sprintf('./output/%s/t/fest_boosting_%s.out',id,id), 1);
    % Mt3 = csvread(sprintf('./output/%s/t/fest_randomforest_%s.out',id,id), 1);
    % Mt1=sort(Mt1(:,:));
    % Mt2=sort(Mt2(:,:));
    % Mt3=sort(Mt3(:,:));
    
    figure();
    subplot(321);
    hold on;
    g1 = plot(Mr1(:,1), Mr1(:,3), 'k-');
    g2 = plot(Mig1(:,1), Mig1(:,3), '-');
    g3 = plot(Mchi1(:,1), Mchi1(:,3), 'r-');
    xlabel('Feature Size');
    ylabel('Testing Accuracy (%)');

    subplot(322);
    hold on;
    g1 = plot(Mr1(:,1), Mr1(:,4), 'k-');
    g2 = plot(Mig1(:,1), Mig1(:,6), '-');
    g3 = plot(Mchi1(:,1), Mchi1(:,6), 'r-');
    xlabel('Feature Size');
    ylabel('Running Time (s)');
    legend([g1,g2,g3],'liblinear random','liblinear IG', 'liblinear CHI^2');
    
    subplot(323);
    hold on;
    g1 = plot(Mr2(:,1), Mr2(:,3), 'k-');
    g2 = plot(Mig2(:,1), Mig2(:,3), '-');
    g3 = plot(Mchi2(:,1), Mchi2(:,3), 'r-');
    xlabel('Feature Size');
    ylabel('Testing Accuracy (%)');

    subplot(324);
    hold on;
    g1 = plot(Mr2(:,1), Mr2(:,4), 'k-');
    g2 = plot(Mig2(:,1), Mig2(:,4), '-');
    g3 = plot(Mchi2(:,1), Mchi2(:,4), 'r-');
    xlabel('Feature Size');
    ylabel('Running Time (s)');
    
    legend([g1,g2,g3],'BT random','BT IG', 'BT CHI^2');
    
    
    subplot(325);
    hold on;
    g1 = plot(Mr3(:,1), Mr3(:,3), 'k-');
    g2 = plot(Mig3(:,1), Mig3(:,3), '-');
    g3 = plot(Mchi3(:,1), Mchi3(:,3), 'r-');
    xlabel('Feature Size');
    ylabel('Testing Accuracy (%)');

    
    subplot(326);
    hold on;
    g1 = plot(Mr3(:,1), Mr3(:,4), 'k-');
    g2 = plot(Mig3(:,1), Mig3(:,4), '-');
    g3 = plot(Mchi3(:,1), Mchi3(:,4), 'r-');
    xlabel('Feature Size');
    ylabel('Running Time (s)');
    legend([g1,g2,g3],'RF random','RF IG', 'RF CHI^2');    
    
end