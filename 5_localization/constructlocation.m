% % % % % % % % % %% % % % % % % % % % % % % % %
% Script to convert a set of samples into a set of 
% Spider classification matrices-- IDing location instead
%
% by Nathan Brei
% n_brei@mit.edu
%
% 16.62x Project
% Partner: Bo Han
% Advisor: Moe Win
% % % % % % % % % %% % % % % % % % % % % % % % %

% Inputs:  data=       Array of struct containing waveform parameters/metrics
% Outputs: X=          Metrics array, digestible by spider
%          Y=          Multiclass labels array

function [X, Y] = constructlocation(thisdata)

% Create (blank) spider input matrices
X=zeros(length(thisdata),6);
Y=zeros(length(thisdata),5);       
locclass = 2*eye(5)-1;     % For generating Y

% Run through each sample, see if it conforms to specified condition
for i=1:length(thisdata)
	X(i,:) = thisdata(i).met;
	Y(i,:) = locclass(thisdata(i).loc,:);
end

% Scale all metrics between 0 and 1
metmax = max(X,[],1);
metmin = min(X,[],1);

for col=1:6
    X(:,col)=(X(:,col)-metmin(col))/(metmax(col)-metmin(col));
end

fprintf( '%d samples scaled.\n', length(X));

