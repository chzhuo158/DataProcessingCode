root = 'D:\LabData\515Lab1-LabSection2-Group3\LabSection2_Group3';
%filename = (fullfile(root,'datareadtest.txt'));
filename = (fullfile(root,'Co-60','1','wave0.txt'));
load(filename);
[pk_amp,pk_locs]=cz_findpeak(wave0);
