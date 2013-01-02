env=1; bar=1; loc=1;
n=3; count=1;
outdata=[0,0,0,0,0,0];

disp([int2str(env) '.' int2str(loc) '.' int2str(bar)])
selectFcn = @(sample)(sample.env==env && sample.loc==loc && sample.bar==bar);
samples = select(alldata, selectFcn);

for i=0:n:length(samples)-n
	met = [0 0 0 0 0 0];
	for j=1:n
		met = met+samples(i+j).met;
	end
	outdata(count,:) = met/n;
	count=count+1;
end