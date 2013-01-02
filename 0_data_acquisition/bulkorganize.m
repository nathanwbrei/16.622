% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% Waveform file management
% by Nathan Brei
% n_brei@mit.edu
%
% 16.62x Project
% Partner: Bo Han
% Advisor: Moe Win
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 

% This script captures and organizes large numbers of waveforms
% retrieved from a UWB radio via the PulsOn software. Before running:

% Move all *range files out of there
% cd capturedir
% !mkdir ranges
% !mv *range.txt ranges

% % % % % % % % % % % % % Knobs % % % % % % % % % % % % % % % % % % %
startenvironment = 5;               % Initial environment parameter
startlocation = 1;                  % Initial location parameter
minlocation = startlocation;
maxenvironment = 5; maxlocation=5; maxbarrier=11;
capturedir = '/Users/nbrei/Desktop/outside/';
savedir = '/Users/nbrei/Desktop/62x/Data2/';
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %  

close all;
clc;
disp ' '
disp '-----------------------------------------------------------------'
disp '                 16.62x Data Collection Time!'
disp '-----------------------------------------------------------------'
disp ' '

fprintf('startenvironment\t%d\n', startenvironment);
fprintf('startlocation\t\t%d\n', startlocation);
fprintf('capturedir\t\t%s\n', capturedir);
fprintf('savedir\t\t\t%s\n', savedir);
disp ' '
disp 'Press a key to continue'
disp ' '
pause

% Do we have a capture directory? If not, yell at user
if (exist(capturedir,'dir') ~= 7)
	error([capturedir ' does not exist! Make it exist.']); 
end

% Do we have a save directory? If not, yell at user
if (exist(savedir,'dir') ~= 7)
	error([savedir ' does not exist!']);   
end

% For each environment
for env = startenvironment:maxenvironment
    for loc = minlocation:maxlocation
        minlocation = 1;
        for bar=1:maxbarrier

			filename = [int2str(env) '.' int2str(loc) '.' int2str(bar) '_*'];
			organize(env, loc, bar, filename, capturedir, savedir)

        end % for each barrier
    end % for each location
end % for each environment

