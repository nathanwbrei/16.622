% % % % % % % % % % % % % % % % % % % % % % % % %
%
% n-fold cross-validation and RBF optimization
% by Nathan Brei
% n_brei@mit.edu
%
% 16.62x Project
% Partner: Bo Han
% Advisor: Moe Win
%
% % % % % % % % % % % % % % % % % % % % % % % % %

function [r,a]=validate(n, X, Y)

disp ' '
disp '--------------------------------------------'
disp ' '
disp '    Validating; this may take awhile...    '
disp ' '
disp '--------------------------------------------'
disp ' '

% What we used before:
%[tr a]=train(mc_svm(kernel('rbf',0.03)),data(Xtrain,Ytrain));
%tst=test(a,data(Xtest,Ytest));         
%[successrate, resultstable] = results(tst);


a = cv(mc_svm(kernel('rbf',0.01)),['folds=' int2str(n)]);
d = data(X,Y);

[r,a] = train( a, d);

get_mean( r )