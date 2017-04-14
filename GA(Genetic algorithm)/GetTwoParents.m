function parents = GetTwoParents( fitness )
%根据适应度值 轮盘赌法 获取两个母本
%(适应度大的 较大的概率被选为母本=生物遗传中的适者生存)

%返回母本的两个编号 组成一行
parents = zeros(1, 2);

num = size(fitness, 1);
sum = 0;%适应值总和
for i = 1: 1: num
    sum = sum + fitness(i,2);
end

%轮盘赌 确定两个母本
randomValue = rand(1, 2);
possibility = randomValue .* sum;
for parentNum = 1: 1: 2%两个母本
    tmpSum = 0;
    for i = 1: 1: num
        tmpSum = tmpSum + fitness(i,2);
        if tmpSum >= possibility(parentNum)
            parents(parentNum) = fitness(i,1);%母本编号
            break;
        end
    end 
end

end
