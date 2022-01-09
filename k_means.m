clc, close, clear;

n1 = 150;
n2 = 50;
theta = pi/4;
R = [cos(theta) -sin(theta); sin(theta) cos(theta)];
%% defining the dataset (clusters)
x1 = randn(n1+n2,1)-2;
y1 = 0.3*randn(n1+n2,1)+1;

x2 = randn(n1+n2,1);
y2 = 0.5*randn(n1+n2,1);
x3 = R(1,1)*x2 + R(1,2)*y2;
y3 = R(2,1)*(x2) + R(2,2)*y2;

figure;
subplot(4,3,2);
plot(x1,y1,'ro','MarkerSize',6,'MarkerFaceColor',[1 0 0]);
hold on
plot(x3,y3,'go','MarkerSize',6,'MarkerFaceColor',[0 1 0]);
title('Original data');
xlabel('x');
ylabel('y');
hold off;

%% generating training data
X1 = [x1(1:n1) y1(1:n1)];
X2 = [x3(1:n1) y3(1:n1)];
Y = [X1;X2];
% test data
x1test = [x1(n1+1:end) y1(n1+1:end)];
x2test = [x3(n1+1:end) y3(n1+1:end)];
Y_test = [x1test; x2test];

%% K-means algorithm
% initial guess
% Two guesses becuase we want 2 clusters
g1 = [randn(1,1)*max(x1) randn(1,1)*max(y1)];
g2 = [randn(1,1)*max(x3) randn(1,1)*max(y3)];

for i=1:9
    class1 = [];
    class2 = [];
    for j=1:size(Y,1)
        d1 = norm(g1 - Y(j,:));
        d2 = norm(g2 - Y(j,:));
        if d1<d2
            class1 = [class1; Y(j,1) Y(j,2)];
        else
            class2 = [class2; Y(j,1) Y(j,2)];
        end
       
    end
    g1 = [mean(class1(:,1)) mean(class1(:,2))];
    g2 = [mean(class2(:,1)) mean(class2(:,2))];

    subplot(4,3,i+3);
    plot(class1(:,1),class1(:,2),'ro','MarkerSize',6,'MarkerFaceColor',[1 0 0]);
    hold on
    plot(class2(:,1),class2(:,2),'go','MarkerSize',6,'MarkerFaceColor',[0 1 0]);
    plot(g1(1), g1(2),'bo','MarkerSize',6,'MarkerFaceColor',[0 0 1]);
    plot(g2(1), g2(2),'bo','MarkerSize',6,'MarkerFaceColor',[0 0 1]);
    title('Iteration',i);
    xlabel('x');
    ylabel('y');
    hold off;
end




