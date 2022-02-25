function [score] = split2train(class0,class1,fold,ker,C,X1,X2)
case1 = length(class0);
case2 = length(class1);

len1 = floor(case1/fold);
len2 = floor(case2/fold);

Begin1 = 1;
End1 = len1;

Begin2 = 1;
End2 = len2;

score = 0;
for i = 1:fold
    class0_test = class0(Begin1:End1,:);
    class1_test = class1(Begin2:End2,:);
    
    class0_train = [class0(1:Begin1,:);class0(End1:end,:)];
    class1_train = [class1(1:Begin2,:);class1(End2:end,:)];
    
    [i_sv,Yd] = auto_train(class0_train,class1_train,ker,C,X1,X2);
    score = score + KCV(class0_test,class1_test,X1,X2,Yd)/fold;

    Begin1 = Begin1 + len1;
    End1 = End1 + len1;
    
    Begin2 = Begin2 + len2;
    End2 = End2 + len2;
end


end