%%Data import
Data_wifi_6 = Data_wifi_T_STA ;
Data_wifi_5 = Data_wifi_V_STA;

%% 
ds = dataset(Data_wifi_6,Data_wifi_5);
ds.Properties.VarNames(:)
plot(ds(:,1),ds(:,2));set(In,'color','blue')

%% Measure the widths again, this time using the half height as reference.
findpeaks(Data_wifi_5,'Annotate','extents','MinPeakProminence',0.002)


%% Number and Location of peaks
[pks,locs]=findpeaks(Data_wifi_5,'MinPeakProminence',0.002); % 0.002 for sta -
% calculate the distance between the peaks
MeanDistancePks=mean(diff(locs));
NoOFPeaksIn1S = size(locs);
display(sprintf('\n Number Activity peaks %f average in second \n',MeanDistancePks/100000));

findpeaks(Data_wifi_5,'MinPeakProminence',0.01);
text(locs+0.2,pks,num2str((1:numel(pks))'))

%% Limit the number of peaks displayed
%%So Weak
[pks20,locs20]=findpeaks(Data_wifi_5,'NPeaks',20,'MinPeakProminence',0.002);
findpeaks(Data_wifi_5,'NPeaks',20,'MinPeakProminence',0.002)
title('First 20 peaks in Experiment5')
% xlim([0 16]);

%%  returns the widths of the peaks as the vector w and the prominences of the peaks as the vector p.
[pks,locs,WidthsOfPeaks,PromsOfPeaks] = findpeaks(Data_wifi_5,'MinPeakProminence',0.002);
WidthsOfPeaks;
PromsOfPeaks;

%% Threshold
findpeaks(Data_wifi_5,'Annotate','extents','Threshold',0.078)
%findpeaks(Data_wifi_5,'Threshold',0.078)
ThresholdOfStaPeaks = 0.0795;


