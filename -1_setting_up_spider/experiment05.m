
% % % % % % % % % %% % % % % % % % % % % % % % %
%
% Experiment script #5
% by Nathan Brei
% n_brei@mit.edu
%
% This script runs a machine-learning experiment. 
% It identifies LOS vs wood vs metal via a multiclass svm.
% This experiment uses the mc_svm module to achieve ~90% success.
%
% 16.62x Project
% Partner: Bo Han
% Advisor: Moe Win
%
% % % % % % % % % %% % % % % % % % % % % % % % %

% Run spider/use_spider.m before using.

disp ' '
disp '--------------------------------------------'
disp ' '
disp ' Experiment 5: Multiclass attempt 2'
disp ' '
disp '--------------------------------------------'
disp ' '

% Load our (preliminary) complete data set
load ../Data/datafile--20-Oct-2010.mat

% Extract experiment set
% bar1 = wood, bar2 = metal, bar3 = LOS
selectWood =   @(sample) (sample.bar==1);
selectMetal = @(sample) (sample.bar==2);
selectLOS = @(sample) (sample.bar==3);

[X1,Y1,Z1]=select(alldata,selectWood);
[X2,Y2,Z2]=select(alldata,selectMetal);
[X3,Y3,Z3]=select(alldata,selectLOS);

% Merge first 22 samples from each dataset to make training data
Xtrain = [X1(1:22,:); X2(1:22,:); X3(1:22,:)];

%Ytrain = [Y1(1:22,1:3); Y2(1:22,1:3); Y3(1:22,1:3)];
Ytrain = [Y1(1:22,:); Y2(1:22,:); Y3(1:22,:)];

% Spider training method

% Success rate varies as a function of rbf, from 0.55 to 0.9048.
% TODO: We REALLY need to figure out what rbf means.
[tr a]=train(mc_svm(kernel('rbf',0.25)),data(Xtrain,Ytrain));

% Assembling testing data
Xtest = [X1(23:end,:); X2(23:end,:); X3(23:end,:)];
Ytest = [Y1(23:end,1:3); Y2(23:end,1:3); Y3(23:end,1:3)];
%Ytest = [Y1(23:end,:); Y2(23:end,:); Y3(23:end,:)];
% SVN freaks out and dies if given unused classes, so we truncate them.
% TODO: Find out what "Constraints 3 removed because of dependence" means

tst=test(a,data(Xtest,Ytest));
%tst.X = multi-class generated classification
%tst.Y = actual values, same as Ytest


classloss = loss(tst,'class_loss');
successrate = 1-classloss.Y

% Let's make sure this is the right loss function.
% Count the total number of zeros in the comparison matrix
% 2 zeros per erroneous classification

%1-(numel(tst.X)-sum(sum(tst.X==tst.Y)))/(2*length(tst.X))
% Hooray! Spider is smart!

