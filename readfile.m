root = 'I:\LabData\515Lab1-LabSection2-Group3\LabSection2_Group3';
filename = (fullfile(root,'datareadtest.txt'));
%load('I:\LabData\515Lab1-LabSection2-Group3\LabSection2_Group3\Co-60\1\wave0.txt')
fidin = fopen(filename,'r');
count = 0;
while ~feof(fidin)
    tline = fgetl(fidin);
    if double(tline(1))>=48&&double(tline(1))<=57  %if it's a number
        count = count+1; 
        s = deblank(tline);  %去掉字符串首位的空格
        s = regexp(s,'\s+','split'); %将空格作为分割点
        len = length(s);
        res = [];
        for i = 1:len  %将一行中的数据存到res
            a = str2double(s{i});
            res = [res,a];
        end
        result(count,1) = {res}; %将目前得到的矩阵存进元胞矩阵中
    else
        continue
    end
end