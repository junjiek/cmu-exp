function mul_cmp3(id)
    % random/ig/chi or t
        
    Mr1 = csvread(sprintf('./output/%s/r/liblinear_%s.out',id,id), 1);
    Mr2 = csvread(sprintf('./output/%s/r/fest_boosting_%s.out',id,id), 1);
    Mr3 = csvread(sprintf('./output/%s/r/fest_randomforest_%s.out',id,id), 1);
    Mr4 = csvread(sprintf('./output/%s/r/sk_randomforest_%s.out',id,id), 1);
    Mr1=sort(Mr1(:,:));
    Mr2=sort(Mr2(:,:));
    Mr3=sort(Mr3(:,:));
    Mr4=sort(Mr4(:,:));

    Mig1 = csvread(sprintf('./output/%s/ig/liblinear_%s.out',id,id), 1);
    Mig2 = csvread(sprintf('./output/%s/ig/fest_boosting_%s.out',id,id), 1);
    Mig3 = csvread(sprintf('./output/%s/ig/fest_randomforest_%s.out',id,id), 1);
    Mig4 = csvread(sprintf('./output/%s/ig/sk_randomforest_%s.out',id,id), 1);
    Mig1=sort(Mig1(:,:));
    Mig2=sort(Mig2(:,:));
    Mig3=sort(Mig3(:,:));
    Mig4=sort(Mig4(:,:));

    
    Mchi1 = csvread(sprintf('./output/%s/chi/liblinear_%s.out',id,id), 1);
    Mchi2 = csvread(sprintf('./output/%s/chi/fest_boosting_%s.out',id,id), 1);
    Mchi3 = csvread(sprintf('./output/%s/chi/fest_randomforest_%s.out',id,id), 1);
    Mchi4 = csvread(sprintf('./output/%s/chi/sk_randomforest_%s.out',id,id), 1);
    Mchi1=sort(Mchi1(:,:));
    Mchi2=sort(Mchi2(:,:));
    Mchi3=sort(Mchi3(:,:));
    Mchi4=sort(Mchi4(:,:));
    
    figure();
    subplot(431);
    hold on;
    g1 = plot(Mr1(:,1), Mr1(:,4), 'g-');
    g2 = plot(Mig1(:,1), Mig1(:,4), '-');
    g3 = plot(Mchi1(:,1), Mchi1(:,4), 'r-');
    xlabel('Feature Size');
    ylabel('Micro-F');

    subplot(432);
    hold on;
    g1 = plot(Mr1(:,1), Mr1(:,5), 'g-');
    g2 = plot(Mig1(:,1), Mig1(:,5), '-');
    g3 = plot(Mchi1(:,1), Mchi1(:,5), 'r-');
    xlabel('Feature Size');
    ylabel('Macro-F');

    subplot(433);
    hold on;
    g1 = plot(Mr1(:,1), Mr1(:,6), 'g-');
    g2 = plot(Mig1(:,1), Mig1(:,6), '-');
    g3 = plot(Mchi1(:,1), Mchi1(:,6), 'r-');
    xlabel('Feature Size');
    ylabel('Running Time (s)');
    legend([g1,g2,g3],'liblinear random','liblinear IG', 'liblinear CHI^2');
    
    % FEST Boosting Tree
    subplot(434);
    hold on;
    g1 = plot(Mr2(:,1), Mr2(:,4), 'g-');
    g2 = plot(Mig2(:,1), Mig2(:,4), '-');
    g3 = plot(Mchi2(:,1), Mchi2(:,4), 'r-');
    xlabel('Feature Size');
    ylabel('Micro-F');

    subplot(435);
    hold on;
    g1 = plot(Mr2(:,1), Mr2(:,5), 'g-');
    g2 = plot(Mig2(:,1), Mig2(:,5), '-');
    g3 = plot(Mchi2(:,1), Mchi2(:,5), 'r-');
    xlabel('Feature Size');
    ylabel('Macro-F');

    subplot(436);
    hold on;
    g1 = plot(Mr2(:,1), Mr2(:,6), 'g-');
    g2 = plot(Mig2(:,1), Mig2(:,6), '-');
    g3 = plot(Mchi2(:,1), Mchi2(:,6), 'r-');
    xlabel('Feature Size');
    ylabel('Running Time (s)');
    legend([g1,g2,g3],'FEST BT random','FEST BT IG', 'FEST BT CHI^2');
    
    % FEST Random Forest
    subplot(437);
    hold on;
    g1 = plot(Mr3(:,1), Mr3(:,4), 'g-');
    g2 = plot(Mig3(:,1), Mig3(:,4), '-');
    g3 = plot(Mchi3(:,1), Mchi3(:,4), 'r-');
    xlabel('Feature Size');
    ylabel('Micro-F');

    subplot(438);
    hold on;
    g1 = plot(Mr3(:,1), Mr3(:,5), 'g-');
    g2 = plot(Mig3(:,1), Mig3(:,5), '-');
    g3 = plot(Mchi3(:,1), Mchi3(:,5), 'r-');
    xlabel('Feature Size');
    ylabel('Macro-F');
    
    subplot(439);
    hold on;
    g1 = plot(Mr3(:,1), Mr3(:,6), 'g-');
    g2 = plot(Mig3(:,1), Mig3(:,6), '-');
    g3 = plot(Mchi3(:,1), Mchi3(:,6), 'r-');
    xlabel('Feature Size');
    ylabel('Running Time (s)');
    legend([g1,g2,g3],'FEST RF random','FEST RF IG', 'FEST RF CHI^2');    
    
    % Scikit-learn Random Forest
    subplot(4,3,10);
    hold on;
    g1 = plot(Mr4(:,1), Mr4(:,4), 'g-');
    g2 = plot(Mig4(:,1), Mig4(:,4), '-');
    g3 = plot(Mchi4(:,1), Mchi4(:,4), 'r-');
    xlabel('Feature Size');
    ylabel('Micro-F');

    subplot(4,3,11);
    hold on;
    g1 = plot(Mr4(:,1), Mr4(:,5), 'g-');
    g2 = plot(Mig4(:,1), Mig4(:,5), '-');
    g3 = plot(Mchi4(:,1), Mchi4(:,5), 'r-');
    xlabel('Feature Size');
    ylabel('Macro-F');
    
    subplot(4,3,12);
    hold on;
    g1 = plot(Mr4(:,1), Mr4(:,6), 'g-');
    g2 = plot(Mig4(:,1), Mig4(:,6), '-');
    g3 = plot(Mchi4(:,1), Mchi4(:,6), 'r-');
    xlabel('Feature Size');
    ylabel('Running Time (s)');
    legend([g1,g2,g3],'sk RF random','sk RF IG', 'sk RF CHI^2');    
end