function passByCities = PlotTspResult(cities, passByCities, figNum)
%绘制TSP的结果

%cities=每个城市的XY坐标
%passByCities=TSP按序经过的城市的XY坐标
%figNum=图号

figure(figNum);
PlotCities(cities);

line(passByCities(:,1), passByCities(:,2));

end

