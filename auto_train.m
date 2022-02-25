function [i_sv,Yd] = auto_train(x1,x2,ker,C,X1,X2)

L=[x1;x2];
X=L';
y1 = ones(1,length(x1));
y2 = -ones(1,length(x2));
Y = [y1,y2]; 

svm = svmTrain('svc_c',X,Y,ker,C);
a = svm.a;
epsilon = 1e-8;  
i_sv = find(abs(a)>epsilon);

[rows,cols] = size(X1);
nt = rows*cols ; 
Xt = [reshape(X1,1,nt);reshape(X2,1,nt)];
Yd = svmSim(svm,Xt);      
Yd = reshape(Yd,rows,cols);
end