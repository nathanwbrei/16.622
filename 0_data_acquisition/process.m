% % % % % % % % % % % % % % % % % % % % % % % % %
%
% Waveform preprocessing function
% by Nathan Brei
% n_brei@mit.edu
%
% Adapted from extractFeatures.m, courtesy of Wesley Gifford
%
% 16.62x Project
% Partner: Bo Han
% Advisor: Moe Win
%
% % % % % % % % % % % % % % % % % % % % % % % % %

% This function transforms a single waveform into a vector of metrics.
% Input:    waveform = array of floats as returned by retrieveWaveform
% Output:   metrics = [power, r_max, t_rise, t_med, t_rms, kurt]
    
function metrics = preprocess(waveform)

%% Time vector
time = linspace(0, 1, length(waveform));
% We are assuming (dangerously) that the waveform array captures 1s of 
% radio activity.  Will this mess up the RMS-DS metric? Ask Santi/Wesley.

%% Energy metric
power = sum(abs(waveform).^2);

%% Max metric
r_max = max(abs(waveform));

%% Risetime metric
gamma_L = 6 * std(waveform(1:500));
gamma_H = 0.6 * r_max;

%ensure gamma_L > gamma_H
while (gamma_L > gamma_H)
    gamma_L = gamma_L/2;
end;

tStart = time( find(abs(waveform)>=gamma_L,1) );
tStop = time( find(abs(waveform)>=gamma_H,1) );

%t_rise = max((tStop-tStart), 1e-10);
% This doesn't make sense. tStop and tStart are scalars, considering we
% only took the _first_ index that satisfies abs(waveform)>=gamma_L
% Is this an artifact from older code? Instead we use:
t_rise = tStop - tStart;

%% Mean excess delay metric
t_med = sum(time' .* (abs(waveform).^2) ) / power;

%% RMS delay spread metric
t_rms =   sum( ((time' - t_med ).^2) .* (abs(waveform).^2) ) / power;

%% Kurtosis metric
kurt = kurtosis(abs(waveform));

%% Return
metrics = [power, r_max, t_rise, t_med, t_rms, kurt];

