% % % % % % % % % % % % % % % % % % % % % % % % %
%
% Experiment script #29: Histograms of feature space--location
% by Nathan Brei
% n_brei@mit.edu
%
% 16.62x Project
% Partner: Bo Han
% Advisor: Moe Win
%
% % % % % % % % % % % % % % % % % % % % % % % % %

disp ' '
disp '--------------------------------------------'
disp ' '
disp ' Experiment 29: Histograms of feature space: LOCATION'
disp ' '
disp '--------------------------------------------'
disp ' '

close all;
clear selectFcn;
load /Users/nbrei/Desktop/62x/data-complete.mat
alldata=everything(1:28072);

% Dataset partitions 
selectFcn{1} = @(sample) (1);
selectFcn{2} = @(sample) (sample.loc==1 && sample.bar == 1);
selectFcn{3} = @(sample) (sample.loc==1 && sample.bar == 6);
selectFcn{4} = @(sample) (sample.loc==1 && sample.bar == 11);

% Figure titles correspond to dataset partitions
titles = {'5 arbitrary locations, from all environments and barriers', '5 locations, plywood barrier', '5 locations, steel barrier', '5 locations, LOS'}
for p=1:length(selectFcn)
	
	thisdata=select(alldata,selectFcn{p});
	Y = constructlocation(thisdata);
	
	figure; set(gcf,'Color','w');

	for g=1:6
		subplot(230+g);
		featurehistenv(thisdata,g, Y);
	end
	legend({'Location 1', 'Location 2', 'Location 3', 'Location 4', 'Location 5', 'Location 6'});
			
	subplot(232);
	title(['Stacked histograms: ' char(titles{p})]);	
end