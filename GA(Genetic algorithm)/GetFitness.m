function fitness = GetFitness( individual )
%计算个体的适应度

[r, c] = size(individual);
fitness = zeros(r, c);
for i = 1: 1: r
    fitness(i, 1) = i;%个体编号
    
    x = individual(i,2);%该个体所对应的坐标x
    fitness(i, 2) = x+10*sin(5*x)+7*cos(4*x);%适应度=函数值
end

end

