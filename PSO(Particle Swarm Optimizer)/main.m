%目的: 使用粒子群PSO优化算法 求解三维函数的最大值
clc;clear all;close all;

%Step1=指定PSO的参数
num = 128;%鸟群中个体数目
c1 = 2; c2 = 2;%c1 c2=学习因子(非负常数)
w = 0.8;%惯性因子(非负数)
alpha = 0.4;%约束因子=控制速度的权重
v_limit = 0.2;%速度极值

%Step2=初始化求解的函数fun
[fun_x, fun_y, fun_z] = peaks;
figure(1);
hold on;
meshc(fun_x, fun_y, fun_z);

%Step3=使用PSO求解函数的最大值
particle = zeros(num, 5);%一群粒子 每行=[编号 位置x 位置y 速度x 速度y]
pi = zeros(num, 3);%个体历史最优 每行=[编号 位置x 位置y] (每个个体均有一个历史最有 且 历史最优带有记忆=迄今为止的最优，包含过去的状态)
pg = zeros(1, 2);%群体历史最优 每行=[位置x 位置y] (整个粒子群仅有一个)
pg(1) = -3 + 6*rand(1,1);%x=-3~3
pg(2) = -3 + 6*rand(1,1);%y=-3~3
%赋予粒子群初值(每个粒子随机位置和速度)
for i = 1: 1: num
    %每个粒子
    particle(i,1) = i;%编号
    particle(i,2) = -3+6*rand(1,1);%x=-3~3
    particle(i,3) = -3+6*rand(1,1);%y=-3~3
    particle(i,4) = -v_limit+v_limit*2*rand(1,1);%vx=-v_limit~v_limit
    particle(i,5) = -v_limit+v_limit*2*rand(1,1);%vy=-v_limit~v_limit
    %个体历史最优
    pi(i,1) = particle(i,1);%编号
    pi(i,2) = particle(i,2);%x
    pi(i,3) = particle(i,3);%y
    %群体历史最优初值
    if GetFitness( particle(i,2:3) ) > GetFitness( pg )
        pg = particle(i,2:3);
    end
end
%初始情况的显示
figure(1);
hold on;
plot_x = particle(:,2);
plot_y = particle(:,3);
plot_z = FuncCalculate(plot_x, plot_y);
plot3(plot_x , plot_y , plot_z , '*r');%粒子位置
axis([-3,3 , -3,3]);
hold off;

%准备avi动画
aviObj = VideoWriter('Particle Swarm Optimizer.avi');%保存为avi
aviObj.FrameRate = 30;
open(aviObj);

for cycle=1:1:100%粒子群运动次数
    tmp_pg = pg;%群体最优
	%每个粒子的运动应当是并行的 所以刷新的群体历史最优应当不会影响这一轮的运动
	%对于每个粒子 PSO运动时基于pg
	%所有粒子运动结束后 再去刷新pg
	
    for i = 1: 1: num%每个粒子
        %1) 粒子操作(见: 粒子群优化算法 李爱国,覃征,鲍复民,贺升平 公式3和4)
        v_id = particle(i,4:5);%i粒子的速度=(v_x v_y)
        x_id = particle(i,2:3);%i粒子的位置=(x_x x_y)
        p_id = pi(i, 2:3);%i粒子的个体历史最优位置
        
        r1 = rand(1,1);%r1,r2是介于[0,1]之间的随机数
        r2 = rand(1,1);
        
        v_id = w*v_id + c1*r1*(p_id-x_id) + c2*r2*(pg-x_id);
        x_id = x_id + alpha*v_id;
        
        %2) 对于越界的粒子进行调整: 反射边界上=速度大小不变 方向取反
        if ( x_id(1)>3 && v_id(1)>0 ) || ( x_id(1)<-3 && v_id(1)<0 )%x+或x-方向越界
            x_id = x_id - alpha*v_id;%恢复之前的位置
            v_id(1) = -v_id(1);%x方向上速度取反
            x_id = x_id + alpha*v_id;%然后再运动
        end
        if ( x_id(2)>3 && v_id(2)>0 ) || ( x_id(2)<-3 && v_id(1)<0 )%y+或y-方向越界
            x_id = x_id - alpha*v_id;%恢复之前的位置
            v_id(2) = -v_id(2);%y方向上速度取反
            x_id = x_id + alpha*v_id;%然后再运动
        end
        
        %3) 粒子运动
		%刷新粒子的位置和速度
        particle(i,2:3) = x_id;
        particle(i,4:5) = v_id;
        %刷新个体历史最优
        if GetFitness( particle(i,2:3) ) > GetFitness( pi(i,2:3) )
            pi(i,2:3) = particle(i,2:3);
        end
        %刷新群体历史最优
        if GetFitness( particle(i,2:3) ) > GetFitness( tmp_pg )
            tmp_pg = particle(i,2:3);%tmp_pg 不影响这一轮后续的粒子判断
        end
    end
    pg=tmp_pg;
    
	%可视化当前结果
    figure(2);
	%函数图像
    meshc(fun_x, fun_y, fun_z);
    hold on;
	%每个粒子的分布
    plot_x = particle(:,2);
    plot_y = particle(:,3);
    plot_z = FuncCalculate(plot_x, plot_y);
    plot3( plot_x , plot_y , plot_z , '*r');%粒子位置
    axis([-3,3 , -3,3]);
    hold off;
    %写入avi动画
    writeVideo(aviObj,getframe);
end
%保存avi动画
close(aviObj);



%最后的结果显示
figure(3);
meshc(fun_x, fun_y, fun_z);%函数图像
hold on;
plot_x=particle(:,2);
plot_y=particle(:,3);
plot_z=FuncCalculate(plot_x, plot_y);
plot3( plot_x , plot_y , plot_z , '*r');%粒子位置
axis([-3,3 , -3,3]);
hold off;