function z = FuncCalculate( x, y )
%输入函数的x y(可以是x的列向量+y的列向量)
%输出函数的z

z= 3*(1-x).^2 .* exp(-(x.^2) - (y+1).^2) ... 
   - 10*(x/5 - x.^3 - y.^5) .* exp(-x.^2-y.^2) ... 
   - 1/3 * exp(-(x+1).^2 - y.^2);

end

