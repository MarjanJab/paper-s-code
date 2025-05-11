%%
%Peak Analysis
 fs =100000;
Data_wifi_9 = Data_wifi_T();                                                                                                                                                                                                                                                                                                                              
Data_wifi_8 = Data_wifi_V();
 MinPeakProminence =0.1 ; 
 MinPeakHeight =0.07; 


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
[Pks_PP, lock_PP,WidthsOfPeaks,PromsOfPeaks] = findpeaks(Data_wifi_8,'MinPeakHeight',MinPeakHeight);

%findpeaks(select,Fs,'MinPeakHeight',1)
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


%% mean(): Mean value
  hmean1 = dsp.Mean;
  mean = step(hmean1,Data_wifi_8);

%% std(): Standard deviation 

%  hstd2 = dsp.StandardDeviation;
%  hstd2.RunningStandardDeviation = true;
%  std= step(hstd2,Data_wifi_8); 
std=std2(Data_wifi_8);
%% mad(): Mean or median absolute deviation
mad = mad(Data_wifi_8);
%% max(): Largest value in array
% maxInds(): index of the frequency component with largest magnitude
% Maximum
 hmax1 = dsp.Maximum;
 [max_val,max_loc] = step(hmax1, Data_wifi_8);
 max_val;
 max_loc =max_loc/fs;
 %% min(): Smallest value in array
 hmin1 = dsp.Minimum;
 [min_val, min_loc] = step(hmin1, Data_wifi_8);
 min_val;
 min_loc = min_loc/fs;

 %% energy(): Energy measure. Sum of the squares divided by the number of values.
 %dboutput = db(X,'voltage',R)
 dboutput = db(Data_wifi_8);
 hmax3 = dsp.Maximum;
 Max_dboutput = step(hmax3, dboutput);
  hmin2 = dsp.Minimum;
 Min_dboutput= step(hmin2, dboutput);

 %% iqr(): Interquartile range - Return interquartile range (IQR) for ProbDistUnivParam object
 iqr = iqr(Data_wifi_8);

 %% meanFreq(): Weighted average of the frequency components to obtain a mean frequency
 
 meanfreq = meanfreq(Data_wifi_8,fs);
 
 %% skewness(): skewness of the frequency domain signal 
 skewness = (skewness(Data_wifi_8))/fs;
 
 %% kurtosis(): kurtosis of the frequency domain signal 
kurtosis = kurtosis(Data_wifi_8);
 
 %% RMS Root-mean-square level
 hrms2 = dsp.RMS;
 rms= step(hrms2,Data_wifi_8);
 
 %% 
 hd = dfilt.fftfir(Data_wifi_8,300000);
c=fftcoeffs(hd);


%% mean(): Mean value
%   hmean1 = dsp.Mean;
%   mean = step(hmean1,Data_wifi_8);
    mean = mean2(Data_wifi_8);
%% std(): Standard deviation 

%   hstd2 = dsp.StandardDeviation;
%   hstd2.RunningStandardDeviation = true;
%   std= step(hstd2,Data_wifi_8); 
   std = std2(Data_wifi_8);

%% Variance
 %hvar = dsp.Variance;
 %hvar.RunningVariance = true;
 %variance = step(hvar, Data_wifi_8); 
 variance = var(Data_wifi_8,'omitnan');

 
%% Magnitude
%fvtool(Data_wifi_8);

%% Maximum
%max(): Largest value in array
% maxInds(): index of the frequency component with largest magnitude
 hmax1 = dsp.Maximum;
 [max, max_In] = step(hmax1, Data_wifi_8);
 max;
 max_In;
%% FFT coefficients (Frequency-domain coefficients)
 hd = dfilt.fftfir(Data_wifi_8,300000);
c=fftcoeffs(hd);
%c'
%% %% Smoothness
Data_wifi_8_smoothy = sgolayfilt(Data_wifi_8,7,21);

figure
plot(Data_wifi_9,Data_wifi_8,'b',Data_wifi_9,Data_wifi_8_smoothy,'r'); grid on
axis tight;
xlabel('Samples'); ylabel('Voltage(V)');
legend('Noisy Signal','Filtered Signal')
title('Filtering Noisy Voltage Signal')


%% Extract Features of a Clock Signal
%Use statelevels to find the lower and upper levels of the signal by means of a histogram

levels = statelevels(Data_wifi_8);

statelevels(Data_wifi_8);

[Rise,LoTime,HiTime,LoLev,HiLev] = risetime(Data_wifi_8,Data_wifi_9);
Levels = [LoLev HiLev; (levels(2)-levels(1))*[0.1 0.9]+levels(1)];
risetime(Data_wifi_8,fs);
overshoot(Data_wifi_8,fs);
Rise = mean2(Rise);

