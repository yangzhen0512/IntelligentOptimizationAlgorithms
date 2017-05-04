function network = TrainNetwork(network, data, xDim, epochs, learningRate)
%根据data训练神经网络network
%X的维数xDim
%epochs学习循环次数
%learningRate学习速度常数

%see: 神经网络之梯度下降与反向传播（下）
% https://zhuanlan.zhihu.com/p/25609953

dataNum = size(data, 1);%输入数据的组数

for epochsIndex = 1: epochs%训练次数
    for dataIndex = 1: dataNum%每行训练数据
        %1) 神经网络的计算
        inputData = data(dataIndex, 1:xDim);%神经网络的输入向量 = 归一化后实验数据的特征纬度数据
        network = NeureNetworkCalculate(network, inputData);
        
        %2) 学习训练
        outputData = data(dataIndex, xDim+1:end);%
        network = BackPropagation(network, outputData, learningRate, epochsIndex);
    end
end

end

