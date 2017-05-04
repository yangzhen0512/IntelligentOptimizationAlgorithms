%蚁群算法求解旅行商问题TSP
clc; clear all; close;

%一些迭代循环的次数
optimalizeTimes = 2;%蚁群算法重置开始的次数(多次重新开始蚁群算法 寻找最短路径的解)
cycle = 100;%所有城市均经过的循环次数

%初始化环境 = 城市位置+路径长度和信息素浓度
cities = InitCities();%每行=一个城市的坐标
citiesNum = size(cities, 1);
pathes = InitPath(cities);%包含城市间的长度length和信息素pheromone
PlotCities(cities);

%初始化蚁群
%location(i)=第i只蚂蚁的当前位置
%cities(i,:)=第i只蚂蚁到达过的城市(值=该城市到达的顺序)
%destination(i)=第i只蚂蚁选择的目的地
%length(i)=第i只蚂蚁经过的城市的路径长度
ants = InitAnts(citiesNum);%每行=一只蚂蚁 记录该蚂蚁的当前位置location和到达过的城市cities
antsNum = size(ants.location, 1);
secretedPheromone = 2;%每只蚂蚁 每次在城市间运动 所能遗留的信息素的量
searchRange = 10;%每只蚂蚁 所能观察到/搜索的范围

%记录TSP的最佳结果
%在optimalizeTimes循环中被优化
optimalTspResultIndex = [];
optimalTspResultLength = 100000;



for optimalIndex = 1: optimalizeTimes
    %重新开始TSP实验 清空路径上的信息素
    %多次重新开始蚁群算法 寻找最短路径的解
    %Step1: 初始化环境
    pathes = InitPath(cities);
    
    for cycleIndex = 1: cycle%每轮遍历所有城市
        %所有城市遍历一次后 重置蚁群状态
        %Step2: 初始化蚁群
        ants = InitAnts(citiesNum);%RestoreAnts(ants);

        %loop: 遍历所有城市
        %loop从2开始(1=第一次运动 设定起点城市)
        %到citiesNum+1结束(citiesNum+1=最后一次运动 回到起点城市)
        loopTimes = citiesNum + 1;
        for loopIndex = 2: loopTimes%每个loop经过一个城市
            %Step3: 每只蚂蚁 根据信息素选择目的地城市(从未到达过的城市中选择)
            if loopIndex ~= loopTimes
                 %从当前位置nowLocation---在没有到达过的城市中notReachedCities
                 %依据地图上的信息素分布---选择一个目的地
                for antsIndex = 1: antsNum%每只蚂蚁
                    nowLocation = ants.location(antsIndex);%当前所在城市的索引
                    notReachedCities = FindNotReachedCities(ants, antsIndex, pathes, searchRange);%未经过的城市的索引列表
                    ants.destination(antsIndex) = SelectDestination(nowLocation, notReachedCities, pathes);
                end
            else%最后一次 所有城市均到达过 回到起点城市
                for antsIndex = 1: antsNum%每只蚂蚁
                    ants.destination(antsIndex) = FindStartCity(ants, antsIndex);
                end
            end

            %Step4: 每只蚂蚁 前往目的地, 同时更新pathes上的信息素分布
            for antsIndex = 1: antsNum%每只蚂蚁
                nowLocation = ants.location(antsIndex);%当前所在的城市
                destination = ants.destination(antsIndex);%目的地城市

                %蚂蚁移动
                if loopIndex ~= loopTimes%不是最后一次(回到起点城市 不需要记录)
                    ants.cities(antsIndex, destination) = loopIndex;%记录是第几个经过的城市=rem(loopIndex, loopTimes)
                end
                ants.location(antsIndex) = destination;
                movingLength = pathes.length(nowLocation, destination);
                ants.length(antsIndex) = ants.length(antsIndex) + movingLength;

                %更新地图上的信息素分布(每轮蚂蚁走一个城市 新增的信息素浓度=分泌的信息素/城市间的距离)
                nowPheromone = pathes.pheromone(nowLocation, destination);
                incPheromone = secretedPheromone / movingLength;%该蚂蚁运动所增加的信息素浓度
                pathes.pheromone(nowLocation, destination) = nowPheromone + incPheromone;
            end

            %Step5: pathes上的信息素挥发
            for i = 1: citiesNum
                for j = 1: citiesNum
                    nowPheromone = pathes.pheromone(i, j);
                    pathes.pheromone(i,j) = nowPheromone*0.95;
                end
            end
        end%蚁群遍历所有城市
    end%蚁群遍历所有城市cycle次

    %Step7: 蚁群遍历所有城市cycle次后 记录本轮的TSP结果
    tspResultIndex = FindTspResult(pathes);%TSP顺序经过的城市的索引
    %计算TSP的路径长
    totalLength = 0;
    for i = 1: length(tspResultIndex)-1
        movingLength = pathes.length(tspResultIndex(i), tspResultIndex(i+1));
        totalLength = totalLength + movingLength;
    end
    disp(['TSP total length=', num2str(totalLength)]);
    
    %Step8: 记录最佳的TSP结果(多次蚁群算法 寻找最短路径的较优解)
    if totalLength < optimalTspResultLength
        optimalTspResultLength = totalLength;
        optimalTspResultIndex = tspResultIndex;
        disp(['optimalTspResultLength is updated as ', num2str(optimalTspResultLength)]);
        
        passByCities = TspResultIndex2XY(optimalTspResultIndex, cities);
        tspResult = PlotTspResult(cities, passByCities, optimalIndex);
    end
end

% passByCities = TspResultIndex2XY(optimalTspResultIndex, cities);
% tspResult = PlotTspResult(cities, passByCities, 2);
