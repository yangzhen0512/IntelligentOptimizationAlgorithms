function len = GetLength( location1, location2 )
%获得两点之间的二维平面距离

%location1=[x1, y1];
%location2=[x2, y2];

diffX = location1(1)-location2(1);
diffY = location1(2)-location2(2);
len2  = diffX^2 + diffY^2;
len   = len2^0.5;

end

