function Hd = ChannelizerFilter
%TMP Returns a discrete-time filter object.

% MATLAB Code
% Generated by MATLAB(R) 9.11 and DSP System Toolbox 9.13.
% Generated on: 11-Nov-2023 16:58:13

% FIR Window Lowpass filter designed using the FIR1 function.

% All frequency values are in MHz.
Fs = 3.2;  % Sampling Frequency

N    = 239;     % Order
Fc   = 0.1;   % Cutoff Frequency
flag = 'scale';  % Sampling Flag
Beta = 6.2;      % Window Parameter

% Create the window vector for the design algorithm.
win = kaiser(N+1, Beta);

% Calculate the coefficients using the FIR1 function.
b  = fir1(N, Fc/(Fs/2), 'low', win, flag);
Hd = dfilt.dffir(b);


taps = Hd.Numerator;

%Convert Taps to 16 bits
taps_fixed = round(2^19 * taps);

fid = fopen('filter_taps_radio.h','w');
fprintf(fid,'%d\n',taps_fixed);
fclose(fid);

% [EOF]


% [EOF]