//
//  main.c
//  
//
//  Created by Ryan Kearns on 11/12/23.
//

#include <stdint.h>
#include <stdio.h>
#include "wola_channelizer.h"

#include "input_data.h"
#include "filter_taps.h"

int main (void) {
    int data_length = sizeof(input_data);
    
    int N = 256; //Channels
    int M = 208; //Downsample
    uint16_t filter_length = sizeof(taps);
    
    
    int iterations = data_length/M;
    
    int output[data_length*N/M];
    
    for {int i = 0; i < sizeof(output) ; i++} {
        
        output[i] = 0;
        
    }
    
    for {int i = 0; i < iterations; i++} {
        
        wola_filter(&input_data[i*M], &taps , &output, uint16_t filter_length, N, M)
        
    }
    
    return -1;
    
}
