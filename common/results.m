% % % % % % % % % % % % % % % % % % % % % % % % %
%
% Results tabulator
% by Nathan Brei
% n_brei@mit.edu
%
% This script takes Spider's output object and turns it 
% into something readable. Needs spider.
%
% 16.62x Project
% Partner: Bo Han
% Advisor: Moe Win
%
% % % % % % % % % % % % % % % % % % % % % % % % %

function [successrate, resultstable] = results (testOutput)

X = testOutput.X;		% ACTUAL classifications... nah, this is fucked up
Y = testOutput.Y;		% PREDICTED classifications

% Give success rate
classloss = loss(testOutput,'class_loss');
successrate = 1-classloss.Y;

% Make compatible with single-class SVM results, too
if(size(X,2)==1)
    X=[X -X];
    Y=[Y -Y];
end

% Generate results matrix from Spider's output
resultstable = zeros(size(X,2));
for k=1:length(X)

    if(length(find(X(k,:)==1))>1)
        error(['ZOMG Spider FAILS at X(' int2str(k) ')']);
    end   % This little bit should satisfy Prof. Win

    x=find(X(k,:)==1,1);
    y=find(Y(k,:)==1,1);
    resultstable(x,y) = resultstable(x,y)+1;
end
