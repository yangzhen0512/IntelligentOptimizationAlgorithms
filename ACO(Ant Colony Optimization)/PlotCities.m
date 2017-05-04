function PlotCities( cities )
%cities每行=一个城市的坐标

%城市点
plot(cities(:,1), cities(:,2), 'rx');
axis equal;
hold on;

%城市序号
offset = 0.5;
for i=1: size(cities, 1)
    text(cities(i,1)-offset, cities(i,2)-offset, num2str(i));
end

end

