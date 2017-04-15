function sumLen = GetLen( position , point )
%获取 当前点position 与 其他n个点point 的距离的平方和

x = position(1);
y = position(2);
    
sumLen = 0;
n = size(point, 1);
for i = 1: 1: n
    px = point(i, 1);
    py = point(i, 2);
    length = (px-x)^2 + (py-y)^2;
    
    sumLen = sumLen + length;
end

end

