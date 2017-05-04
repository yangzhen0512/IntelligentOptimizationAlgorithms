%BP神经网络(结果不稳定 多运行几次来发现较好的结果)
%可以和main_matlab_toolbox.m的结果进行比较
%求解判断iris花的品种
%see: http://blog.csdn.net/luoshengkim/article/details/41923723

clc;clear;close all;

%神经网络的训练次数
epochs= 500;
%学习速度
learningRate = 0.0001;

xDim = 4;%[x1, x2, x3, x4] 4种特征
yDim = 3;%[y1, y2, y3] 3种品种

%1) 获取训练集数据
trainData = ReadData('TrainData.txt');
%归一化处理实验数据
[normalizedTrainData, maxTrainVector, minTrainVactor]= NormalizeData(trainData);

%2) 初始化神经网络=4输入-5隐含-3输出(即Y的维数)-4维X
network = InitNeuralNetwork(7,14,3, xDim, epochs);

%3) 训练神经网络
network = TrainNetwork(network, normalizedTrainData, xDim, epochs, learningRate);

%4) 测试神经网络
testData  = ReadData('TestData.txt');
normalizedTestData = NormalizeDataWithRange(testData, maxTrainVector, minTrainVactor);
result = TestNetwork(network, normalizedTestData, xDim);%result=[data中的结果 神经网络各输出层的结果]

%5) 计算正确率
accurancy = GetAccuracny(result, yDim);
disp(['accurancy=' , num2str(accurancy)]);%best accurancy=0.88889
%绘制误差变化图
FigError(network, 1);