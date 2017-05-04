%目的: 使用支持向量机算法 求解围栏问题
%围栏问题的描述见 围栏问题.jpg 或 http://www.cnblogs.com/end/p/3848740.html
clc; clear; close all;

%Step1=指定SVM的参数
C = 10;%错分样本的惩罚程度
kernelType = 'RBF';%核函数的类型 这里使用径向基函数RBF
delta = 5;%RBF中的参数
%绘图的参数
line_width=2;
point_width=15;
minX=-1; maxX=7;
minY=-1; maxY=8;

%Step2=初始化围栏问题
%羊
x_cows = [2,5 ; 3,2 ; 3,3 ; 3,4 ; 4,1 ; 4,2 ; 4,4; 5,2 ; 5,4];%羊的坐标 每行=一头羊的x和y
rowNum = size(x_cows, 1);
y_cows = ones(rowNum, 1);%列向量 羊的分类记为1
%狼
x_wolves = [0,0 ; 0,2 ; 1,1 ; 2,0 ; 2,7; 4,0 ; 6,3 ; 6,4];%狼的坐标 每行=一头狼的x和y
rowNum = size(x_wolves, 1);
y_wolves = -ones(rowNum, 1);%列向量 狼的分类记为-1
%绘出羊和狼的分布情况
figure;
hold on;
plot(x_cows(:,1),   x_cows(:,2),   'k.', 'MarkerSize', point_width);
plot(x_wolves(:,1), x_wolves(:,2), 'rx', 'MarkerSize', point_width);
axis( [minX maxX minY maxY] );

%Step3=使用SVM解决围栏问题
%1) 准备SVM模型的输入数据(即训练样本)
% X=[x1,x2]
% Y=[y]
X = [x_cows', x_wolves'];%dim*n矩阵 n为样本个数 dim为X的维数(围栏问题dim=2)
Y = [y_cows', y_wolves'];%1*n矩阵 n为样本个数 值为+1或-1

%2) SVM训练 获得支持向量
supportVector = SVMTrain(X, Y, kernelType, C, delta);
%起支持作用的向量(支持向量) 用红圈标注
plot(supportVector.X(1,:), supportVector.X(2,:), 'ro', 'MarkerSize', point_width);

%3) SVM测试整个平面
[x1, x2] = meshgrid(minX:0.05:maxX, minY:0.05:maxY);%网格采样点
[rows, cols] = size(x1);
length = rows*cols;
Xtest = [reshape(x1,1,length); reshape(x2,1,length)];%每个采样点 转化为 一个列向量=dim*nn
Ytest = SVMTest(supportVector, Xtest, kernelType, delta);%1*nn 对应采样点的分类结果
%等高线绘制(该等高线即为围栏)
Ygrid = reshape(Ytest, rows, cols);
contour(x1, x2, Ygrid, 'm');%等高线