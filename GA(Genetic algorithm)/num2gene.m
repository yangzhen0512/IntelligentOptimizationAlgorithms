function gene = num2gene( xInput )
%将xInput的数 转换为 12位的基因编码(6位整数部分+6位小数部分)
gene = zeros(12, 1);

x = floor( xInput*1000*1000 );%保留6位小数 然后取整

ret = mod(x, 10);
for i = 1: 1: 12
    gene(i) = ret;
    x = floor( (x-ret)/10 );
    ret = mod(x, 10);
end

end

