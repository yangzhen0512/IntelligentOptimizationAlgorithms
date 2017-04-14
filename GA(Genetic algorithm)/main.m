%目的: 使用基因算法 求解函数的最大值
clc; clear all; close all; clf;

%Step1=指定GA的参数
num = 256;%个体数量

%Step2=初始化求解的函数fun
fun_x = 15: 0.1: 25;%x=15~25
fun_y = fun_x + 10* sin(5* fun_x)+ 7* cos(4* fun_x);
figure(1);
hold on;
plot(fun_x, fun_y, '-b');

%Step3=使用GA求解函数的最大值
%随机产生一群个体
individual = zeros(num, 2);
for i = 1: 1: num
    individual(i,1) = i;%个体的编号
    individual(i,2) = 15 + 10*rand(1, 1);%该个体所在的x=15~25
end

%准备avi动画
aviObj=VideoWriter('Genetic Algorithm.avi');%保存为avi
aviObj.FrameRate=30;
open(aviObj);

for cycle = 1: 1: 100%群体繁殖的循环次数
    %1) 计算每个个体的适应度值
    fitness = GetFitness(individual);
    
    %2) 获取母本组(适应度大 较大概率被选为母本)
    parent = zeros(num/2, 2);
    for i= 1: 1: num/2
        parent(i,:) = GetTwoParents(fitness);%每行=两个母本的编号
    end
    
    %3) 交叉 生成子代
    tmpParent = zeros(num, 2);
    for i = 1: 1: num/2
        genesOfTwoChildren = CrossParent( parent(i,:), individual );%返回列向量=两个子代的基因 
        geneOfChild1 = genesOfTwoChildren(1:12);%12位的基因
        geneOfChild2 = genesOfTwoChildren(13:24);%12位的基因
        
		%两个子代
        tmpParent(2*i-1, 1) = 2*i-1;%编号
        tmpParent(2*i-1, 2) = gene2num( geneOfChild1 );%该个体所在的x
        tmpParent( 2*i,  1) = 2*i;%编号
        tmpParent( 2*i,  2) = gene2num( geneOfChild2 );%该个体所在的x
    end
	%刷新一代成员
    individual=tmpParent;
    
    %可视化当前结果
    %原函数
    fun_x= 15: 0.1: 25;%15~25
    fun_y= fun_x + 10* sin(5* fun_x)+ 7* cos(4* fun_x);
    figure(1);
    plot(fun_x, fun_y, '-b');
    hold on;
    %个体点
    fun_x= individual(:,2);%个体所在的x
    fun_y= fun_x + 10* sin(5* fun_x)+ 7* cos(4* fun_x);
    plot(fun_x, fun_y, '*r');
    hold off;
    %写入avi动画
    writeVideo(aviObj, getframe);
end
%保存avi动画
close(aviObj);