% % % % % % % % % % % % % % % % % % % % % % % % %
%
% Experiment script #3
% by Nathan Brei
% n_brei@mit.edu
%
% This experiment identifies LOS vs NLOS propagation from the 
% preliminary data. 
%
% 16.62x Project
% Partner: Bo Han
% Advisor: Moe Win
%
% % % % % % % % % % % % % % % % % % % % % % % % %

% Run use_spider before using.

disp ' '
disp '--------------------------------------------'
disp ' '
disp ' Experiment 3: Distinguishing wood from metal'
disp ' '
disp '--------------------------------------------'
disp ' '

% Load our (preliminary) complete data set
load ../Data/datafile--20-Oct-2010.mat

% Extract experiment set
% bar1 = wood, bar2 = metal, bar3 = LOS
selectWood =   @(sample) (sample.bar==1);
selectMetal = @(sample) (sample.bar==2);

[X1,Y1,Z1]=select(alldata,selectWood,1);
[X2,Y2,Z2]=select(alldata,selectMetal,1);

% Merge first 22 samples from each dataset to make training data
Xtrain = [X1(1:22,:); X2(1:22,:)];

% Y = use LOS/NLOS output
Ytrain = [Z1(1:22,:); Z2(1:22,:)];

% Spider training method
[tr a]=train(svm,data(Xtrain,Ytrain));

% Assembling testing data
Xtest = [X1(23:end,:); X2(23:end,:)];
Ytest = [Z1(23:end,:); Z2(23:end,:)];

tst=test(a,data(Xtest,Ytest));

% These turn out to be equivalent, goody
% successrate = sum(tst.X==Ytest)/length(tst.X)
classloss = loss(tst,'class_loss');
successrate = 1-classloss.Y

