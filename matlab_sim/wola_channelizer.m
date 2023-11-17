function chan_data = wola_channelizer(input_data, filter, N, M,filter_gain)

%% Initalization
input_data = reshape(input_data,1,numel(input_data));

filter_length = length(filter);
data_length = length(input_data);

taps_per_leg = filter_length/N;

shift_states = zeros(1,M);
for i = 1:M
    shift_states(i) = mod(i*M,N);
end


%% WOLA
wola_buffer = zeros(1,filter_length);
pad_size = filter_length + mod(M - mod(data_length+filter_length,M),M);
pad = zeros(1,pad_size);
input_data = [input_data, pad];
data_length = length(input_data);


iterations = data_length/M;

chan_data = zeros(1,data_length*N/M);

for i = 1:iterations
    wola_buffer = circshift(wola_buffer,M); %Shift register
    wola_buffer(1:M) = fliplr(input_data((i-1)*M +1:i*M)); % Shift in new data
    filtered_output = wola_buffer.*filter;
    filtered_output = sum(reshape(filtered_output,N,taps_per_leg),2);
    filtered_output = filtered_output.';


    shift_state = N-M;
    g = N/shift_state;
    mk = mod(i,g);
    shifted_data = circshift(filtered_output,round(mk*shift_state));
    fft_data = ifft(shifted_data);


    chan_data(N*(i-1)+1:i*N) = round(fft_data/2^filter_gain);


end


end