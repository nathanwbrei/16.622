
% thisdata= array of struct as returned by select(), same order as...
% Y=        matrix of scaled metrics as returned by construct()
% n=        number of samples from each

function featurespace(thisdata,Y,n)
	if (nargin==2)
		for i=[1000 100 10 1]
			featurespace(thisdata,Y,length(thisdata)/i);	
		end
	else

		l = length(thisdata);
		X=zeros(l,1); Z=zeros(l,1);
		for i=1:l
			X(i)=thisdata(i).bar;
			% Location by color
			Z(i)=thisdata(i).loc+5*(thisdata(i).env-1); 
		end

		% Scramble all samples
		X=randintrlv(X,222);Y=randintrlv(Y,222);Z=randintrlv(Z,222);

		% Take only first n
		X=X(1:n); Y=Y(1:n,:); Z=Z(1:n,:);

		figure
		set(gcf,'Color','w');
		names = {'Power', 'Maximum', 'Rise time', ...
		'Mean Excess Delay', 'RMS delay spread', 'Kurtosis'};

		% For each metric
		for i=1:6
			subplot(230+i);
			scatter(X,Y(:,i),22,Z);
			grid on; box on; 
			axis([0 12 0 1])
			xlabel('Barrier ID');
			ylabel(names{i});
		end
	end
end
