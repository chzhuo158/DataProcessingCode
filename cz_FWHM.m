function [fwhm]=cz_FWHM(line)
size_line=0;
if size(line,1)==1
    size_line = size(line,2);
elseif size(line,2)==1
    size_line = size(line,1);
else
    error('Size Check Error');
end

%% Locate the Peak
peak=max(line);%can be optimized
peakPos = find(line==peak);
peakPos = mean(peakPos);

%% Show the Peak
disp(['Peak Position = No.',num2str(peakPos), ' channel']);
disp(['Peak Position = ',num2str(cz_EnergyCalibration(peakPos)),' keV']);
disp(['Peak Height = ',num2str(peak),' counts']);
%% Calculate FWHM
j=1;
k=1;
fwhm=zeros(1,2);
fwtm=zeros(1,2);
for i=1:size_line-1
    if (line(i)-peak/2)*(line(i+1)-peak/2)<0 || (line(i)-peak/2)*(line(i+1)-peak/2)==0
         fwhm(1,j)=i+abs((line(i)-peak/2)/(line(i+1)-line(i)));
         %disp(i);
         j=j+1;
    elseif (line(i)-peak/10)*(line(i+1)-peak/10)<0 || (line(i)-peak/10)*(line(i+1)-peak/10)==0
         fwtm(1,k)=i+abs((line(i)-peak/10)/(line(i+1)-line(i)));
         %disp(i);
         k=k+1;
    end
end

%% Display Results 
fwhmValue=fwhm(1,2)-fwhm(1,1);
disp(['FWHM = ',num2str(fwhmValue),' channels']);
disp(['Resolution R = ',num2str(100*fwhmValue/peakPos),'%']);
