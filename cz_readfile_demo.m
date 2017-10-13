root = 'D:\LabData\515Lab1-LabSection2-Group3\LabSection2_Group3';
%filename = (fullfile(root,'datareadtest.txt'));
filename = (fullfile(root,'Co-60','1','wave0.txt'));
fidin = fopen(filename,'r');
count = 0;
pk_locs = [];
pk_height = [];
pk_count = 0;
%total_length = 200000;%数据总长度
total_length = 1500000;%数据总长度
group_length = 10000; %处理阶段每组（段）数据的长度
num_group = total_length/group_length;

for group = 1:num_group
   res = zeros(group_length,1);
   for data_length = 1:group_length
       %% Data Read in
        tline = fgetl(fidin);
        count = count+1; 
        s = deblank(tline);  %去掉字符串首位的空格
        s = regexp(s,'\s+','split'); %将空格作为分割点
        a = str2double(s{1});
        %a=ss{1};
        res(data_length,1)= a;
       
   end
   %% Find peak in data
       [pks,locs]=cz_findpeak(res);
   %% Save data
       pk_locs = [pk_locs locs+(group-1)*group_length];
       pk_height = [pk_height pks+(group-1)*group_length];
       pk_count = pk_count + length(locs);
end

%% after-processing