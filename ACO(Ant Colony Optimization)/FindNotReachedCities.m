function notReachedCities = FindNotReachedCities(ants, antsIndex, pathes, searchRange)
%返回第antsIndex只蚂蚁 未到达过的城市

%ants=蚁群
%antsIndex=蚁群中的第几只蚂蚁
%pathes=环境路径
%searchRange=每只蚂蚁 所能观察到/搜索的范围

notReachedCities=[];

citiesNum = size(ants.cities, 2);
nowLocation = ants.location(antsIndex);


cnt = 0;
for i = 1: citiesNum%城市列表
    distance = pathes.length(nowLocation, i);%两城市间的距离
    if ants.cities(antsIndex, i) == 0 && distance < searchRange%该城市未到达过 且 该城市在蚂蚁所能感知的范围内
        cnt = cnt+1;
        notReachedCities(cnt) = i;
    end
end

%如果在该范围内没有未到达过的城市 则扩大范围再次find
if length(notReachedCities) == 0
   notReachedCities = FindNotReachedCities(ants, antsIndex, pathes, searchRange*1.5);
   return;
end

end

