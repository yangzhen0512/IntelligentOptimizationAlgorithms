function FigError(network, figNum)
%绘制network中每次学习过程中的误差

[epochs, yDim] = size(network.error);

error = zeros(epochs, 1);
for times = 1: epochs
    for yIndex = 1: yDim
        error(times) = error(times) + network.error(times, yIndex)^2;
    end
    error(times) = sqrt(error(times)) / 3.0;
end

figure(figNum);
hold on;
plot(error);
title('error');
xlabel('epochs');
ylabel('error');

end

