root = 'I:\LabData\515Lab1-LabSection2-Group3\LabSection2_Group3';
filename = (fullfile(root,'datareadtest.txt'));
%load('I:\LabData\515Lab1-LabSection2-Group3\LabSection2_Group3\Co-60\1\wave0.txt')
fidin = fopen(filename,'r');
count = 0;
while ~feof(fidin)
    tline = fgetl(fidin);
    if double(tline(1))>=48&&double(tline(1))<=57  %if it's a number
        count = count+1; 
        s = deblank(tline);  %ȥ���ַ�����λ�Ŀո�
        s = regexp(s,'\s+','split'); %���ո���Ϊ�ָ��
        len = length(s);
        res = [];
        for i = 1:len  %��һ���е����ݴ浽res
            a = str2double(s{i});
            res = [res,a];
        end
        result(count,1) = {res}; %��Ŀǰ�õ��ľ�����Ԫ��������
    else
        continue
    end
end