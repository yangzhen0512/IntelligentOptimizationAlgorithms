function accurancy = GetAccuracny(result, yDim)
%计算分类的正确率
%result = [理论结果, 神经网络结果, 处理后的神经网络结果]

rightCnt = 0;
totalSample = size(result,1);
for sampleIndex = 1: totalSample
    for yIndex = 1: yDim
        %理论结果的位置=1 且 神经元输出结果的位置=1
        if result(sampleIndex, yIndex)==1 && result(sampleIndex, yIndex+2*yDim)==1
            rightCnt = rightCnt+1;
            break;
        end
    end
end

accurancy = rightCnt/totalSample;

end

