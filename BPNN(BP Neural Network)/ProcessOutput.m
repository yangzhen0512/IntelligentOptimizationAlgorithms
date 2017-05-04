function data = ProcessOutput(data)
%处理data的神经元的输出向量
%其中具有最大输出值的神经元 置1(神经网络的输出结果)
%其他神经元的输出 置-1
%data = [理论结果, 神经网络结果, 处理后的神经网络结果]

column = size(data, 2);

%遍历data向量 找到最大值的下标
index = 1;
for columnIndex = 2: column
    if data(columnIndex-1) < data(columnIndex)
        index = columnIndex;
    end
end

%最大值对应的神经元输出 置1
%其余的神经元输出 置-1
for columnIndex = 1: column
    if columnIndex == index
        data(columnIndex) = 1;
    else
        data(columnIndex) = -1;
    end
end

end

