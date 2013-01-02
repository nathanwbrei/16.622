% % % % % % % % % % % % % % % % % % % % % % % % %
%
% RBF optimization
% by Nathan Brei
% n_brei@mit.edu
%
% 16.62x Project
% Partner: Bo Han
% Advisor: Moe Win
%
% % % % % % % % % % % % % % % % % % % % % % % % %

function rbf=autorbf(X, Y)

disp ' '
disp '--------------------------------------------'
disp ' '
disp '    Finding RBF; this may take awhile...    '
disp ' '
disp '--------------------------------------------'
disp ' '

% What we used before:
%[tr a]=train(mc_svm(kernel('rbf',0.03)),data(Xtrain,Ytrain));
%tst=test(a,data(Xtest,Ytest));         
%[successrate, resultstable] = results(tst);

d=data(X,Y);

s = mc_svm(kernel('rbf',0));
a1=param(s,'rbf',[0.59 0.58 0.57 0.56 0.55]);

a2=gridsel(a1); 
% Gridsel will perform a n-fold for each object in a1 and choose the best performing according the cross-validation score.  

[r,a]=train(a2,d);

loss(r)
a.best
r
