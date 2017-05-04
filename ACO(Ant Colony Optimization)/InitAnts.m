function ants = InitAnts(citiesNum)
%初始化蚁群: 每只蚂蚁的位置+到达过的城市+当前的目的地+到达过城市的路径的长度

antsNum = 30;
ants.location = zeros(antsNum, 1);%每只蚂蚁的当前位置
ants.cities = zeros(antsNum, citiesNum);%每行=一只蚂蚁 记录该蚂蚁到达过的城市
ants.destination = zeros(antsNum, 1);%每只蚂蚁选择的目的地
ants.length = zeros(antsNum, 1);%每只蚂蚁已经过的城市的路径长度

for i = 1: antsNum%每只蚂蚁 随机设定起始位置
    startCity = round( rand(1)*(citiesNum-1) ) + 1;%(0~num-1)+1=下标从1开始
    
    ants.location(i) = startCity;
    ants.cities(i, startCity) = 1;%经过的第一个城市
    ants.destination(i) = startCity;
    ants.length(i) = 0;
end

end

