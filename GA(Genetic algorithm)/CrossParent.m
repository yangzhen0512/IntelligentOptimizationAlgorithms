function childGene = CrossParent(parent, individual)
%parent=两个母本的编号
%individual每行=[个体编号, 该个体所在的坐标x] 且 索引=个体编号

%母本的编号
parent1Index = parent(1);
parent2Index = parent(2);
%母本的坐标x
parent1X = individual(parent1Index, 2);
parent2X = individual(parent2Index, 2);
%母本的基因
parent1Gene = num2gene( parent1X );%列向量
parent2Gene = num2gene( parent2X );%列向量

%交叉=2个母本的1~cut位的基因进行交换
cut = floor( rand(1,1) * 12 ) + 1;%向下取整=1~12的整数
for i=1: 1: cut
    tmp = parent1Gene(i);
    parent1Gene(i) = parent2Gene(i);
    parent2Gene(i) = tmp;
end

%子代=交叉后的母本
childGene = [parent1Gene; parent2Gene];%列向量

end

