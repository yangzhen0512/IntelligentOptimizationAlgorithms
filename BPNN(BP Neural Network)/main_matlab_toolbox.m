%利用matlab的神经网络工具箱进行神经网络的训练及测试
clc; clear; close all;

%读取训练数据
[f1, f2, f3, f4, class] = textread('TrainData.txt' , '%f%f%f%f%f',105);
%特征值归一化
[input,minI,maxI] = premnmx( [f1 , f2 , f3 , f4 ]')  ;
%构造输出矩阵
s = length( class) ;
output = zeros( s , 3  ) ;
for i = 1 : s 
   output( i , class( i )  ) = 1 ;
end

%创建神经网络
net = newff( minmax(input) , [10 3] , { 'logsig' 'purelin' } , 'traingdx' ) ; 
%设置训练参数
net.trainparam.show = 50 ;
net.trainparam.epochs = 500 ;
net.trainparam.goal = 0.01 ;
net.trainParam.lr = 0.01 ;

%开始训练
net = train( net, input , output' ) ;

%读取测试数据
[t1, t2, t3, t4, c] = textread('TestData.txt' , '%f%f%f%f%f',45);
%测试数据归一化
testInput = tramnmx ( [t1,t2,t3,t4]' , minI, maxI );

%仿真
Y = sim( net , testInput );

%统计识别正确率
[s1 , s2] = size( Y ) ;
hitNum = 0 ;
for i = 1 : s2
    [m , Index] = max( Y( : ,  i ) );
    if( Index  == c(i) ) 
        hitNum = hitNum + 1; 
    end
end
disp(['识别率是', num2str(100 * hitNum / s2), '%']);%识别率是 88.889%