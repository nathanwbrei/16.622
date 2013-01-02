% % % % % % % % % % % % % % % % % % % % % % % % %
%
% Experiment script #28: Histograms of feature space
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
disp ' Experiment 28: Histograms of feature space'
disp ' '
disp '--------------------------------------------'
disp ' '

close all;
load /Users/nbrei/Desktop/62x/data-complete.mat
alldata=everything(1:28072);

% Dataset partitions 
selectFcn{1} = @(sample) (1);
selectFcn{2} = @(sample) (sample.env==2);
selectFcn{3} = @(sample) (sample.env==2 && sample.loc == 1);
selectFcn{4} = @(sample) (sample.env==2 && sample.loc == 2);
selectFcn{5} = @(sample) (sample.env==2 && sample.loc == 3);
selectFcn{6} = @(sample) (sample.env==2 && sample.loc == 4);
selectFcn{7} = @(sample) (sample.bar<5);
selectFcn{8} = @(sample) (sample.bar==1 || sample.bar==11);

% Figure titles
titles = {'All data', 'Single environment', 'Single location 2.1','Single location 2.2','Single location 2.3','Single location 2.4', 'Reduced barrier set', 'Plywood vs LOS'};

for p=1:length(selectFcn)
	
	thisdata=select(alldata,selectFcn{p});
	Y = construct(thisdata);
	
	figure; set(gcf,'Color','w');

	for g=1:6
		subplot(230+g);
		featurehist(thisdata,g, Y);
	end
	legend({'Plywood 1','Plywood 2','Drywall 1','Drywall 2','Sheetmetal 1',...
			  'Sheetmetal 2','Foam 1','Foam 2','Glass 1','Glass 2','LOS'});
			
	subplot(232);
	title(['Stacked histograms: ' char(titles{p})]);	
end