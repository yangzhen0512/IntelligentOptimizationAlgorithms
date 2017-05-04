function dy = ActiveFuncDerivative( x )
%单个神经元的激活函数的导数
%本例中使用双极S形函数

alpha = 2;
dy = alpha  * (1-ActiveFunc(x)^2) / 2;

end

