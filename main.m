clear all
clc

% dir = 'blobs.txt';
% bounds1 = -1;
% bounds2 = 7;
% deg = 1;

% dir = 'spirals.txt';
% bounds1 = 2;
% bounds2 = 2;
% deg = 9;

% dir = 'sunflower_rose.txt';
% [X1,X2] = meshgrid(0.01:0.01:6,0.01:0.01:2);
% deg = 1;
% 
% dir = 'Setosa_Versicolor.txt';
% [X1,X2] = meshgrid(4:0.01:8,1:0.01:5);
% deg = 1;

dir = 'age_education.txt';
[X1,X2] = meshgrid(4:0.01:8,1:0.01:5);
deg = 1;

% T = readtable('iris.csv');
% label = T(:,5);
% T(:,5) = [];
% data = table2array(T);
% label= table2array(label);
% c1 = data(1:50,:);
% c2 = data(51:100,:);
% c3 = data(101:150,:);
% 
% plot(c1(:,1),c1(:,2),'b*')
% hold on
% plot(c2(:,1),c2(:,2),'g*')

c = 3;
resolution = 0.01;
fold = 5;
C = 1; % lagrange multiplier, determined using k-fold

C_begin = -6;
C_end = 6;
no_c = 33;
ker = struct('type','ploy','degree',deg,'offset',c);

[x1,x2] = load_data(dir);
% plot(x1(:,1),x1(:,2),'b*');
% hold on
% plot(x2(:,1),x2(:,2),'g*');
% [X1,X2] = meshgrid(-bounds1:resolution:bounds2,-bounds1:resolution:bounds2);

Y = [ones(1,length(x1)),ones(1,length(x2))]; 
Cs = logspace(C_begin,C_end,no_c);

tic
% test Cs
% for i = 1:no_c
%     C = Cs(i);
%     scores(i) = split2train(x1,x2,fold,ker,C,X1,X2);
% end
toc 
% C= Cs(find(scores == max(scores)));
C = 1;
[i_sv,Yd] = auto_train(x1,x2,ker,C,X1,X2);

plot_svm([x1;x2],X1,X2,i_sv,Yd);

% hold off
% figure
% loglog(Cs,scores+0.3)
% % title("Lagrange multiplier Vs, Scores for Blobs data")
% title("Lagrange multiplier Vs, Scores for Spirals data")
% xlabel("Lambda")
% ylabel("Scores")
% grid on