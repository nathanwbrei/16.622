

% thisdata= array of struct as returned by select(), same order as...
% Y=        matrix of scaled metrics as returned by construct()
% n=        number of samples from each

function featurehistloc(thisdata,met,Y)
	if(nargin<3)
		Y=construct(thisdata); 	% scale metrics 
	end
	
	X={[],[],[],[],[]};
	
	for i=1:length(thisdata)
		X{thisdata(i).loc} = [X{thisdata(i).loc} Y(i,met)];
	end
	
	hold on; grid on; box on;
	names = {'Power', 'Maximum', 'Rise time', ...
	'Mean Excess Delay', 'RMS delay spread', 'Kurtosis'};
	xlabel(names{met});
	ylabel('Frequency');

	% For each barrier
	for i=1:5
		Z(:,i)=hist(X{i},50)';
	end
	
	% Stacked histogram ~= overlaid histograms
	area(linspace(0,1,50),Z);
end
