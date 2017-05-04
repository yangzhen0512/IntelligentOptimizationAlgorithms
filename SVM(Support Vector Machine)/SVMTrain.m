function supportVector = SVMTrain(X, Y, kernelType, C, delta)
%利用X和Y的训练样本 对SVM模型进行训练

%X = dim*(num=n)
%Y = 1*n

%MyQuadProg求解最优化问题
alpha = MyQuadProg(X, Y, kernelType, C, delta);%alpha=n*1的矩阵

%基于SVM的入侵检测系统研究 孙钢 公式
epsilon = 1e-8;%小量
validIndex = find( abs(alpha)>epsilon );%获得有效的支持向量的索引(alpha>0的对应下标索引)

supportVector.alpha = alpha(validIndex);%nPart*1
supportVector.X     = X(:, validIndex);%取出alpha>0的列
supportVector.Y     = Y(validIndex);

end

