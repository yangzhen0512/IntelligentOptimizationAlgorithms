function result = TestNetwork(network, data, xDim)
%根据神经网络network计算data的输出result
%X的维数xDim

%result = [理论结果, 神经网络结果, 处理后的神经网络结果]

dataNum = size(data, 1);%输入数据的组数
yDim = size(data, 2) - xDim;
result = zeros(dataNum, 3*yDim);

for dataIndex = 1: dataNum%每行训练数据
    %1) 神经网络的计算
    inputData = data(dataIndex, 1:xDim);%神经网络的输入向量 = 归一化后实验数据的特征纬度数据
    network = NeureNetworkCalculate(network, inputData);
    %2) 记录结果
    result(dataIndex, 1:yDim) = data(dataIndex, xDim+1:end);%理论结果
    for yIndex = 1: yDim
        result(dataIndex, yDim+yIndex) = network.outputNeure(yIndex).output;%神经网络结果
    end
    %3) 处理神经网络的结果
    result(dataIndex, 2*yDim+1:end) = ProcessOutput(result(dataIndex, yDim+1:2*yDim));
end

end

