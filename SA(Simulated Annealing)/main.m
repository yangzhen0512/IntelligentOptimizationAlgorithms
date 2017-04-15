%目的: 使用模拟退火来解决费马点问题
%费马点: 该点到指定n个点的距离之和最小
clc;clear all;close all;

%Step1=指定SA的参数
step=1.5;%局部搜索的步长
k=2;%温度系数

%Step2=初始化费马点问题
%随机指定二维的中心点([0~100, 0~100])---费马点应该在这附近
randCenter = rand(1, 2) * 100;
%指定n=50个随机点point 分布在Center的正负30范围内
pointX = randCenter(1)-30 + rand(50,1).*60;
pointY = randCenter(2)-30 + rand(50,1).*60;
point = [pointX pointY];%每行=一个点
%绘出费马点的初始情况
figure(1);
plot(point(:,1), point(:,2), '*');%n个随机点
hold on;
plot(randCenter(1) , randCenter(2) , 'k*');%费马点的大致位置

%Step3=使用SA解决费马点问题
%随机指定一个初始的费马点
FermatPoint = rand(1,2) .* 100;

%准备avi动画
aviObj=VideoWriter('Simulated Annealing.avi');%保存为avi
aviObj.FrameRate=30;
open(aviObj);

for T = 3000: -10: 1%循环模拟降温的过程
    %1) i+1点的位置
    dx = -step + 2*step*rand(1,1);%-step~step
    dy = -step + 2*step*rand(1,1);%-step~step
    nextPoint = [FermatPoint(1)+dx FermatPoint(2)+dy];
    
    %2) i+1点和i点 到指定n个点的距离之和
    nextLen   = GetLen(nextPoint, point);
    FermatLen = GetLen(FermatPoint, point);
    
    %3) SA模拟金属退火的过程
    if nextLen <= FermatLen%若 i+1点的能量 <= i点的能量 (退火 能量降低)
        FermatPoint = nextPoint;%接受该移动
    else%若i+1点的能量升高
        %以一定的概率P接受移动 且 这个概率随着时间T的推移而逐渐降低
        dE = nextLen-FermatLen;%能量差
        P = exp(dE/k/T);%热力学概率
        if rand(1,1) > P%接受运动
            FermatPoint=nextPoint;
        end
    end
    
    %可视化当前结果
    plot(FermatPoint(1) , FermatPoint(2), 'ro');
    length = GetLen(FermatPoint,point);
    disp(['length=' , num2str(length)]);
    %写入avi动画
    writeVideo(aviObj,getframe);
end
close(aviObj);%保存avi动画

%显示优化后的费马点结果
figure(2);
plot(point(:,1), point(:,2), '*');
hold on;
plot(randCenter(1) , randCenter(2) , 'k*');
plot(FermatPoint(1) , FermatPoint(2), 'ro');
length = GetLen(FermatPoint,point);
disp(['length of Fermat Point=' , num2str(length)]);