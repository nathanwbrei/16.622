% % % % % % % % % % % % % % % % % % % % % % % % %
%
% Experiment script #24: Only using 2 features
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
disp ' Experiment 24: Only 2 features-- single barrier, different locations'
disp ' '
disp '--------------------------------------------'
disp ' '

% Load our (preliminary) complete data set
load /Users/nbrei/Desktop/62x/data-complete.mat

alldata=everything(1:28072);

% Extract experiment set
selectFcn = @(sample) (sample.env==1 && sample.bar==2);
%selectFcn = @(sample) (1);

thisdata = select(alldata,selectFcn)
[X, Y]=constructlocation(thisdata);
Xbackup = X; 				% Use for featurespace later on

X = [X(:,5) X(:,2)];

X = randintrlv(X,22);       % We shuffle the samples
Y = randintrlv(Y,22);       % Seed -> Randintrlv shuffles in same order

Xtrain = X(1:50,:);         % Partition our dataset into training...
Ytrain = Y(1:50,1:5);		% Write another function to remove unused Y cols
Xtest = X(51:end,:);        % ... and testing datasets.
Ytest = Y(51:end,1:5);

% Train
[tr a]=train(mc_svm(kernel('rbf',.035)),data(Xtrain,Ytrain));

% Test
tst=test(a,data(Xtest,Ytest));         

% Tabulate results
[successrate, resultstable] = results(tst);

% Generate plot
axeslabels = {'Loc1','Loc2','Loc3','Loc4','Loc5'};
visualize(resultstable, axeslabels, 'env1-all.tex', 1);

resultstable
successrate


