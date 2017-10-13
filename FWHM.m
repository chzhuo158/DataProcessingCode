%%
%修改时间 2014/5/10

function [fwhm,fwtm]=FWHM(line,isPlot,isFitting)
% line  是一个一维数组
% isFit 选择是否拟合峰值

%%参数控制与初始化
if nargin <1
    error('输入参数不能为空！');
elseif nargin<2
    isPlot=1;
    isFitting=0;
elseif nargin<3
    isFitting=0;
end

size_line=0;
if size(line,1)==1
    size_line = size(line,2);
elseif size(line,2)==1
    size_line = size(line,1);
else
    error('请输入一维数组 ！');
end

%%
% 求峰值
peak=max(line);
peakPos = find(line==peak);
peakPos = mean(peakPos);

if isFitting==1
%求出最大的五个值，使用该五个值来拟合出一个抛物线求峰值
    peakValue=max(line);
    index = find(line==peakValue);
    %i用于计数
    i=1;
    line_t=line;
    x=index;
    y=peakValue;
    for j=1:(size(index,2)-1)
       y=[y,peakValue];
       i = i+1;
    end;

   while i<3
      index= line_t<peakValue;
      line_t = line_t(index);
      peakValue= max(line_t);
      %查找该数在原序列中的索引
      index=find(line==peakValue);
      x=[x,index];
      for j=1:size(index,2)
          y=[y,peakValue];
          i=i+1;
      end
   end
   x=[x,min(x)-1,max(x)+1];
   y=[y,line(min(x)),line(max(x))];
%    disp(x);
%    disp(y);
   
   b=polyfit(x,y,2);
   peak=-b(2)*b(2)/4/b(1)+b(3);
   peakPos=-b(2)/2/b(1);
end
disp('peak=');
disp(peak);
disp('peak position=');
disp(peakPos);

%%
%计算半高宽fwhm与十分之一高宽fwtm
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

 
fwhmValue=fwhm(1,2)-fwhm(1,1);
fwtmValue=fwtm(1,2)-fwtm(1,1);
disp('FWHM=');
disp(fwhmValue);
disp('FWTM=');
disp(fwtmValue);

%%
%绘制图形，并标注半高宽，十分之一高宽
if isPlot==1   
    plot(1:size_line,line);
    title('system spatial resolution');
    hold on;
    xlabel('pixel');
    ylabel('count');
    grid on
    
    xh=min(fwhm):0.01:max(fwhm);
    xt=min(fwtm):0.01:max(fwtm);
    yh=peak/2*ones(1,size(xh,1));
    yt=peak/10*ones(1,size(xt,1));
    text(max(fwhm)+1,peak/2,num2str(fwhmValue));
    %text(max(fwtm)+2,peak/10,num2str(fwtmValue));
    
    plot(xh,yh,'r','linewidth',2);
    %plot(xt,yt,'r','linewidth',2);
    
    if isFitting==1
        %plot(x,y,'o');
        xp=min(x):0.01:max(x);
        yp=b(1)*xp.*xp+b(2)*xp+b(3);
        plot(xp,yp,'r','linewidth',2);
    else
        plot(find(line==peak),peak,'*r');
    end
    text((max(fwhm)+min(fwhm))/2+3,peak,num2str(peak));
    
end

%plot(x,y);
