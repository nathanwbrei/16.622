% % % % % % % % % %% % % % % % % % % % % % % % %
%
% Experiment script 1.3
% by Nathan Brei
% n_brei@mit.edu
%
% LOS vs NLOS identification from the entire dataset
%
% 16.62x Project
% Partner: Bo Han
% Advisor: Moe Win
%
% % % % % % % % % %% % % % % % % % % % % % % % %

clear all; close all; clc;
disp ' '
disp '1.3: Visualizing raw results, LOS vs NLOS identification'
disp '--------------------------------------------------------'
disp ' '

% Load our complete data set
load /Users/nbrei/Desktop/62x/data-complete.mat
alldata=everything(1:28072);

% Extract experiment set
selectFcn = @(sample) (sample.bar==11);
[X1,Y1,Z1]=construct(select(alldata,selectFcn),11);
selectFcn = @(sample) (sample.bar~=11);
[X2,Y2,Z2]=construct(select(alldata,selectFcn),11);

X2 = randintrlv(X2,77);       % We shuffle the samples
Z2 = randintrlv(Z2,77);       % Seed -> Randintrlv shuffles in same order

X = [X1; X2(1:length(X1),:)];
Z = [Z1; Z2(1:length(Z1),:)];

X = randintrlv(X,22);       % We shuffle the samples
Z = randintrlv(Z,22);       % Seed -> Randintrlv shuffles in same order

Xtrain = X(1:200,:);         % Partition our dataset into training...
Ytrain = Z(1:200,:);
Xtest = X(201:end,:);        % ... and testing datasets.
Ytest = Z(201:end,:);

% Spider training method
[tr a]=train(svm,data(Xtrain,Ytrain));
tst=test(a,data(Xtest,Ytest));

% Tabulate results
[successrate, resultstable] = results(tst);

fnamestr = '1.3.tex';
titlestr = ['All data, LOS vs NLOS. [' num2str(round(100*successrate)) ' percent success]']; 
axesstr = {'NLOS','LOS'};
visualize(resultstable, axesstr, fnamestr, titlestr);

disp(titlestr);
resultstable
disp '-----------------------------------------------------------------'