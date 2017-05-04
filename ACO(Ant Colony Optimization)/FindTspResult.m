function tspResult = FindTspResult(pathes)
%根据pathes.pheromone
%依次选择最大信息素浓度的路径
%获得TSP问题的解(按顺序经过的城市的索引)

citiesNum = size(pathes.pheromone, 1);
tspResult = zeros(citiesNum+1, 1);%+1回到起点

%起点城市
initCityIndex = 1;%fix(rand(1)*citiesNum);
startCityIndex = initCityIndex;
tspResult(1) = initCityIndex;

for citiesIndex = 2: citiesNum%选择第几个经过的城市
    %选出没经过的城市possibleCities
    leftCitiesNum = citiesNum-citiesIndex+1;%没经过的城市数量
    possibleCities = zeros(leftCitiesNum,1);
    cnt = 0;
    for i = 1 : citiesNum%所有城市
        if ismember(i, tspResult) == 0%i城市没经过
            cnt = cnt+1;
            possibleCities(cnt) = i;
        end
    end
    
    %从没经过的城市当中 选择一个城市 其信息素浓度最大
    maxPheromone = 0;
    for i = 1: leftCitiesNum
        possibleCityIndex = possibleCities(i);
        possibleCityPheromone = pathes.pheromone(startCityIndex, possibleCityIndex);
        
        if maxPheromone < possibleCityPheromone;
            maxPheromone = possibleCityPheromone;
            destCityIndex = possibleCityIndex;
        end
    end
    
    %前往目的城市
    tspResult(citiesIndex) = destCityIndex;
    startCityIndex = destCityIndex;
end

%回到起点城市
tspResult(citiesNum+1) = initCityIndex;

end

