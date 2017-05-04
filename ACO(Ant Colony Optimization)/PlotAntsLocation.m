function PlotAntsLocation(ants, cities, figNum)
%根据ants.location中记录 画出各个蚂蚁的位置

antsNum = length(ants.location);

 figure(figNum);
 PlotCities(cities);
 
 antsLocation = zeros(antsNum, 2);
 for antsIndex = 1: antsNum%每只蚂蚁
     citiesIndex = ants.location(antsIndex);
     antsLocation(antsIndex, :) = cities(citiesIndex, :);
 end
 
 plot(antsLocation(:,1), antsLocation(:,2), 'bo');
 
end

