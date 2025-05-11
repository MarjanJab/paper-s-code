
% Data Prepration

Data_wifi_5 = Data_wifi_T_STA ;
Data_wifi_6 = Data_wifi_V_STA;
fs=100000;

%% mean(): Mean value
mean = mean(Data_wifi_5)
%% std(): Standard deviation 
std = std(Data_wifi_5)
%% mad(): Mean or median absolute deviation
mad = mad(Data_wifi_5);
%% max(): Largest value in array
% maxInds(): index of the frequency component with largest magnitude
% Maximum
 hmax1 = dsp.Maximum;
 [y, I] = step(hmax1, Data_wifi_5);
 y;
 I;
 %% min(): Smallest value in array
 min = min(Data_wifi_5);
 
 %% sma(): Signal magnitude area
 %Manitude
 plot(Data_wifi_6,abs(Data_wifi_5))
 %return the frequency-domain coefficients used when filtering with the dfilt.fftfir object. c contains the coefficients

 
 %% energy(): Energy measure. Sum of the squares divided by the number of values.
 %dboutput = db(X,'voltage',R)
 dboutput = db(Data_wifi_5);
 
 %% iqr(): Interquartile range - Return interquartile range (IQR) for ProbDistUnivParam object
 iqr = iqr(Data_wifi_5);
 
 %% entropy(): Signal entropy - Entropy of grayscale image
%E = entropy(Data_wifi_5);
 
 %% arCoeff(): Autorregresion coefficients with Burg order equal to 4

 
 %% correlation(): correlation coefficient between two signals

  rho = correlation(array,frequency,elem1,elem2,z0)
 %returns the correlation coefficient between two antenna elements, elem1 and elem2 of an array.
 %% meanFreq(): Weighted average of the frequency components to obtain a mean frequency
 
 meanfreq(Data_wifi_5,fs);
 
 %% skewness(): skewness of the frequency domain signal 
 skewnes = skewness(Data_wifi_5);
 
 %% kurtosis(): kurtosis of the frequency domain signal 
kurtosis = kurtosis(Data_wifi_5);
 
 %% bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
 
 %% RMS
 rms = rms(Data_wifi_5);
 %% 
 hd = dfilt.fftfir(Data_wifi_5,300000);
c=fftcoeffs(hd);
c'



 

