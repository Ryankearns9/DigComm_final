clear all
close all
% Final Project Simulation


%% User Input
radio_type = 0; % 0 FM radio, 1 Handheld Radio


%% Frequency definition
if radio_type
    f_center = 462.9e6; %Hz
    bw = 3.2e6;
    f_start = f_center - bw/2;
    f_end = f_center + bw/2;

    n = 128; %Number of Channels
    m = 104; %Down sample ratio
    chan_size = bw/n;

    % Get Taps
    fid = fopen("filter_taps.h",'r');
    taps = fscanf(fid,'%d\n')';
    fclose(fid);

    data_file = 'recorded_data_bytes_voice.txt';
    input_data = convert_2_IQ(data_file);
    target_chan = 117;
    BB_offset = -1788;
    

else
    f_center = 93e6; %Hz
    bw = 3.2e6;
    f_start = f_center - bw/2;
    f_end = f_center + bw/2;

    n = 16; %Number of Channels
    m = 13; %Down sample ratio
    chan_size = bw/n;
    
    % Get Taps
    fid = fopen("filter_taps_radio.h",'r');
    taps = fscanf(fid,'%d\n')';
    fclose(fid);

    data_file = 'recorded_data_bytes_radio.txt';
    input_data = convert_2_IQ(data_file);
    target_chan = 3;

    BB_offset = 0;


end


%% Generate spectrum
T = 1/bw;

%Shift spectrum
T_end = length(input_data)*T;
dt = [T:T:T_end];
input_data = input_data .* exp(1i*2*pi*chan_size/2*dt);


%% Channelizer
input_data = input_data - mean(input_data); %Remove DC
chan_data = wola_channelizer(input_data,taps,n,m,0);


chan_data = reshape(chan_data, n,numel(chan_data)/n);

chan_data(:,end) = [];

figure;
imagesc(db(abs(chan_data)));
title('Waterfall')
ylabel('Channel #')
xlabel('Time')

%% Detection Logic

%Simple detection logic. Just look for amplitudes above a specific point.
%This is how many handheld radios work. They take advantage of the carrier
%tone on AM (DSB) modulation
amplitude_detect = 110;

detects = zeros(n,1);

chan_data_power = abs(chan_data);
chan_data_power_logic = db(chan_data_power) > amplitude_detect;
% for t = 1:length(chan_data(1,:))
%     for ch = 1:n
% 
%         if db(abs(chan_data(ch,t))) > amplitude_detect
%             detects(ch) = detects(ch) + 1;
%             if detects(ch) == 10 %Require 10 amplitudes above to count it
%                disp(['detection on channel ',num2str(ch)])
%             end
%         else
%            detects(ch) = 0;
%         end
% 
%     end
% end

%% Demodulate

%using PLL
dt = 1/(bw/m);
target_freq = BB_offset; %Found experimentally
target_data = chan_data(target_chan,:);

%filter
% bb_filter = ChannelBasebandFilter;
% filtered_data = conv(target_data,bb_filter.Numerator,'same');

%Grab phase of first detect
demod_ang_diff = unwrap(angle(target_data))/(2*pi*1/(bw/m));
demod_outpt = angdiff(demod_ang_diff(2:end),demod_ang_diff(1:end-1));

demod_resampled = resample(demod_outpt,11025,round(bw/(2*m)));




soundsc(demod_resampled,11025);
