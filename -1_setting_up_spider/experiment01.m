
% % % % % % % % % %% % % % % % % % % % % % % % %
%
% Experiment script 
% by Nathan Brei
% n_brei@mit.edu
%
% This script executes a very trivial machine learning example.
% Given a set of random vectors in 2-space, it determines whether
% or not they have a positive x-component.
%
% 16.62x Project
% Partner: Bo Han
% Advisor: Moe Win
%
% % % % % % % % % %% % % % % % % % % % % % % % %


disp 'Experiment 1: Distinguishing positive from negative.'

% Spider maxes out at 200 training samples
samples = 200;

% X = column vector of uniformly distributed reals between -10 and 10.
% 2D so we can autogenerate a cool plot.
Xtrain=(rand(samples,2) - 0.5) * 20;

% Y = label is based on positive or negative
Ytrain=sign(Xtrain(:,1));

% Spider training method
[tr a]=train(svm,data(Xtrain,Ytrain));

% Generating testing data
Xtest=(rand(10000,2) - 0.5) * 20;
Ytest=sign(Xtest(:,1));

tst=test(a,data(Xtest,Ytest));

figure
plot(a);

% successrate = sum(tst.X==Ytest)/length(tst.X)
% These turn out to be equivalent, goody

classloss = loss(tst,'class_loss');
successrate = 1-classloss.Y

% Success rate ~0.995

