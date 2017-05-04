function data = ReadData(filename)
%从文件中格式化读取数据

fid = fopen(filename);
cellData = textscan(fid, '%f%f%f%f%f');
fclose(fid);

data = cell2mat(cellData);%=[x1,x2,x3,x4, y]

end
