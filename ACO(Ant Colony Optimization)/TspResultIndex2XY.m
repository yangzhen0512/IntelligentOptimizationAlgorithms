function tspResultXY = TspResultIndex2XY(tspResultIndex, cities)
%将城市的索引 转换为 城市的XY坐标

%tspResultIndex=按顺序经过的城市的索引
%cities=每个城市的XY坐标

citiesCnt = length(tspResultIndex);%citiesNum+1(包含最后的回到起点)
tspResultXY = zeros(citiesCnt, 2);

for i = 1: citiesCnt%每个城市
    destCityIndex = tspResultIndex(i);
    tspResultXY(i, :) = cities(destCityIndex, :);%第i次经过的城市 的坐标
end
    
end

