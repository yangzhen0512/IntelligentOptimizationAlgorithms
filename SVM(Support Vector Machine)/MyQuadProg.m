function alpha = MyQuadProg( X, Y, kernelType, C, delta)
%使用quadprog函数(matlab自带的) 求解二次规划问题 1/2*x'*H*x + f'*x. H

%X=dim*(num=n)
%Y=1*n

n = size(X, 2);

%算法的选项参数
options = optimset;
options.LargeScale = 'off';
options.Display = 'off';

%使用quadprog函数求解二次规划问题 1/2*x'*H*x + f'*x. H
%二次规划目标x = SVM中的alpha(n*1列向量)
% Q(alpha)的max = 二次规划的min
%基于SVM的入侵检测系统研究_孙钢 P39

%Eq. 3-16
%Y' * Y     = n*n的方阵
%KernelFunc = (num=n)*n的方阵
H=(Y' * Y) .* KernelFunc(X, X, kernelType, delta);%n*n的方阵
f= -ones(n, 1);%n*1列向量

%不存在Ax<=b的约束
A=[];
b=[];

%SVM的约束条件 1) sum(alpha_i*y_i)=0
Aeq = Y;%1*n
beq = 0;%1*1

%SVM的约束条件 2) 0<= alpha_i <= C错分样本的惩罚程度 (Eq. 3-14)
lb = zeros(n, 1);%n*1
ub = C * ones(n, 1);%n*1

a0 = [];
alpha  = quadprog(H,f, A,b, Aeq,beq, lb,ub, a0, options);%二次规划的结果x=SVM的alpha n*1

end

