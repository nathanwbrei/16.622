% % % % % % % % % % % % % % % % % % % % % % % % %
%
% Experiment script 3.1: Noise reduction on alldata, env1, loc2.2
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
disp '3.1: Noise reduction on entire dataset, one env and one loc'
disp '------------------------------------------------------------'
disp ' '

if (1)
    load noisereduced-06-Dec-2010.mat
	[X,Y,Z]=construct(outdata);
else
    % Load our complete data set
    load /Users/nbrei/Desktop/62x/data-complete.mat
    alldata=everything(1:28072);
    [X, Y, Z]=construct(removenoise(alldata,3));
end

X = randintrlv(X,22);       % We shuffle the samples
Y = randintrlv(Y,22);       % Seed -> Randintrlv shuffles in same order

Xtrain = X(1:200,:);         % Partition our dataset into training...
Ytrain = Y(1:200,:);		% Write another function to remove unused Y cols
Xtest = X(201:end,:);        % ... and testing datasets.
Ytest = Y(201:end,:);

% Train
[tr a]=train(mc_svm(kernel('rbf',0.55)),data(Xtrain,Ytrain));

% Test
tst=test(a,data(Xtest,Ytest));         

% Tabulate results
[successrate, resultstable] = results(tst);

disp 'Generating plot...'
 % Generate plot
 fnamestr = ['3.1.1.tex'];
 titlestr = ['Entire dataset with noise reduction [' num2str(round(100*successrate)) ' percent success]']; 
 axesstr = {'Plywood1','Plywood2','Drywall1','Drywall2','Metal1',...
 'Metal2','Foam1','Foam2','Glass1','Glass2','LOS'};
 visualize(resultstable, axesstr, fnamestr, titlestr, 1);

 disp(titlestr);
 resultstable
 disp '-----------------------------------------------------------------'
