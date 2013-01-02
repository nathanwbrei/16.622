
% thisdata= array of struct as returned by select(), same order as...
% Y=		matrix of scaled metrics as returned by construct()
% n=		number of samples from each

function featurespaceloc(thisdata,Y,n)

	l = length(thisdata);

	% X is our external parameter (env, loc, bar)
	X=zeros(l,1);

	% Why the fuck did I think it was a good idea to use a struct?
	for i=1:l
		X(i)=thisdata(i).loc;
	end
	
	% Scramble all samples
	X=randintrlv(X,22);
	Y=randintrlv(Y,22);
	
	% Take only first n
	X=X(1:n)
	Y=Y(1:n,:)

	figure
	subplot(231);
	scatter(X,Y(:,1));
	axis([0 6 0 1])
	title('Feature 1');
	
	subplot(232);
	scatter(X,Y(:,2));
	axis([0 6 0 1])
	title('Feature 2');
	
	subplot(233);
	scatter(X,Y(:,3));
	axis([0 6 0 1])
	title('Feature 3');
	
	subplot(234);
	scatter(X,Y(:,4));
	axis([0 6 0 1])
	title('Feature 4');
	
	subplot(235);
	scatter(X,Y(:,5));
	axis([0 6 0 1])
	title('Feature 5');
	
	subplot(236);
	scatter(X,Y(:,6));	
	axis([0 6 0 1])
	title('Feature 6');

end
