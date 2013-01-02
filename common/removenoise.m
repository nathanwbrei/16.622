% % % % % % % % % %% % % % % % % % % % % % % % %
% Function to remove noise by averaging samples
%
% by Nathan Brei
% n_brei@mit.edu
%
% 16.62x Project
% Partner: Bo Han
% Advisor: Moe Win
% % % % % % % % % %% % % % % % % % % % % % % % %

% Inputs:  indata=     Array of struct containing waveform parameters/metrics
%          n=          Number of samples per bucket
% Outputs: outdata=    Array just like indata, ready for construct.m

function [outdata] = removenoise(indata, n)
    if(nargin<2) 
        n=5;
    end
    disp 'Removing noise...'
    count=1;
    for env=1:5
        for loc=1:5
            for bar=1:11
                disp([int2str(env) '.' int2str(loc) '.' int2str(bar)])
                selectFcn = @(sample)(sample.env==env&&sample.loc==loc && sample.bar==bar);

                samples = select(indata, selectFcn);
                for i=0:n:length(samples)-n
                    met = [0 0 0 0 0 0];
                    for j=1:n
                        met = met+samples(i+j).met;
                    end
                    outdata(count) = samples(1);
                    outdata(count).met = met/n;
                    count=count+1;
                end
            end
        end
    end

    save(['noisereduced-' date], 'outdata');
