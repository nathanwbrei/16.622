% % % % % % % % % %% % % % % % % % % % % % % % %
%
% Experiment script #4
% by Nathan Brei
% n_brei@mit.edu
%
% This experiment identifies LOS vs wood vs metal via a multiclass svm.
% This experiment uses the one-vs-rest approach to achieve ~84%.
%
% 16.62x Project
% Partner: Bo Han
% Advisor: Moe Win
%
% % % % % % % % % %% % % % % % % % % % % % % % %

% Run use_spider before using.

disp ' '
disp '--------------------------------------------'
disp ' '
disp ' Experiment 4: Multiclass attempt 1'
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

% Y = use multiclass output
Ytrain = [Y1(1:22,1:3); Y2(1:22,1:3); Y3(1:22,1:3)];

% Spider training method: one-vs-rest = fake? multiclass
[r,a]=train(one_vs_re ...
st(svm),data(Xtrain,Ytrain));

% Assembling testing data
Xtest = [X1(23:end,:); X2(23:end,:); X3(23:end,:)];
Ytest = [Y1(23:end,1:3); Y2(23:end,1:3); Y3(23:end,1:3)];
%Ytest = [Y1(23:end,:); Y2(23:end,:); Y3(23:end,:)];
% SVN freaks out and dies if given unused classes, so we truncate them.
% TODO: Find out what "Constraints 3 removed because of dependence" means

tst=test(a,data(Xtest,Ytest));

classloss = loss(tst,'class_loss');
successrate = 1-classloss.Y

