% % % % % % % % % %% % % % % % % % % % % % % % %
%
% Waveform retrieval function
% by Nathan Brei
% n_brei@mit.edu
%
% 16.62x Project
% Partner: Bo Han
% Advisor: Moe Win
%
% % % % % % % % % %% % % % % % % % % % % % % % %
%
% function waveform = retrieve(path)
%
% This function extracts a waveform [array of ints] from the text file
% that the PulsOn software generates.
% Inputs:    path = string giving location of waveform file
% Outputs:   waveform = array of ints

function waveform = retrieve(path)

data = 0;
num = 0;
counter = 0;

% Open file
fid = fopen(path);

% Create matrix. PulsOn will probably give us 1472 data points.
waveform = zeros(1472,1);
num = fgetl(fid);

while num ~= -1 

    % If we are reading the data, add the data to the output matrix
    if data
        counter = counter+1;
        waveform(counter,1) = str2num(num);
  
    % Ignore header info for now. Eventually put in a struct if needed.
    elseif (strcmp(num,'Data'))
        data = 1;
    end
    
    % Read next line
    num = fgetl(fid);

end
    
fclose(fid);
%disp(sprintf('%s: Successfully read %d data points.',path,counter));
%plot(waveform);

end
