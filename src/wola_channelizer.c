#include <stdint.h>
#include <stdio.h>
#include "wola_channelizer.h"


void wola_filter(int *data,int *taps,int *output, uint16_t filter_length,int N, int M) {
    
    // Runs a single iteration
    for {int i = 0; i < filter_length; i++}{
    
        idx = i%N;
        *output[2*idx] = (*output[2*idx]) + (*taps[i]) * (*data[2*i])
        *output[2*idx + 1] = (*output[2*idx + 1]) + (*taps[i]) * (*data[2*i + 1])
        
    }
    
    return;
}

void fft_256(int *data, int *data_out,int circ_shift_state) {

    #import "complex_exp.h"
    int N = 256;
    
    int idx;
    int idx_data;
    
    for {int k = 0; i < N; i++ } {
        for {int i = 0; i < N; i++ } {
            idx = (i+k) % N;
            idx_data = (i + k - circ_shift_state) % N;
            
            *data_out[2*k] = data_out[2*k] + exp_values[2*idx] * (*data[2*idx_data]) - exp_values[2*idx+1] * (*data[2*idx_data+1]);
            *data_out[2*k+1] = data_out[2*k+1] + exp_values[2*idx] * (*data[2*idx_data+1]) + exp_values[2*idx+1] * (*data[2*idx_data+1]);
        }
    }
    
    
    
    return;
    
}

