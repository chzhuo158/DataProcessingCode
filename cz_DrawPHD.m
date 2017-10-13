%this script draws Pulse Height Distribution(PHD)
%% Environment Setup
clc ;
%isotope = 'Bkg';
isotope ='Cs-137';
isPlot = 2; % plot the PHD.
            % 1 for differential
            % 2 for integral
            % 3 for both
%% Read File
root = 'D:\LabData\515Lab1-LabSection2-Group3\LabSection2_Group3';
switch(isotope)
    case 'Co-60'
        filename = (fullfile(root,'Co-60','pk_info_Co-60.mat'));
    case 'Na-22'
        filename = (fullfile(root,'Na-22','pk_info_Na22.mat'));
    case 'Cs-137'
        filename = (fullfile(root,'Cs-137','pk_info_cs137.mat'));
    case 'Bkg'
        filename = (fullfile(root,'background','pk_info_bkg.mat'));
end
load(filename)
load(fullfile(root,'bkg_prob.mat'));
%% MCA Analysis
default_data = 4050;
channel_num = 1000;
pk_h_real = default_data-pk_h(pk_h~=0);
[counts, center] = hist(pk_h_real,channel_num);
channel  = 1:1:channel_num ;
Energy = cz_EnergyCalibration(channel);
%% Plot 
if (isPlot == 1||3)
    figure();
    %plot(counts)
    plot(Energy,counts);
    grid on
    title(['Gamma Pulse Height Differential Distribution of ',isotope])
    xlabel('Energy(keV)')
    ylabel('Counts')
    %axis([0,2000,0,15000]);
    %% FWHM Calculation
    disp(['Isotope: ',isotope])
    [fwhm]=cz_FWHM(counts);
end


if (isPlot == 2)
    count_int = zeros(1,length(counts));
    for i=1:length(counts)
        count_int(i) = sum(counts(i:length(counts)));
    end
    
    figure();
    plot(Energy,count_int);
    grid on
    title(['Gamma Pulse Height Integral Distribution of ',isotope])
    xlabel('Energy(keV)')
    ylabel('Counts')
    %axis([0,2000,0,1200000]);
    %% FWHM Calculation
    %disp(['Isotope: ',isotope])
    %[fwhm]=cz_FWHM(counts);
end
