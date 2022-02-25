function [i_sv,Yd] = auto_train(x1,x2,ker,C,X1,X2)

L=[x1;x2];
X=L';
y1 = ones(1,length(x1));
y2 = -ones(1,length(x2));
Y = [y1,y2]; 

svm = svmTrain('svc_c',X,Y,ker,C);
a = svm.a;
epsilon = 1e-8;   % 如果小于此值则认为是0
i_sv = find(abs(a)>epsilon);       % 支持向量下标

[rows,cols] = size(X1);
nt = rows*cols ;  % 高维测试样本数
Xt = [reshape(X1,1,nt);reshape(X2,1,nt)]; % 高维转化到低维
Yd = svmSim(svm,Xt);      % 测试输出
Yd = reshape(Yd,rows,cols);
end