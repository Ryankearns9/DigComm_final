from rtlsdr import RtlSdr

if __name__ == "__main__":
    
    sdr = RtlSdr()
    
    sdr.center_freq = 93e6
    sampe_rate = 6.4e6/2
    sdr.sample_rate = sampe_rate
    bytes_per_samp = 2
    sdr.freq_correction = 60   # PPM
    sdr.gain = 'auto'
    
    recording_time = 3

    print(sdr.center_freq)
    
    print('Starting Recording...')
    data = sdr.read_bytes(recording_time*sampe_rate*bytes_per_samp)
    sdr.close()
    print('Ending recording')

    fid = open('matlab_sim/recorded_data_bytes.txt','w')
    for i in data:
        fid.write(f"{i}\n")
    fid.close()
    
    data = sdr.packed_bytes_to_iq(data)
    
    fid = open('recorded_data_IQ.txt','w')
    for i in data:
        fid.write(f"{i}\n")
    fid.close()
    
