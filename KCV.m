function [c] = KCV(class0,class1,x0,y0,hyperplane)
x0 = x0(1,:);
y0 = y0(:,1);
c1 = 0;
c2 = 0;

l0 = length(class0);
l1 = length(class1);

for i = 1:l0
    x_now = class0(i,1);
    y_now = class0(i,2);
    [~,ix] = find(abs(x0-x_now)==min(abs((x0-x_now))));
    [iy,~] = find(abs(y0-y_now)==min(abs((y0-y_now))));
    if ix>0&&length(hyperplane)-iy>0
        if hyperplane(ix,length(hyperplane)-iy) == -1
        c1 = c1+1;
        end    
    end

end

for i = 1:l1
    x_now = class1(i,1);
    y_now = class1(i,2);
    [~,ix] = find(abs(x0-x_now)==min(abs((x0-x_now))));
    [iy,~] = find(abs(y0-y_now)==min(abs((y0-y_now))));
    if hyperplane(ix,length(hyperplane)-iy) == 1
        c2 = c2+1;
    end
end

c1 = c1/l0;
c2 = c2/l1;
c = (c1*l0+c2*l1)/(l1+l0);

end