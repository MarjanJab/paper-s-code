
% Data Prepration

Data_wifi_6 = Data_wifi_STA_T(280000:300000);
Data_wifi_5 = Data_wifi_STA_V(280000:300000);
fs=100000;

%% mean(): Mean value
  hmean1 = dsp.Mean;
  mean = step(hmean1,Data_wifi_5);

%% std(): Standard deviation 

%  hstd2 = dsp.StandardDeviation;
%  hstd2.RunningStandardDeviation = true;
%  std= step(hstd2,Data_wifi_5); 
std=std2(Data_wifi_5);
%% mad(): Mean or median absolute deviation
mad = mad(Data_wifi_5);
%% max(): Largest value in array
% maxInds(): index of the frequency component with largest magnitude
% Maximum
 hmax1 = dsp.Maximum;
 [max_val,max_loc] = step(hmax1, Data_wifi_5);
 max_val;
 max_loc =max_loc/fs;
 %% min(): Smallest value in array
 hmin1 = dsp.Minimum;
 [min_val, min_loc] = step(hmin1, Data_wifi_5);
 min_val;
 min_loc = min_loc/fs;

 %% energy(): Energy measure. Sum of the squares divided by the number of values.
 %dboutput = db(X,'voltage',R)
 dboutput = db(Data_wifi_5);
 hmax3 = dsp.Maximum;
 Max_dboutput = step(hmax3, dboutput);
  hmin2 = dsp.Minimum;
 Min_dboutput= step(hmin2, dboutput);

 %% iqr(): Interquartile range - Return interquartile range (IQR) for ProbDistUnivParam object
 iqr = iqr(Data_wifi_5);

 %% meanFreq(): Weighted average of the frequency components to obtain a mean frequency
 
 meanfreq = meanfreq(Data_wifi_5,fs);
 
 %% skewness(): skewness of the frequency domain signal 
 skewness = (skewness(Data_wifi_5))/fs;
 
 %% kurtosis(): kurtosis of the frequency domain signal 
kurtosis = kurtosis(Data_wifi_5);
 
 %% RMS Root-mean-square level
 hrms2 = dsp.RMS;
 rms= step(hrms2,Data_wifi_5);
 
 %% 
 hd = dfilt.fftfir(Data_wifi_5,300000);
c=fftcoeffs(hd);



 

