function num = gene2num( gene )
%12位的基因编码(6位整数部分+6位小数部分) 转换为 一个数

num = 0;
for i = 1: 1: 12
	num = num + gene(i)*10^(i-7);
end

if num<15 || num >25%交叉后的后代的x越界 随机赋值
    num = 15 + 10*rand(1, 1);
end


end