[pctgs,values,times] = undershoot(Data_wifi_8,fs);

hold on
text(1.1e-3,0.4,'     Undershoot','Background','w','Edge','k')
plot([times;1.17e-3],[values;0.01],'^m')
hold off

%% Find the period of the signal.
%By default, the period is defined as the time elapsed between consecutive rising crossings of the reference level halfway between the state levels.
%You can change the polarity of the crossings, specify the state levels, or adjust the reference level.

per = pulseperiod(Data_wifi_8,Data_wifi_9);
per = mean2(per);
pulseperiod(Data_wifi_8,fs,'Polarity','negative','MidPct',25);

%% 
%The duty cycle is the ratio of pulse width to pulse period. Determine it directly or using a dedicated function.
dut = dutycycle(Data_wifi_8,fs);
dut = mean2(dut);
wdt = pulsewidth(Data_wifi_8,fs);
wdt = mean2(wdt);
%compare = [wdt./per dut];


%% pwelch works by dividing the signal into overlapping segments, computing the periodogram of each segment, and averaging.
%By default, the function uses eight segments with 50% overlap
%pwelch(Data_wifi_V_AP,[],[],[],fs);
%hold on
pwelch(Data_wifi_8,[],[],[],fs);
%hold on
%pwelch(Data_wifi_V_ApSta,[],[],[],fs);


%% Measure the Power of a Signal

obw(Data_wifi_8,fs);

[wd,lo,hi,power] = obw(Data_wifi_8,fs);
powtot = power/0.99;
[bw,flo,fhi,power] = powerbw(Data_wifi_8);
pRMS = rms(Data_wifi_8)^2;


%% Find Periodicity Using Frequency Analysis
Data = Data_wifi_8- mean2(Data_wifi_8);

[pxx,frequent] = periodogram(Data,[],[],fs);


%% Extracting Classification Features from Physiological Signals

fs = 100000;
midcross = midcross(Data_wifi_8,fs,'tolerance',15);
xlim([0 1])
xlabel('Sample Number')
ylabel('mV')
%% %%

fs=100000;
Data = Data_wifi_8-mean2(Data_wifi_8);
[autocor,lags] = xcorr(Data,fs,'coeff');

plot(lags/fs,autocor)
xlabel('Lag (days)')
ylabel('Autocorrelation')

%% Obtain the total harmonic distortion of the input signal in dB. Specify that ten harmonics are used in calculating the THD. This includes the fundamental frequency of 1 kHz.
%Input the sampling frequency of 44.1 kHz.Determine the frequencies of the harmonics and their power estimates.

nharm = 10;
[thd_db,harmpow,harmfreq] = thd(Data_wifi_8,fs,nharm);

%The function thd outputs the total harmonic distortion in dB. Convert the measurement from dB to a percentage to compare the value against the manufacturer's claims.

percent_thd = 100*(10^(thd_db/20));

%The value you obtain indicates that the manufacturer's claims about the THD for speaker model A are correct.
%You can obtain further insight by examining the power (dB) of the individual harmonics.

T = table(harmfreq,harmpow,'VariableNames',{'Frequency','Power'});
%% Plot the signal spectrum and annotate the total harmonic distortion (THD).
%The thd function computes the power ratio of the harmonics to the fundamental and ignores the DC component and the noise floor.

thd = thd(Data_wifi_8,fs,nharm);

%% Plot the signal spectrum and annotate the SNR, verifying that it has the expected value.
%The snr function computes the power ratio of the fundamental to the noise floor and ignores the DC component and the harmonics.

snr = snr(Data_wifi_8,fs);


%% Plot the signal spectrum and annotate the signal to noise and distortion ratio (SINAD). 
%The sinad function computes the power ratio of the fundamental to the harmonics and the noise floor. It ignores only the DC component.

sinad = sinad(Data_wifi_8,fs);

%% Plot the signal spectrum and annotate the spurious-free dynamic range (SFDR).
%The SFDR is the power ratio of the fundamental to the strongest spurious component ("spur"). In this case, the spur corresponds to the third harmonic.
sfdr = sfdr(Data_wifi_8,fs);

%% 

% Verify that the SNR, THD, and SINAD obey the equation

%   10^{-{\tt SNR}/10}+10^{{\tt THD}/10}=10^{-{\tt SINAD}/10}.%

lhs = 10^(-snr(Data_wifi_8,fs)/10)+10^(thd(Data_wifi_8,fs)/10);
rhs = 10^(-sinad(Data_wifi_8,fs)/10);

