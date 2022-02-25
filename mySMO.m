function [w,b] = mySMO(x,y)
%SVM
% one vs.one
%x = (dimen , N)
%      y = (1,N)
%
global C tr 
N = 2*tr;
a = zeros(N,1);
k = 0;
b = 0;
epison = 0;% 10^-6;
E = zeros(N,1);
s = 1;
while 1
    s
    sign = 1;

    for i=1:N
        g = 0;
        for index_j = 1:N
            g = g + a(index_j)*y(index_j)*x(:,i)'*x(:,index_j);
        end
        g = g + b;
        E(i) = g - y(i);
    end
    
    for i=1:N

        % find the first a_i violates KKT
        g = E(i) + y(i);
        if a(i) <= epison
            if y(i)*g >= 1
                continue;
            end
        elseif (0 + epison) <a(i) && a(i) < (C - epison)
            if y(i)*g == 1
                continue;
            end
        else
            if y(i)*g <= 1
                continue;
            end
        end
        %KKKT violated

        E1 = E(i);
        sign = 0;
        if E1<0
            [~,index] = max(E);
        else
            [~,index] = min(E);
        end
        if index == i
            continue;end;
        a1old = a(i);
        %update E2
        E2 = E(index);
        %update a2
        a2old = a(index);
        a(index) = a(index) + (y(index)*(E1-E2))/(norm(x(:,i)-x(:,index),2))^2;

        if y(i) ~= y(index)
            L = max(0,a2old-a1old);
            H = min(C,C+a2old-a1old);
        else
            L = max(0,a2old+a1old-C);
            H = min(C,a2old+a1old);
        end
        if a(index) > H
            a(index) = H;
        elseif a(index) < L
            a(index) = L;
        end

        y1 = y(i);
        y2 = y(index);
        % update a1
        a(i) = a(i) + y1*y2*(a2old - a(index));
        % update b
        b1 = -E1 - y1*(x(:,i)'*x(:,i))*(a(i)-a1old)-y2*(x(:,index)'*x(:,i))*(a(index)- a2old) + b;
        b2 = -E2 - y1*(x(:,i)'*x(:,index))*(a(i)-a1old)-y2*(x(:,index)'*x(:,index))*(a(index)- a2old) + b;
        
        if b1==b2
            b = b1;
        else b = (b1+b2)/2;
        end
    end
    if sign ==1
        break;
    end
    s= s+1;
end
w = zeros(size(x(1)));
q = 0;
for i=1:N
    w = w + a(i)*y(i)*x(i);
    q = q + a(i)*y(i)*x(i)'*x(i);
end
for i=1:N
    if (0 + epison) <a(i) && a(i) < (C - epison)
        b = y(i) - q;
        break
    end    
end

        
            
            