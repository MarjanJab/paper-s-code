%Find Periodicity Using Autocorrelation
fs=100000;
Data_wifi_8 = Data_power;
Data_wifi_9 =Data_wifi_T;
Data_wifi_2 = Data_wifi_T;


%% Extract Features of a Clock Signal
%Use statelevels to find the lower and upper levels of the signal by means of a histogram

levels = statelevels(Data_wifi_8);

statelevels(Data_wifi_8);

[Rise,LoTime,HiTime,LoLev,HiLev] = risetime(Data_wifi_8,Data_wifi_9);
Levels = [LoLev HiLev; (levels(2)-levels(1))*[0.1 0.9]+levels(1)];
risetime(Data_wifi_8,fs);
overshoot(Data_wifi_8,fs);

[pctgs,values,times] = undershoot(Data_wifi_8,fs);

hold on
text(1.1e-3,0.4,'     Undershoot','Background','w','Edge','k')
plot([times;1.17e-3],[values;0.08],'^m')
title('Signal Features of WiFi Access Point Mode')
xlabel('Time(s)')
ylabel('Power(w) ')
set(gcf,'color','w');
hold off

%% Find the period of the signal.
%By default, the period is defined as the time elapsed between consecutive rising crossings of the reference level halfway between the state levels.
%You can change the polarity of the crossings, specify the state levels, or adjust the reference level.

per = pulseperiod(Data_wifi_8,Data_wifi_9);
pulseperiod(Data_wifi_8,fs,'Polarity','negative','MidPct',25)
title('Signal Features of WiFi Access Point Mode')
xlabel('Time(s)')
ylabel('Power(w) ')
set(gcf,'color','w');

%% 
%The duty cycle is the ratio of pulse width to pulse period. Determine it directly or using a dedicated function.
dut = dutycycle(Data_wifi_8,fs);

wdt = pulsewidth(Data_wifi_8,fs);

compare = [wdt./per dut];


%% pwelch works by dividing the signal into overlapping segments, computing the periodogram of each segment, and averaging.
%By default, the function uses eight segments with 50% overlap
%pwelch(Data_wifi_V_AP,[],[],[],fs);
%hold on
pwelch(Data_wifi_V_STA,[],[],[],fs);
%hold on
%pwelch(Data_wifi_V_ApSta,[],[],[],fs);


%% Measure the Power of a Signal

obw(Data_wifi_8,fs);

[wd,lo,hi,power] = obw(Data_wifi_8,fs);
powtot = power/0.99;
pRMS = rms(Data_wifi_8)^2;

%% Find Periodicity Using Frequency Analysis
Data = Data_wifi_8- mean(Data_wifi_8);

[pxx,frequent] = periodogram(Data,[],[],fs);


%% Extracting Classification Features from Physiological Signals

fs = 100000;
midcross(Data_wifi_8,fs,'tolerance',25);
xlim([0 1])
xlabel('Sample Number')
ylabel('mV')
%% %%

fs=100000;
Data = Data_wifi_8-mean(Data_wifi_8);
[autocor,lags] = xcorr(Data,fs,'coeff');

plot(lags/fs,autocor)
xlabel('Lag (days)')
ylabel('Autocorrelation')
%% 
[pksh,lcsh] = findpeaks(autocor);
short = mean(diff(lcsh))/fs;

[pklg,lclg] = findpeaks(autocor, ...
    'MinPeakDistance',ceil(short)*fs,'MinPeakheight',0.1);
long = mean(diff(lclg))/fs;
hold on
pks = plot(lags(lcsh)/fs,pksh,'or', ...
    lags(lclg)/fs,pklg+0.05,'vk');
hold on
legend(pks,[repmat('Period: ',[2 1]) num2str([short;long],0)])
%% %% 

%Determine how fast the signal falls using falltime.
%You can set the state levels and the percentage reference levels manually. You can do the same with risetime.

falltime(Data_wifi_8,Data_wifi_9, ...
    'PercentReferenceLevels',[30 80],'StateLevels',[0 1]);


%% Compare the Frequency Content of Two Signals

[P1,f1] = periodogram(Data_wifi_2,[],[],fs,'power');
[P2,f2] = periodogram(Data_wifi_8,[],[],fs,'power');

subplot(2,1,1)
plot(f1,P1,'k')
grid
ylabel('P_1')
title('Power Spectrum')

subplot(2,1,2)
plot(f2,P2,'r')
grid
ylabel('P_2')
xlabel('Frequency (Hz)')
%% 

[pk1,lc1] = findpeaks(P1,'SortStr','descend','NPeaks',4);
P1peakFreqs = f1(lc1);

[pk2,lc2] = findpeaks(P2,'SortStr','descend','NPeaks',4);
P2peakFreqs = f2(lc2);

[Cxy,f] = mscohere(Data_wifi_2,Data_wifi_8,[],[],[],fs);

thresh = 0.1;
[pks,locs] = findpeaks(Cxy,'MinPeakHeight',thresh);
MatchingFreqs = f(locs);

figure
plot(f,Cxy)
ax = gca;
grid
xlabel('Frequency (Hz)')
title('Coherence Estimate')
ax.XTick = MatchingFreqs;
ax.YTick = thresh;

%% Periodogram

periodogram(Data_wifi_8,[],max(size(Data_wifi_8)),fs);

helperPlotPeriodogram(Data_wifi_8, fs, 'power','annotate');


