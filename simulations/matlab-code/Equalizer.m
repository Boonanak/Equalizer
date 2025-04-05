% All parameters (R1, R2, R3, R4, R5, gama, minfreq, maxfreq) could be set
% mannually in this program. One of C1 and C2 could be a vector for
% sweeping.
%
% Paramters:
% R1, R2, R3, R4, R5 and gama are the parameters corresponding to Figure 3
% in Lab 4
% minfreq and maxfreq are the minimum and maximum frequency in frequency
% domain analysis
% 
% Units:
% resistor: ohm
% capacitor: Farad
% frequency: Hz

clear; clc; clf; close all;
% Set parameters
R1 = 240e3;     % R1 = 240k ohm
R2 = 240e3;     % R2 = 240k ohm
R3 = 2.4e3;     % R3 = 2.4k ohm
R4 = 2.4e3;     % R4 = 2.4k ohm
R5 = 100e3;     % R5 = 100k ohm
gama = 0.25;    % gama = 0.25
minfreq = 10;   % frequency starts at 10 Hz
maxfreq = 1e6;  % frequency ends at 5 kHz
% Set C1 and C2
C1 = 0.0063e-6;     % set C1 here       
% C2 = linspace(0.001e-6,0.1e-6,1e2);    % set C2 here
C2 =  0.05e-6;

if(length(C1) == 1 && length(C2) == 1)        % C1 and C2 are both numbers
    [f0, G0, fc1, fc2] = Equalizer_filter_gain(R1, R2, R3, R4, R5, C1, C2,...
                             gama, minfreq, maxfreq, 'SingleCalculation');
    fprintf('Center frequency f0 = %6g Hz\n', f0);
    fprintf('Gain at f0 is G0 = %6g \n', G0);
    fprintf('Cutoff frequencies: fc1 = %6g Hz, fc2 = %6g Hz\n', fc1, fc2);
elseif (length(C1) > 1 && length(C2) == 1)    % C1 is a vector
    f0 = zeros(1, length(C1));
    G0 = zeros(1, length(C1));
    for m = 1: length(C1)
        [f0(m), G0(m), fc1, fc2] ...
      = Equalizer_filter_gain(R1, R2, R3, R4, R5, C1(m), C2,...
                         gama, minfreq, maxfreq, 'VectorCalculation');
    end
    plot(C1, f0);
    xlabel('C1 (Farad)');
    ylabel('Center frequency (Hz)');
    grid on;
    hold on;
elseif (length(C1) == 1 && length(C2) > 1)    % C2 is a vector
    f0 = zeros(1, length(C2));
    G0 = zeros(1, length(C2));
    for m = 1: length(C2)
        [f0(m), G0(m), fc1, fc2] ...
      = Equalizer_filter_gain(R1, R2, R3, R4, R5, C1, C2(m),...
                         gama, minfreq, maxfreq, 'VectorCalculation');
    end
    plot(C2, f0);
    xlabel('C2 (Farad)');
    ylabel('Center frequency (Hz)');
    grid on;
    hold on;
else
    err = MException('Input:TooMuchInput',...
        'Too much input.\nOnly one parameters could be swept.');
    throw(err);
end


