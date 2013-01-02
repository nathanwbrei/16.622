% % % % % % % % % %% % % % % % % % % % % % % % %
% Function to merge two barrier types into a single class 
% Note that you still need to manually remove the frombar column
% from construct.m's Y output
%
% by Nathan Brei
% n_brei@mit.edu
%
% 16.62x Project
% Partner: Bo Han
% Advisor: Moe Win
% % % % % % % % % %% % % % % % % % % % % % % % %

% Inputs:  indata=     Array of struct containing waveform parameters/metrics
%          frombar=    Barrier to be reassigned as
%		   tobar
% Outputs: outdata=	   Array just like indata, ready for construct.m

function [outdata] = merge(indata, frombar, tobar)

outdata = indata;
count = 0;

% Run through each sample, see if it conforms to specified condition
for i=1:length(outdata)
	if(outdata(i).bar==frombar)
		outdata(i).bar = tobar;
		count = count + 1;
	end
end

fprintf('%d samples merged.\n', count);

