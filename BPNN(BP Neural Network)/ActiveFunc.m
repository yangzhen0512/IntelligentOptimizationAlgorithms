function y = ActiveFunc( x )
%单个神经元的激活函数
%本例中使用双极S形函数 [-1,1]

alpha = 2;

y = 2 / (1+exp(-alpha*x)) - 1;

end

