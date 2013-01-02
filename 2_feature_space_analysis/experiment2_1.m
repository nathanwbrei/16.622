% % % % % % % % % % % % % % % % % % % % % % % % %
%
% Experiment script 2.1: Slicing feature space
% by Nathan Brei
% n_brei@mit.edu
%
% 16.62x Project
% Partner: Bo Han
% Advisor: Moe Win
%
% % % % % % % % % % % % % % % % % % % % % % % % %

clear all; close all; clc;
disp ' '
disp ['2.1: 2D slices of feature space, with decision boundaries']
disp '-----------------------------------------------------------'
disp ' '

% Load our complete data set
load /Users/nbrei/Desktop/62x/data-complete.mat
alldata=everything(1:28072);


% Extract experiment set
selectFcn = @(sample) (sample.env==1);
%selectFcn = @(sample) (1);
thisdata=select(alldata,selectFcn);
[X, Y,Z]=construct(thisdata);
Xbackup = X;

X = randintrlv(X,22);       % We shuffle the samples
Y = randintrlv(Y,22);       % Seed -> Randintrlv shuffles in same order

figure; 

% Repeat for each combination of features 
choices=nchoosek(1:6,2);
for k=1:15
	
	% Only use the two features from this time around
	Xtrim = [X(:,choices(k,1)) X(:,choices(k,2))];


	Xtrain = Xtrim(1:50,:);         % Partition our dataset into training...
	Ytrain = Y(1:50,1:11);		% Write another function to remove unused Y cols
	Xtest = Xtrim(50:end,:);        % ... and testing datasets.
	Ytest = Y(50:end,1:11);

	% Train
	[tr a]=train(mc_svm(kernel('rbf',.035)),data(Xtrain,Ytrain));

	% Test
	tst=test(a,data(Xtest,Ytest));         

	% Tabulate results
	[successrate, resultstable] = results(tst)
	
	subplot(3,5,k);
	plot(a);
	title(['Feature ' int2str(choices(k,1)) ' vs ' int2str(choices(k,2))]);

end


featurespace(thisdata, Xbackup,500)