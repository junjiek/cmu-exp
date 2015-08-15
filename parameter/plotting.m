function plotting(id)
    M16 = csvread(sprintf('./fest_rf_%s_16.out',id), 1);
    M32 = csvread(sprintf('./fest_rf_%s_32.out',id), 1);
    M64 = csvread(sprintf('./fest_rf_%s_64.out',id), 1);
    M128 = csvread(sprintf('./fest_rf_%s_128.out',id), 1);
    M256 = csvread(sprintf('./fest_rf_%s_256.out',id), 1);
    M512 = csvread(sprintf('./fest_rf_%s_512.out',id), 1);
    M1024 = csvread(sprintf('./fest_rf_%s_1024.out',id), 1);

    M16 = sort(M16(:,:));
    M32 = sort(M32(:,:));
    M64 = sort(M64(:,:));
    M128 = sort(M128(:,:));
    M256 = sort(M256(:,:));
    M512 = sort(M512(:,:));
    M1024 = sort(M1024(:,:));

    figure();
    title(id);
    hold on;
    g1 = plot(M16(:,1), M16(:,4), '-');
    g2 = plot(M32(:,1), M32(:,4), 'r-');
    g3 = plot(M64(:,1), M64(:,4), 'g-');
    g4 = plot(M128(:,1), M128(:,4), 'k-');
    g5 = plot(M256(:,1), M256(:,4), 'm-');
    g6 = plot(M512(:,1), M512(:,4), 'y-');
    g7 = plot(M1024(:,1), M1024(:,4), 'c-');
    legend([g1,g2,g3,g4,g5,g6,g7],'16','32','64','128','256','512','1024');
    xlabel('Feature Size');
    ylabel('Micro-F');

    figure();
    hold on;
    g1 = plot(M16(:,1), M16(:,5), '-');
    g2 = plot(M32(:,1), M32(:,5), 'r-');
    g3 = plot(M64(:,1), M64(:,5), 'g-');
    g4 = plot(M128(:,1), M128(:,5), 'k-');
    g5 = plot(M256(:,1), M256(:,5), 'm-');
    g6 = plot(M512(:,1), M512(:,5), 'y-');
    g7 = plot(M1024(:,1), M1024(:,5), 'c-');
    legend([g1,g2,g3,g4,g5,g6,g7],'16','32','64','128','256','512','1024');
    xlabel('Feature Size');
    ylabel('Macro-F');

    figure();
    hold on;
    g1 = plot(M16(:,1), M16(:,6), '-');
    g2 = plot(M32(:,1), M32(:,6), 'r-');
    g3 = plot(M64(:,1), M64(:,6), 'g-');
    g4 = plot(M128(:,1), M128(:,6), 'k-');
    g5 = plot(M256(:,1), M256(:,6), 'm-');
    g6 = plot(M512(:,1), M512(:,6), 'y-');
    g7 = plot(M1024(:,1), M1024(:,6), 'c-');
    legend([g1,g2,g3,g4,g5,g6,g7],'16','32','64','128','256','512','1024');
    xlabel('Feature Size');
    ylabel('Running Time (s)');

    figure();
    subplot(131);
    x = [16,32,64,128,256,512,1024];
    y = [M16(20,4),M32(20,4),M64(20,4),M128(20,4),M256(20,4),M512(20,4),M1024(20,4)];
    plot(x,y)
    xlabel('Tree Number')
    ylabel('Micro-F')
   subplot(132);
    x = [16,32,64,128,256,512,1024];
    y = [M16(20,5),M32(20,5),M64(20,5),M128(20,5),M256(20,5),M512(20,5),M1024(20,5)];
    plot(x,y)
    xlabel('Tree Number')
    ylabel('Macro-F')
    subplot(133);
    x = [16,32,64,128,256,512,1024];
    y = [M16(20,6),M32(20,6),M64(20,6),M128(20,6),M256(20,6),M512(20,6),M1024(20,6)];
    plot(x,y)
    xlabel('Tree Number')
    ylabel('Running Time')
end

