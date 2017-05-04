function selectedIndex = Roulette(values)
%根据values的列表中的值(请确保 值全部为正)
%轮盘赌选择一个目标
%返回该目标在列表中的索引

len = length(values);

%该数组值的和
sum = 0;
for i = 1 : len
    sum = sum + values(i);
end

%从0~sum之间取一个随机值
randomValue = rand(1)*sum;

%找到累计和>=randomValue的数组下标
sum = 0;
for i = 1 : len
    sum = sum + values(i);
    if sum >= randomValue
        selectedIndex = i;
        return;
    end
end

end

