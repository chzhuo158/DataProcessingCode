function [pks,locs]= cz_findpeak(signal)
% pks is the pulse height. 
% locs is the location of the coresponding pks.
% signal is the signal that is going to be processed.
rough_peak_location = find (signal<4000);
pks_count = 0;
thr = 400;
pks = [];
locs = [];
for num = 1:length(rough_peak_location)
    if (rough_peak_location(num)<thr)
          if (signal(rough_peak_location(num))==min(signal(1:num+thr)))
            pks_count =pks_count + 1;
            locs(pks_count) = rough_peak_location(num);
            pks(pks_count) = signal(rough_peak_location(num));
        end
    end
    
    if ( (rough_peak_location(num)>thr) && (rough_peak_location(num)+thr<= length(signal) ) )%boundary check
        if (signal(rough_peak_location(num))==min(signal(rough_peak_location(num)-thr:rough_peak_location(num)+thr)))
            pks_count =pks_count + 1;
            locs(pks_count) = rough_peak_location(num);
            pks(pks_count) = signal(rough_peak_location(num));
        end
    end
     
end
