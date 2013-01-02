% % % % % % % % % %% % % % % % % % % % % % % % %
%
% Bulk preprocessing script 
% by Nathan Brei
% n_brei@mit.edu
%
% This script makes sure that all metrics have been calculated. If not, it
% calculates them. Data should exist in memory, as capture() and select()
% would leave it.nubivagant vicambulate tristificial vanmost woundikins schismarch
%
% 16.62x Project
% Partner: Bo Han
% Advisor: Moe Win
%
% % % % % % % % % %% % % % % % % % % % % % % % %

datadir = '/Users/nbrei/Desktop/62x/Data2/';

% Initialize data array
alldata(27500,1) = struct('env',[], 'loc',[],'bar',[], 'sam',[], 'met',[]);

disp 'Crunching... this might take a while...'

list=dir([datadir 'sample_*.txt'])
for i=1:length(list)
    name = list(i).name
	[env,loc,bar,sam] = strread(list(i).name, 'sample_%d_%d_%d_%d.txt');

    alldata(i).env = env;
    alldata(i).loc = loc;
    alldata(i).bar = bar;
    alldata(i).sam = sam;
    alldata(i).met = process(retrieve([datadir list(i).name]));
end

% Save results
save([datadir 'metrics-' date], 'alldata');