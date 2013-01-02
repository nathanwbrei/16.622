% % % % % % % % % %% % % % % % % % % % % % % % %
% Script to select samples which satisfy a user-specified condition
%
% by Nathan Brei
% n_brei@mit.edu
%
% 16.62x Project
% Partner: Bo Han
% Advisor: Moe Win
% % % % % % % % % %% % % % % % % % % % % % % % %

% Inputs:  indata=       Array of struct containing waveform parameters and
%                      metric, should be created automatically by capture()
%          selectFcn=  Anonymous Boolean function that returns true if 
%                      sample (which is an element of data) satisfies 
%                      arbitrary conditions

function [outdata] = select(indata, selectFcn)

% Default/sample selectFcn
if (nargin<2)
    selectFcn = @(sample) (sample.env==1);
end

% Create output data array
outdata(27500,1) = struct('env',[], 'loc',[],'bar',[], 'sam',[], 'met',[]);
count=0;

% Run through each indata sample, add to outdata if it conforms to condition
for x=1:length(indata)
	if (selectFcn(indata(x)) & ~(isnan(indata(x).met(6))))   
		count = count+1;
		outdata(count) = indata(x);
    end
end

% Trim outdata
outdata=outdata(1:count,:);

fprintf( '%d samples selected.\n', count);
