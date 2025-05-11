%Peak Analysis
fs =100000;
Data_wifi_9 = Data_wifi_STA_T(280000:300000);                                                                                                                                                                                                                                                                                                                              
Data_wifi_8 =Data_wifi_STA_V(280000:300000);
MinPeakProminence =0.002 ; % STA =0.002; AP=0.01 Bluetooth=0.009
MinPeakHeight = 0.0789; % STA = 0.0789 ;AP =0.3 %BL_Pair=0.05 %BL_Unpair=0.06
%% Finding Maxima or Peaks
%load Experiment.dat
ds = dataset(Data_wifi_9,Data_wifi_8);
ds.Properties.VarNames(:)
%In = plot(ds(:,1),ds(:,2));set(In,'color','blue');
Time = ds(:,1);
Voltage =ds(:,2);
%findpeaks(ds(:,2),ds(:,1));
%% Measuring Distance Between Peaks
[Pks_PP, lock_PP] = findpeaks(Data_wifi_8,'MinPeakProminence',MinPeakProminence,'MinPeakHeight',MinPeakHeight);
findpeaks(Data_wifi_8,'Annotate','extents','MinPeakProminence',MinPeakProminence,'MinPeakHeight',MinPeakHeight)
text(lock_PP+0.2,Pks_PP,num2str((1:numel(Pks_PP))'))
xlabel('Time');
ylabel('Voltage in Experiment')
title('Find All Peaks');

 maxpeak1 = dsp.Maximum;
[max_peak, max_Locpeak] = step(maxpeak1, Pks_PP);

 minpeak1 = dsp.Minimum;
[min_peak, min_Locpeak] = step(minpeak1, Pks_PP);


figure
peakInterval = diff(lock_PP)/fs;
hist(peakInterval);
grid on
xlabel('Time');
ylabel('Frequency of Occurrence')
title('Histogram of Peak Intervals in 10microSecond')
figure
plot(Data_wifi_9,Data_wifi_8,Data_wifi_9(lock_PP),Pks_PP,'or')
text(lock_PP+0.2,Pks_PP,num2str((1:numel(Pks_PP))'))

NoPeaks = size(Pks_PP);
NoOFPeaks = NoPeaks(:,1);
cycles = diff(lock_PP);
cmax1 = dsp.Maximum;
 max_cycles = (step(cmax1, cycles))/fs;
%max_cycles = (max(cycles))/fs;
min_cycles = (min(cycles))/fs;
%AverageDistance_Peaks
Mmean1 = dsp.Mean;
 meanCycle = (step(Mmean1, cycles))/fs;
%meanCycle = mean(cycles);
%% Finding Peaks in Clipped or Saturated Signals
load clippedpeaks.mat

figure

% Show all peaks in the first plot
ax(1) = subplot(2,1,1);
findpeaks(Data_wifi_8);
xlabel('Samples')
ylabel('Amplitude')
title('Detecting Saturated Peaks')

% Specify a minimum excursion in the second plot
ax(2) = subplot(2,1,2);
findpeaks(Data_wifi_8,'Threshold',MinPeakHeight)
xlabel('Samples');
ylabel('Amplitude')
title('Filtering Out Saturated Peaks')

% link and zoom in to show the changes
linkaxes(ax(1:2),'xy');
axis(ax,[0 7 0 0.5])
%% Thresholding to Find Peaks of Interest
findpeaks(Data_wifi_8,'MinPeakHeight',MinPeakHeight,'MinPeakDistance',MinPeakProminence)
%% returns the widths of the peaks as the vector w and the prominences of the peaks as the vector p.
[Pks_PP, lock_PP,WidthsOfPeaks,PromsOfPeaks] = findpeaks(Data_wifi_8,'MinPeakProminence',MinPeakProminence);

wmax1 = dsp.Maximum;
 max_WidthsOfPeaks = (step(wmax1, WidthsOfPeaks))/fs;
 %max_WidthsOfPeaks = (max(wmax))/fs;
wmin1 = dsp.Minimum;
 min_WidthsOfPeaks = (step(wmin1, WidthsOfPeaks))/fs;
 %min_WidthsOfPeaks = (min(WidthsOfPeaks))/fs;
WidthsOfPeaks;

pmax1 = dsp.Maximum;
 max_PromsOfPeaks = (step(pmax1, PromsOfPeaks))/fs;
pmin1 = dsp.Minimum;
 min_PromsOfPeaks = (step(pmin1, PromsOfPeaks))/fs;
  %max_WidthsOfPeaks = (max(pmax))/fs;
%max_PromsOfPeaks = (max(PromsOfPeaks))/fs;
%min_PromsOfPeaks = (min(PromsOfPeaks))/fs;
PromsOfPeaks;


%% Limit the number of peaks displayed
%%So Weak
[pks10,locs10]=findpeaks(Data_wifi_8,'NPeaks',10,'MinPeakProminence',MinPeakProminence);
findpeaks(Data_wifi_8,'NPeaks',10,'MinPeakProminence',MinPeakProminence)
text(locs10+0.2,pks10,num2str((1:numel(pks10))'))
title('First 10 peaks')

%% Smoothness
smoothVoltage = sgolayfilt(Data_wifi_8,7,21);

figure
plot(Data_wifi_9,Data_wifi_8,'b',Data_wifi_9,smoothVoltage,'r'); grid on
axis tight;
xlabel('Samples'); ylabel('Voltage(V)');
legend('Noisy Signal','Filtered Signal')
title('Filtering Noisy Voltage Signal')

% Values of the Extrema
[pks,locs_point] = findpeaks(Data_wifi_8,'MinPeakProminence',MinPeakProminence);
[val_Point] = deal(smoothVoltage(locs_point));

meanError_point = mean2((Data_wifi_8(locs_point) - val_Point));
meanError_point;

