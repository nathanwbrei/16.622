
% % % % % % % % % %% % % % % % % % % % % % % % %
%
% Experiment script #7
% by Nathan Brei
% n_brei@mit.edu
%
% This script does the exact same thing as experiment 5, 
% only the code is cleaner. This _should_ be all we need
% to run the experiment.
%
% 16.62x Project
% Partner: Bo Han
% Advisor: Moe Win
%
% % % % % % % % % %% % % % % % % % % % % % % % %

disp ' '
disp '--------------------------------------------'
disp ' '
disp ' Experiment 7: A clean multiclass example'
disp ' '
disp '--------------------------------------------'
disp ' '

% Load our (preliminary) complete data set
load ../Data/datafile--20-Oct-2010.mat

% Extract experiment set
selectFcn = @(sample) (sample.bar==1 | sample.bar==2 | sample.bar==3);
currentdata=select(alldata,selectFcn);
[X,Y,Z]=construct(currentdata);

X = randintrlv(X,22);       % We shuffle the samples
Y = randintrlv(Y,22);       % Seed -> Randintrlv shuffles in same order

Xtrain = X(1:22,:);         % Partition our dataset into training...
Ytrain = Y(1:22,1:3);
Xtest = X(23:end,:);        % ... and testing datasets.
Ytest = Y(23:end,1:3);

% Train
[tr a]=train(mc_svm(kernel('rbf',0.1)),data(Xtrain,Ytrain));

% Test
tst=test(a,data(Xtest,Ytest));         % tst.Y=actual, tst.X=generated

% Tabulate results
[successrate, resultstable] = results(tst);

% Generate plot
visualize(resultstable, {'Wood','Metal','LOS'},'exp7.tex',1);

% TODO:
%  * Find out what rbf is all about, and why 0.25 works best
%  * Find out what "Constraints 3 removed because of dependence" means
%  * Find out why training/testing fails when given unused classes