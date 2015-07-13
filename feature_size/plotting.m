% function plotting(filename)
M1 = csvread('liblinear.out', 1);
M2 = csvread('adaboost.out', 1);
M3 = csvread('multiboost.out', 1);
fig = figure();
subplot(211);
hold on;
% plot(M1(:,1), M1(:,3), '-');
% plot(M2(:,1), M2(:,3), 'r-');
plot(M3(:,1), M3(:,3), 'g-');
xlabel('Feature Size');
ylabel('Testing Accuracy (%)');
subplot(212);
hold on;
% plot(M1(:,1), M1(:,4), '-');
% plot(M2(:,1), M2(:,4), 'r-');
plot(M3(:,1), M3(:,4), 'g-');
xlabel('Feature Size');
ylabel('Running Time (s)');
saveas(fig, 'fig', 'png');
% end