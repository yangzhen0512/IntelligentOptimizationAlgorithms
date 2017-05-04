function path = InitPath( cities )
%初始化城市间的路径: 城市间的路径的长度+信息素
%城市间两两之间有通路

%cities每行=一个城市的坐标
initPheromone = 1;

cityNum = size(cities, 1);

%两两城市之间的路径长度
path.length = zeros(cityNum, cityNum);
for i = 1: cityNum%每个城市 与 其他城市间的距离
    for j = 1: cityNum
        path.length(i,j) = GetLength(cities(i,:), cities(j,:));
    end
end

%两两城市之间的信息素
path.pheromone = zeros(cityNum, cityNum);
for i = 1: cityNum%每个城市 与 其他城市间的信息素
    for j = 1: cityNum
        path.pheromone(i,j) = initPheromone;
    end
end

end

