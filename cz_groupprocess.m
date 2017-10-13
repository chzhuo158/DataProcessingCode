pk_h= [];
pk_loc = [];
isotope = 'background';
for i=1:20
    disp(i);
    [pks,locs]=cz_group_process(isotope,num2str(i));
    pk_h = [pk_h pks];
end

function [pks,locs]=cz_group_process(isotope,group_num)
    root = 'D:\LabData\515Lab1-LabSection2-Group3\LabSection2_Group3';    
    filename = (fullfile(root,isotope,group_num,'wave0.txt'));
    load(filename);
    [pks,locs]=cz_findpeak(wave0);
    %hist(pks,1000);
    %hist(4050-pk_amp(pk_amp~=0),1000);
end