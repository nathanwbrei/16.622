% % % % % % % % % % % % % % % % % % % % % % % % %
% Organizes collected waveforms for bulkpreprocess
% by Nathan Brei
% n_brei@mit.edu
%
% 16.62x Project
% Partner: Bo Han
% Advisor: Moe Win
% % % % % % % % % % % % % % % % % % % % % % % % %

function sample = organize(env, loc, bar, mask, capturedir, savedir)

	if (nargin<5)
		capturedir = '/Volumes/TravelDrive/data/';
		savedir = '/Users/nbrei/Desktop/62x/Data/';
	end
	
	% Do we have a capture directory? If not, yell at user
	if (exist(capturedir,'dir') ~= 7)
		error([capturedir ' does not exist! Make it exist.']); 
	end
	% Do we have a save directory? If not, yell at user
	if (exist(savedir,'dir') ~= 7)
		error([savedir ' does not exist!']);   
	end
	
	list=dir([capturedir mask]);
	for sample=1:length(list)
		
		inputfile = [capturedir list(sample).name];
		outputfilename = ['sample_'...
		num2str(env) '_'...
		num2str(loc) '_'...
		num2str(bar) '_'...
		num2str(sample) '.txt']; 
		outputfile = [savedir outputfilename];

		% Copy raw waveform file to hard disk
		% Warning-- this will take ~600MB
		copyfile(inputfile, outputfile);
	end
end
