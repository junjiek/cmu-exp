function plotting(filename)
    M = csvread(filename, 1);
    fig = figure('visible','off');
    subplot(211);
    plot(M(:,1), M(:,2), '-');
    xlabel('TrainingSampleSize');
    ylabel('Cross Validation Accuracy (%)');
    subplot(212);
    plot(M(:,1), M(:,3), '-');
    xlabel('TrainingSampleSize');
    ylabel('Running Time (s)');
    saveas(fig, 'fig', 'png');
end