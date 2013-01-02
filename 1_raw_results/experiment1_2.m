% % % % % % % % % % % % % % % % % % % % % % % % %
%
% Experiment script 1.2: Barrier thickness agnostic
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
disp '1.2: Visualizing raw results, barrier thickness agnostic'
disp '--------------------------------------------------------'
disp ' '

% Load our complete data set
load /Users/nbrei/Desktop/62x/data-complete.mat
alldata=everything(1:28072);

% Merge different barrier thicknesses
alldata = merge(alldata, 2,1);
alldata = merge(alldata, 4,3);
alldata = merge(alldata, 6,5);
alldata = merge(alldata, 8,7);
alldata = merge(alldata, 10,9);

[X, Y, Z]=construct(alldata);
% Kill off empty classification columns
Y=Y(:,1:2:11);

X = randintrlv(X,22);       % We shuffle the samples
Y = randintrlv(Y,22);       % Seed -> Randintrlv shuffles in same order

Xtrain = X(1:200,:);         % Partition our dataset into training...
Ytrain = Y(1:200,:);
Xtest = X(201:end,:);        % ... and testing datasets.
Ytest = Y(201:end,:);

% Train
[tr a]=train(mc_svm(kernel('rbf',0.025)),data(Xtrain,Ytrain));

% Test
tst=test(a,data(Xtest,Ytest));         

disp 'Done testing.'

% Tabulate results
[successrate, resultstable] = results(tst);

fnamestr = '1.2.tex';
titlestr = ['All data, barrier thickness agnostic. [' num2str(round(100*successrate)) ' percent success]']; 
axesstr = {'Plywood','Drywall','Metal','Foam','Glass','LOS'};
visualize(resultstable, axesstr, fnamestr, titlestr, 1);

disp(titlestr);
resultstable
disp '-----------------------------------------------------------------'