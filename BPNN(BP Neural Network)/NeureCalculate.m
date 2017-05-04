function [fx, sum] = NeureCalculate(neure, input)
%根据 单个神经元neure自身的权重 和 该神经元的输入向量input
%计算 单个神经元的激活输出output

%检查维数
lenInput = length(input);
lenNeure = length(neure.input);
if lenInput ~= lenNeure
    disp(['error dim for input/neure.input=', num2str(lenInput), '/', num2str(lenNeure)]);
    return;
end

%求和净输入
sum = 0;
for i = 1: lenInput%对于每个输入
    sum = sum + input(i)*neure.weight(i);%输入i*权重i
end
% if length(neure.weight) == lenInput+1%偏置神经元x0=-1
%     sum = sum - neure.weight(lenInput+1);
% end

%激活函数后的输出fx
fx = ActiveFunc(sum);

end

