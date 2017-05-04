function startCityIndex = FindStartCity(ants, antsIndex)
%找到ants中第antsIndex只蚂蚁 运动的第一个起点城市

citiesNum = size(ants.cities, 2);
for i = 1: citiesNum
    if ants.cities(antsIndex, i) == 1%起点城市
        startCityIndex = i;
        return;
    end
end

end

