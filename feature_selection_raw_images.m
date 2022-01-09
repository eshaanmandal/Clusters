clc, close, clear;

load catData.mat;
load dogData.mat;


CD = double([dog cat]);
[U,S,V] = svd(CD-mean(CD(:)),'econ');
figure(1);
for i=1:4
    subplot(2,2,i);
    u = flipud(reshape(U(:,i),64,64));
    u = u(1:2:64, 1:2:64);
    pcolor(u);
    colormap("hot")
    axis('off');
end

figure(2);
% traits in the plots
for i=1:4
    subplot(4,1,i), bar(V(:,i));
end

figure(3);
for i=1:4
    subplot(4,1,i);
    [values, edges] = histcounts(V(1:80,i));
    centers = (edges(1:end-1)+edges(2:end))/2;
    plot(centers, values)
    hold on;
    [values, edges] = histcounts(V(80:160,i));
    centers = (edges(1:end-1)+edges(2:end))/2;
    plot(centers, values)
    hold off;
end

figure(4);
plot3(V(1:80,1), V(1:80,2), V(1:80,3),'ro','MarkerSize',8,...
    'MarkerFaceColor',[1 0 0]);
hold on;
plot3(V(81:160,1), V(81:160,2), V(81:160,3),'go','MarkerSize',8,...
    'MarkerFaceColor',[0 1 0]);
hold off;
grid;