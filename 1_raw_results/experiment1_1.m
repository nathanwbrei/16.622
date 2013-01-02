% % % % % % % % % % % % % % % % % % % % % % % % %
%
% Experiment script 1.1
% Visualizes raw results for multiple dataset slices
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
disp '1.1: Visualizing raw results for multiple dataset slices...'
disp '-----------------------------------------------------------'
disp ' '

% Load our complete data set
load /Users/nbrei/Desktop/62x/data-complete.mat
alldata=everything(1:28072);

% Dataset slices
clear selectFcn;
selectFcn{1} = @(sample) (1);
selectFcn{2} = @(sample) (sample.env==1);
selectFcn{3} = @(sample) (sample.env==2);
selectFcn{4} = @(sample) (sample.env==3);
selectFcn{5} = @(sample) (sample.env==4);
selectFcn{6} = @(sample) (sample.env==5);
selectFcn{7} = @(sample) (sample.env==1 && sample.loc==3);
selectFcn{8} = @(sample) (sample.env==1 && sample.loc==5);
selectFcn{9} = @(sample) (sample.env==4 && sample.loc==2);

% Dataset descriptions
titles{1} = 'All data';
titles{2} = 'Constant environment = 1';
titles{3} = 'Constant environment = 2';
titles{4} = 'Constant environment = 3';
titles{5} = 'Constant environment = 4';
titles{6} = 'Constant environment = 5';
titles{7} = 'Constant location = 1.3';
titles{8} = 'Constant location = 1.5';
titles{9} = 'Constant location = 4.2';

for i=1:length(titles)
    % Extract experiment set
    [X, Y, Z]=construct(select(alldata,selectFcn{i}));

    X = randintrlv(X,22);       % We shuffle the samples
    Y = randintrlv(Y,22);       % Seed -> Randintrlv shuffles in same order

    if length(X)<2000           % Number of training samples
        ts = floor(0.1*length(X));
    else
        ts = 200;
    end

    Xtrain = X(1:ts,:);         % Partition our dataset into training...
    Ytrain = Y(1:ts,1:11);
    Xtest = X(ts+1:end,:);      % ... and testing datasets.
    Ytest = Y(ts+1:end,1:11);

    % Train
    [tr a]=train(mc_svm(kernel('rbf',0.035)),data(Xtrain,Ytrain));

    % Test
    tst=test(a,data(Xtest,Ytest));         

    % Tabulate results
    [successrate, resultstable] = results(tst);

    disp 'Generating plot...'
    % Generate plot
    fnamestr = ['1.1.' int2str(i) '.tex'];
    titlestr = [char(titles{i}) ' [' num2str(round(100*successrate)) ' percent success]']; 
    axesstr = {'Plywood1','Plywood2','Drywall1','Drywall2','Metal1',...
    'Metal2','Foam1','Foam2','Glass1','Glass2','LOS'};
    visualize(resultstable, axesstr, fnamestr, titlestr, 1);

    disp(titlestr);
    resultstable
    disp '-----------------------------------------------------------------'
end