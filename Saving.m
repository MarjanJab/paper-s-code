
% Path of current function
fcnpath = mfilename('fullpath');

% Default source path for original data
   bs = strfind(fcnpath, '\');
%  defaultOriginalDataPath = fullfile(fcnpath(1:bs(end)-1),'Original');

% Define destination path
destDataPath = fullfile(fcnpath(1:bs(end)-1),'EnergyData');

% Save large structure with unbuffered data to file
fprintf('Saving unbuffered data...')
save(fullfile(destDataPath,'BufferFeaturesOfPaper.mat'),...
    'mean','std','mad','max_val',' min_val','Min_dboutput','Max_dboutput','FFTcoeff');
fprintf('Done.\n')