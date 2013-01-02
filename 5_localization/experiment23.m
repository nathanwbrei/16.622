% % % % % % % % % % % % % % % % % % % % % % % % %
%
% Experiment script #23-- Identify location
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
disp ' Experiment 23: Identify from location'
disp ' '
disp '--------------------------------------------'
disp ' '

% Load our (preliminary) complete data set
load /Users/nbrei/Desktop/62x/data-complete.mat

alldata=everything(1:28072);

% Extract experiment set
selectFcn = @(sample) (sample.bar==11 && sample.env~=5);

[X, Y]=constructlocation(select(alldata,selectFcn));

X = randintrlv(X,22);       % We shuffle the samples
Y = randintrlv(Y,22);       % Seed -> Randintrlv shuffles in same order

Xtrain = X(1:200,:);         % Partition our dataset into training...
Ytrain = Y(1:200,1:5);		
Xtest = X(201:end,:);        % ... and testing datasets.
Ytest = Y(201:end,1:5);

% Train
[tr a]=train(mc_svm(kernel('rbf',0.03)),data(Xtrain,Ytrain));

% Test
tst=test(a,data(Xtest,Ytest));         

% Tabulate results
[successrate, resultstable] = results(tst);

% Generate plot
axeslabels = {'Loc1', 'Loc2', 'Loc3', 'Loc4', 'Loc5'};
visualize(resultstable, axeslabels, 'env1-all.tex', 0);

resultstable
successrate