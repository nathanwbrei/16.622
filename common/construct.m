% % % % % % % % % %% % % % % % % % % % % % % % %
% Script to convert a set of samples into a set of 
% Spider classification matrices
%
% by Nathan Brei
% n_brei@mit.edu
%
% 16.62x Project
% Partner: Bo Han
% Advisor: Moe Win
% % % % % % % % % %% % % % % % % % % % % % % % %

% Inputs:  data=       Array of struct containing waveform parameters/metrics
%          losbar=     Controls which bar value gets reported as 1 in Z
% Outputs: X=          Metrics array, digestible by spider
%          Y=          Multiclass labels array
%          Z=          LOSvsNLOS labels array

function [X, Y, Z] = construct(thisdata, losbar)

% Default losbar
if (nargin<2)
	losbar=11;
end

% Create (blank) spider input matrices
X=zeros(length(thisdata),6);
Y=zeros(length(thisdata),11);       
Z=zeros(length(thisdata),1)-1;
barrierclass = 2*eye(11)-1;     % For generating Y

% Run through each sample, see if it conforms to specified condition
for i=1:length(thisdata)
	X(i,:) = thisdata(i).met;
	Y(i,:) = barrierclass(thisdata(i).bar,:);
	if(thisdata(i).bar==losbar)
		Z(i) = 1;
	end
end

% Scale all metrics between 0 and 1
metmax = max(X,[],1);
metmin = min(X,[],1);

for col=1:6
    X(:,col)=(X(:,col)-metmin(col))/(metmax(col)-metmin(col));
end

fprintf( '%d samples scaled.\n', length(X));

