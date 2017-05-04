function network = InitNeuralNetwork(inputNum, hiddenNum, outputNum, xDim, epochs)
%inputNum  输入层的神经元个数
%hiddenNum 隐含层的神经元个数
%outputNum 输出层的神经元个数
%xDim      数据的X维数
%epochs    学习循环次数

%每个神经元的权重的维数 = 前一层的输出的维数
%权重范围-1~1

%输入层
for i = 1: inputNum
    singleNeure.weight = 2*rand(xDim,1)-1;%xDim
    singleNeure.input = zeros(xDim, 1);
    singleNeure.output = 0;
    singleNeure.netSum = 0;
    network.inputNeure(i) = singleNeure;
end

%隐含层
for i = 1: hiddenNum
    singleNeure.weight = 2*rand(inputNum,1)-1;%inputNum
    singleNeure.input = zeros(inputNum, 1);
    network.hiddenNeure(i) = singleNeure;
end

%输出层
for i = 1: outputNum
    singleNeure.weight = 2*rand(hiddenNum,1)-1;%hiddenNum
    singleNeure.input = zeros(hiddenNum, 1);
    network.outputNeure(i) = singleNeure;
end

%每次学习循环 输出层各神经元的误差
network.error = zeros(epochs, outputNum);

end

