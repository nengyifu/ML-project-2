function Yd = svmSim(svm,Xt)
% 
% svm 
% the following fields:
%   type -  {'svc_c','svc_nu','svm_one_class','svr_epsilon','svr_nu'}
%   ker - 
%       type   - linear :  k(x,y) = x'*y
%                poly   :  k(x,y) = (x'*y+c)^d
%                gauss  :  k(x,y) = exp(-0.5*(norm(x-y)/s)^2)
%                tanh   :  k(x,y) = tanh(g*x'*y+c)
%       degree - Degree d of polynomial kernel (positive scalar).
%       offset - Offset c of polynomial and tanh kernel (scalar, negative for tanh).
%       width  - Width s of Gauss kernel (positive scalar).
%       gamma  - Slope g of the tanh kernel (positive scalar).
%
% ------------------------------------------------------------%

type = svm.type;
ker = svm.ker;
X = svm.x;
Y = svm.y;
a = svm.a;

% ------------------------------------------------------------%

epsilon = 1e-8;                
i_sv = find(abs(a)>epsilon);    

switch type
    case 'svc_c',
        
        tmp = (a.*Y)*kernel(ker,X,X(:,i_sv));    
        b = 1./Y(i_sv)-tmp;
        b = mean(b);
        tmp =  (a.*Y)*kernel(ker,X,Xt);
        Yd = sign(tmp+b);
        
    case 'svc_nu', 
        %------------------------------------%


        tmp = (a.*Y)*kernel(ker,X,X(:,i_sv));  
        b = 1./Y(i_sv)-tmp;
        b = mean(b);
        tmp =  (a.*Y)*kernel(ker,X,Xt);
        Yd = sign(tmp+b);
        
    case 'svm_one_class',
        
        n_sv = length(i_sv);
        tmp1 = zeros(n_sv,1);
        for i = 1:n_sv
            index = i_sv(i);
            tmp1(i) = kernel(ker,X(:,index),X(:,index));
        end

        tmp2 = 2*a*kernel(ker,X,X(:,i_sv));         
        tmp3 = sum(sum(a'*a.*kernel(ker,X,X)));    

        R_square = tmp1-tmp2'+tmp3;
        R_square = mean(R_square);                     

        nt = size(Xt,2);                 

        tmp4 = zeros(nt,1);              
        for i = 1:nt
            tmp4(i) = kernel(ker,Xt(:,i),Xt(:,i));
        end
    
        tmp5 = 2*a*kernel(ker,X,Xt);          
        Yd = sign(tmp4-tmp5'+tmp3-R_square);

    case 'svr_epsilon',
        
        tmp = a*kernel(ker,X,X(:,i_sv));  
        b = Y(i_sv)-tmp;                    
        %b = Y(i_sv)+tmp;
        b = mean(b);

        tmp =  a*kernel(ker,X,Xt);        
        %tmp =  -a*kernel(ker,X,Xt);
        Yd = (tmp+b);        
        
    case 'svr_nu',
        %------------------------------------%
        % ”Î'svr_epsilon' 
        
        tmp = a*kernel(ker,X,X(:,i_sv));   
        b = Y(i_sv)-tmp;                  
        %b = Y(i_sv)+tmp;
        b = mean(b);

        tmp =  a*kernel(ker,X,Xt);        
        %tmp =  -a*kernel(ker,X,Xt);
        Yd = (tmp+b);        
        
    otherwise,
end