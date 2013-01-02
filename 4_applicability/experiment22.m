% % % % % % % % % % % % % % % % % % % % % % % % %
%
% Experiment script #22: RW Applicability
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
disp ' Experiment 22: Train on one location'
disp ' '
disp '--------------------------------------------'
disp ' '

% Load our (preliminary) complete data set
load /Users/nbrei/Desktop/62x/data-complete.mat

alldata=everything(1:28072);

% Extract experiment set
selectFcn1 = @(sample) (sample.env==2 && sample.loc==2);
selectFcn2 = @(sample) (sample.env==2 && sample.loc ~= 2);

[X1, Y1, Z1]=construct(select(alldata,selectFcn1));
[X2, Y2, Z2]=construct(select(alldata,selectFcn2));

X1 = randintrlv(X1,22);       % We shuffle the samples
Y1 = randintrlv(Y1,22);       % Seed -> Randintrlv shuffles in same order
X2 = randintrlv(X2,22);       % We shuffle the samples
Y2 = randintrlv(Y2,22);       % Seed -> Randintrlv shuffles in same order

Xtrain = X1(1:200,:);         % Partition our dataset into training...
Ytrain = Y1(1:200,1:11);		% Write another function to remove unused Y cols
Xtest = X2(201:end,:);        % ... and testing datasets.
Ytest = Y2(201:end,1:11);

% Train
[tr a]=train(mc_svm(kernel('rbf',0.01)),data(Xtrain,Ytrain));

% Test
tst=test(a,data(Xtest,Ytest));         

% Tabulate results
[successrate, resultstable] = results(tst);

% Generate plot
axeslabels = {'Plywood 1','Plywood 2','Drywall 1','Drywall 2','Sheetmetal 1',...
			  'Sheetmetal 2','Foam 1','Foam 2','Glass 1','Glass 2','LOS'};
visualize(resultstable, axeslabels, 'env1-all.tex', 0);

resultstable
successrate