%Peak Analysis
Data_wifi_9 = Data_wifi_Sleep_10_T ;
Data_wifi_8 = Data_wifi_Sleep_10_V;
MinPeakProminence = 0.02 ; % STA =0.002;
MinPeakHeight = 0.0798; % STA=0.0789
%% Finding Maxima or Peaks
%load Experiment.dat
ds = dataset(Data_wifi_9,Data_wifi_8);
ds.Properties.VarNames(:)
%In = plot(ds(:,1),ds(:,2));set(In,'color','blue');
Time = ds(:,1);
Voltage =ds(:,2);
%findpeaks(ds(:,2),ds(:,1));
%% Measuring Distance Between Peaks
findpeaks(Data_wifi_8,'Annotate','extents','MinPeakProminence',MinPeakProminence)
text(lock_PP+0.2,Pks_PP,num2str((1:numel(Pks_PP))'))
xlabel('Time');
ylabel('Voltage in Experiment')
title('Find All Peaks');

figure
[Pks_PP, lock_PP] = findpeaks(Data_wifi_8,'MinPeakProminence',MinPeakProminence);
peakInterval = diff(lock_PP)/100000;
hist(peakInterval);
grid on
xlabel('Time');
ylabel('Frequency of Occurrence')
title('Histogram of Peak Intervals in 10microSecond')
figure
plot(Data_wifi_9,Data_wifi_8,Data_wifi_9(lock_PP),Pks_PP,'or')
text(lock_PP+0.2,Pks_PP,num2str((1:numel(Pks_PP))'))
NoOFPeaksIn1S = size(Pks_PP);
AverageDistance_Peaks = mean(diff(lock_PP));
cycles = diff(lock_PP);
meanCycle = mean(cycles);
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
findpeaks(Data_wifi_8,'Threshold',0.0798)
xlabel('Samples');
ylabel('Amplitude')
title('Filtering Out Saturated Peaks')

% link and zoom in to show the changes
linkaxes(ax(1:2),'xy');
axis(ax,[0 7 0 0.5])
%% Thresholding to Find Peaks of Interest
findpeaks(Data_wifi_8,'MinPeakHeight',0.0798,'MinPeakDistance',MinPeakProminence)
%% returns the widths of the peaks as the vector w and the prominences of the peaks as the vector p.
[Pks_PP, lock_PP,WidthsOfPeaks,PromsOfPeaks] = findpeaks(Data_wifi_8,'MinPeakProminence',MinPeakProminence);
WidthsOfPeaks;
PromsOfPeaks;


%% Limit the number of peaks displayed
%%So Weak
[pks20,locs20]=findpeaks(Data_wifi_8,'NPeaks',20,'MinPeakProminence',MinPeakProminence);
findpeaks(Data_wifi_8,'NPeaks',20,'MinPeakProminence',MinPeakProminence)
text(locs20+0.2,pks20,num2str((1:numel(pks20))'))
title('First 20 peaks in Experiment5')

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

meanError_point = mean((Data_wifi_8(locs_point) - val_Point));
meanError_point;

