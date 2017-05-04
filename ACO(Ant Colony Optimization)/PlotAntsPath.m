function PlotAntsPath(ants, cities, figNum)
%根据ants.cities中记录的顺序 依次连接城市

antsNum = length(ants.location);
citiesNum = size(cities, 1);

 figure(figNum);
 hold on;
 PlotCities(cities);
 
 passByCities = zeros(citiesNum, 2);
 for antsIndex = 1: 1%antsNum%每只蚂蚁
     for citiesIndex = 1: citiesNum%每个城市
         order = ants.cities(antsIndex, citiesIndex);%经过citiesIndex城市的实际次序
         passByCities(order, :) = cities(citiesIndex,:);%第order次经过的城市 的坐标
     end
     plot(passByCities(:,1), passByCities(:,2), 'b');
 end
 
end

