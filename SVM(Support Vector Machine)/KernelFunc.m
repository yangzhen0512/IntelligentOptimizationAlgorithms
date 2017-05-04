function Kernel = KernelFunc(Xi ,X, kernelType, delta)
%核函数的计算

%Xi=dim*num(可以num个Xi一起输入)
%X=dim*n
%Kernel=num*n

%不同种类的核函数
switch kernelType
case 'linear'
    Kernel = Xi' * X;
case 'RBF'
    num = size(Xi, 2);
    n   = size(X,  2);
    
    %计算|x-xi|^2的矩阵形式
    X2 = sum(X' .* X', 2);%每行求和 n*1
    Xi2 = sum(Xi' .* Xi', 2);%每行求和 num*1
    XiX = Xi'*X;%num*n
    tmp = abs( repmat(Xi2,[1 n]) + repmat(X2', [num 1]) - 2*XiX );%num*n
    
    delta2 = delta^2;
    Kernel = exp(-tmp ./ delta2);
end

end

