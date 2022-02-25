clear all
clc

% dir = 'blobs.txt';
% bounds1 = -1;
% bounds2 = 7;
% deg = 1;

dir = 'spirals.txt';
bounds1 = 2;
bounds2 = 2;
deg = 9;

c = 3;
resolution = 0.03;
fold = 5;
C = 0; % lagrange multiplier, determined using k-fold

C_begin = -6;
C_end = 6;
no_c = 33;
ker = struct('type','ploy','degree',deg,'offset',c);

[x1,x2] = load_data(dir);


[X1,X2] = meshgrid(-bounds1:resolution:bounds2,-bounds1:resolution:bounds2);

Y = [ones(1,length(x1)),ones(1,length(x2))]; 
Cs = logspace(C_begin,C_end,no_c);

tic
% test Cs
for i = 1:no_c
    C = Cs(i);
    scores(i) = split2train(x1,x2,fold,ker,C,X1,X2);
end
toc 
C= Cs(find(scores == max(scores)));
% C = 9;
[i_sv,Yd] = auto_train(x1,x2,ker,C,X1,X2);

plot_svm([x1;x2],X1,X2,i_sv,Yd);

hold off
figure
loglog(Cs,scores)
% title("Lagrange multiplier Vs, Scores for Blobs data")
title("Lagrange multiplier Vs, Scores for Spirals data")
xlabel("Lambda")
ylabel("Scores")
grid on