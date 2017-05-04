function network = BackPropagation(network, outputData, learningRate, times)
%误差反向传播+权值更新
%outputData=理论输出结果Y的行向量
%learningRate=学习速率
%times=当前学习次数

%每层神经元的个数
xDim = length( network.inputNeure(1).weight );
inputNeureNum  = size(network.inputNeure, 2);
hiddenNeureNum = size(network.hiddenNeure, 2);
outputNeureNum = size(network.outputNeure, 2);

%检查维数
if outputNeureNum ~= length(outputData)
    disp(['error dim for outputNeureNum/outputData=', num2str(outputNeureNum), '/', num2str(length(outputData))]);
    return;
end

%1) 输出层
%反向传播
delta = zeros(1, outputNeureNum);
for outputIndex = 1: outputNeureNum
    diffY = outputData(outputIndex) - network.outputNeure(outputIndex).output;%_yi_(理论输出) - yi(网络输出)
    v_k = network.outputNeure(outputIndex).netSum;%导数f'的输入v_1_k...v_nk_k
    delta(outputIndex) = diffY * ActiveFuncDerivative(v_k);%[3.16 a]
    network.error(times, outputIndex) = diffY;%记录输出层各神经元的误差
end
%权值更新
for outputIndex = 1: outputNeureNum
    for hiddenIndex = 1: hiddenNeureNum
        x_k_1 = network.hiddenNeure(hiddenIndex).output;%第k-1层的输出向量=隐含层的输出

        w_k_s = network.outputNeure(outputIndex).weight(hiddenIndex);%权值向量
        network.outputNeure(outputIndex).weight(hiddenIndex) = w_k_s + learningRate*x_k_1*delta(outputIndex);
    end
end

%2) 隐含层
%当前k=隐含层
%反向传播
delta_k1 = delta;%delta(k+1) 输出层的delta = [1xoutputNeureNum]
w_k1 = zeros(outputNeureNum, hiddenNeureNum);%W(k+1) 输出层的权值
for outputIndex = 1 : outputNeureNum
    for hiddenIndex = 1: hiddenNeureNum
        w_k1(outputIndex, hiddenIndex) = network.outputNeure(outputIndex).weight(hiddenIndex);
    end
end
f_k = zeros(hiddenNeureNum, hiddenNeureNum);%F(k) 隐含层的梯度
for hiddenIndex = 1: hiddenNeureNum
    v_k = network.hiddenNeure(hiddenIndex).netSum;
    f_k(hiddenIndex, hiddenIndex) = ActiveFuncDerivative(v_k);
end
delta_k = delta_k1 * w_k1 * f_k;%反向传播计算公式delta(k) = delta(k+1)W(k+1)F(k) = [1xhiddenNeureNum]
%权值更新
w_k_s = zeros(hiddenNeureNum, inputNeureNum);%W(k)(s) 隐含层权值
for hiddenIndex = 1: hiddenNeureNum
    for inputIndex = 1: inputNeureNum
        w_k_s(hiddenIndex, inputIndex) = network.hiddenNeure(hiddenIndex).weight(inputIndex);
    end
end
x_k_1 = zeros(inputNeureNum, 1);%第k-1层的输出向量=输入层的输出 X(k-1)
for i = inputIndex: inputNeureNum
    x_k_1(inputIndex) = network.inputNeure(inputIndex).output;
end
w_k_s1 = w_k_s + learningRate * (x_k_1*delta_k)';%权值更新公式W(k)(s+1) = W(k)(s) + LR*(X(k-1)*delta(k))'
for inputIndex = 1: inputNeureNum
    for hiddenIndex = 1: hiddenNeureNum
        network.hiddenNeure(hiddenIndex).weight(inputIndex) = w_k_s1(hiddenIndex, inputIndex);
    end
end

%3) 输入层
%反向传播
delta_k1 = delta_k;%delta(k+1) 隐含层的delta = [1xhiddenNeureNum]
w_k1 = zeros(hiddenNeureNum, inputNeureNum);%W(k+1) 隐含层的权值
for hiddenIndex = 1 : hiddenNeureNum
    for inputIndex = 1: inputNeureNum
        w_k1(hiddenIndex, inputIndex) = network.hiddenNeure(hiddenIndex).weight(inputIndex);
    end
end
f_k = zeros(inputNeureNum, inputNeureNum);%F(k) 输入层的梯度
for inputIndex = 1: inputNeureNum
    v_k = network.inputNeure(inputIndex).netSum;
    f_k(inputIndex, inputIndex) = ActiveFuncDerivative(v_k);
end
delta_k = delta_k1 * w_k1 * f_k;%反向传播计算公式delta(k) = delta(k+1)W(k+1)F(k) = [1xinputNeureNum]
%权值更新
w_k_s = zeros(inputNeureNum, xDim);%W(k)(s) 输入层权值
for inputIndex = 1: inputNeureNum
    for xIndex = 1: xDim
        w_k_s(inputIndex, xIndex) = network.inputNeure(inputIndex).weight(xIndex);
    end
end
x_k_1 = zeros(xDim, 1);%第k-1层的输出向量=样本的输入 X(k-1)
for i = xIndex: xDim
    x_k_1(xIndex) = network.inputNeure(1).input(xIndex);
end
w_k_s1 = w_k_s + learningRate * (x_k_1*delta_k)';%权值更新公式W(k)(s+1) = W(k)(s) + LR*(X(k-1)*delta(k))'
for inputIndex = 1: inputNeureNum
    for xIndex = 1: xDim
        network.inputNeure(inputIndex).weight(xIndex) = w_k_s1(inputIndex, xIndex);
    end
end

end

