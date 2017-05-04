function network = NeureNetworkCalculate(network, data)
%完成一轮神经网络的计算
%根据data的输入X行向量 计算神经网络的各层输出

%每层神经元的个数
inputNeureNum  = size(network.inputNeure, 2);
hiddenNeureNum = size(network.hiddenNeure, 2);
outputNeureNum = size(network.outputNeure, 2);

%1) 计算输入层的输出
layerInput = data;%输入层的输入向量 = data输入向量

for neureIndex = 1: inputNeureNum%每个神经元
    singleNeure = network.inputNeure(neureIndex);%单个神经元
    %[fx, sum] = NeureCalculate(singleNeure, layerInput);%神经元计算+激活
    [fx, sum] = NeureCalculate(singleNeure, layerInput);%神经元计算+激活
    
    network.inputMeure(neureIndex).input = layerInput;
    network.inputNeure(neureIndex).output = fx;
    network.inputNeure(neureIndex).netSum = sum;
end

%2) 计算隐含层的输出
layerInput = zeros(1, inputNeureNum);%隐含层的输入向量 = 输入层的输出
for neureIndex = 1: inputNeureNum%输入层的每个神经元
    layerInput(neureIndex) = network.inputNeure(neureIndex).output;
end

for neureIndex = 1: hiddenNeureNum%每个神经元
    singleNeure = network.hiddenNeure(neureIndex);%单个神经元
    [fx, sum] = NeureCalculate(singleNeure, layerInput);%神经元计算+激活
    
    network.hiddenNeure(neureIndex).input = layerInput;
    network.hiddenNeure(neureIndex).output = fx;
    network.hiddenNeure(neureIndex).netSum = sum;
end

%3) 计算输出层的输出
layerInput = zeros(1, hiddenNeureNum);%输出层的输入向量 = 隐含层的输出
for neureIndex = 1: hiddenNeureNum%输入层的每个神经元
    layerInput(neureIndex) = network.hiddenNeure(neureIndex).output;
end

for neureIndex = 1: outputNeureNum%每个神经元
    singleNeure = network.outputNeure(neureIndex);%单个神经元
    [fx, sum] = NeureCalculate(singleNeure, layerInput);%神经元计算+激活
    
    network.outputNeure(neureIndex).input = layerInput;
    network.outputNeure(neureIndex).output = fx;
    network.outputNeure(neureIndex).netSum = sum;
end
        
end

