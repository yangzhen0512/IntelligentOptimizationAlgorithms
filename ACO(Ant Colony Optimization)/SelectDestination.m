function destination = SelectDestination(nowLocation,  notReachedCities, pathes)
%蚂蚁在 nowLocation=当前所在城市的索引
%前往 notReachedCities=未经过的城市的索引列表 中的一个城市
%选择方法: 基于pathes.pheromone的信息素浓度 的轮盘赌选择

citiesCnt = length(notReachedCities);
pheromone = zeros(citiesCnt, 1);%nowLocation到notReachedCities之间的信息素
for i = 1: citiesCnt
    pheromone(i) = pathes.pheromone(nowLocation, notReachedCities(i));%该路径上的信息素
end

%基于信息素 轮盘赌选择目的地
index = Roulette(pheromone);%返回轮盘赌所选择的索引(基于pheromone)
destination = notReachedCities(index);%获得对应的城市的索引

end

