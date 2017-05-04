function result = NormalizeDataWithRange(data, maxVector, minVector)
%根据max/minVector 对数据data进行归一化
%data=[x1,x2,x3,x4, y]
%data每行=一个样本数据
%data每列=一个特征

[row, column] = size(data);

result = -1*ones(row, column+2);%y变为[y1 y2 y3] 对应3维输出
for rowIndex = 1: row
    switch data(rowIndex, column)
        case 1%y1=1
            result(rowIndex, column) = 1;
        case 2%y2=1
            result(rowIndex, column+1) = 1;
        case 3%y3=1
            result(rowIndex, column+2) = 1;
    end
end

%每个特征X的最大最小值
for columnIndex = 1: column-1%每列=每个特征X 进行归一化
    %该列的最大最小值
    minNum = minVector(columnIndex);
    maxNum = maxVector(columnIndex);
    
    for rowIndex = 1: row%每行 该特征的每个数据
        x = data(rowIndex, columnIndex);
        normalizedNum = 2 * (x-minNum) / (maxNum-minNum) - 1;%线性转换 归一化到[-1,1]
        if normalizedNum < -1
            normalizedNum = -1;
        elseif normalizedNum > 1
            normalizedNum = 1;
        end
        
        result(rowIndex, columnIndex) = normalizedNum;
    end
end


end

