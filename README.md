# Introduction
This project looks to build an FM radio reciever capable of receiving both narrowband and wideband frequencies.

## Equipment
2. Nooelec NESDR SMArt XTR Bundle
 - https://www.nooelec.com/store/nesdr-smart-xtr.html
  - Details on the specific SDR kit can be found following the attached link. Further information is contained in the Lab 1 report

## Handheld Radio (Rocky Talkie)
The FCC licenses public use for the frequencies between 462 MHz to 467 MHz. 
These frequencies are typically used for handheld radios, hobbiest, and other 
common uses. This project monitors that spectrum and will notify users of 
occupied channels. This can be a useful method of avoiding conflicts in a 
highly occupied spectrum.

Used as a reference for this project is the Rocky Talkie radio User Manual 
found here: 
https://alpine.caltech.edu/documents/22338/RockyTalkies_UserManual_V2_3_1.pdf.

This manual shows that the typical radio channel is 25kHz wide. This project
will channelize the entire spectrum into 25 kHz channels as defined by this
user guide. 

Handheld radios are typically narrowband FM with. This lab attempts to demodulate the radio using FM demodulation.

## Broadcast Radio (Rocky Talkie)
Broadcast radio requires a specific FCC license with a well defined frequency bandwidth, modulation type, power, and frequency deviation. Broadcast FM radio is given 200 kHz frequency bands with 75 kHz frequency deviation. Specific frequencies are licensed by the FCC for FM broadcast. Typically this is between 87 and 108 MHz.

https://transition.fcc.gov/oet/spectrum/table/fcctable.pdf

This lab works to capture and demodulate one of these channels.

## Channelizations
Channelization is the act of breaking a frequency spectrum into sub-frequency bands. This is similar to how a television chooses a "channel". Channelizers are specifically designed for FDMA waveforms and will typically choose channel sizes that are ideally suited for a specific waveform. In this case, 25kHz was chosen for the narrowband waveform and 200kHz is chosen for the wideband waveform.

The typical channelizer structure can be thought of as a mixer, followed by a filter, then a downsampler. This lab uses a technique known as a "WOLA Channelizer" which efficently breaks the entire spectrum down into sub-frequency bins. This is detailed in great detail within "Channelizers and Reconstructors: A Design Guide" by Bradford Watson. An overview of a channelizer can be seen below:

![image](https://github.com/Ryankearns9/DigComm_final/blob/main/imgs/rocky_spectrum.png)

## PyRTLSDR
To control the SDR and capture samples, PyRTLSDR was used. PyRTLSDR is an opensource library for controlling RTL-SDRs. Data was captured using this software and stored to text file for further processing. 

https://pyrtlsdr.readthedocs.io/en/latest/

## Spur
A spur refers to an unwanted frequency components caused by test equipment. These can have many causes such as aliasing, non-linearities, and ADC saturation. Saturation is specifically explored in the 

# Results
The below section outlines the results of the project.

## Handheld Radio
The below plot shows the frequency plot of the handheld radio.

![image](https://github.com/Ryankearns9/DigComm_final/blob/main/imgs/rocky_spectrum.png)

As can be seen here, this spectrum has a significant number of spurs. After inspecting the time domain data, it is clear that saturation occured during measurement. This resulted in spurs occuring all throughout the signal. Future work should include retaking this data from a further distance to avoid saturating the antenna.

Another spur of interest is the DC spur. This is a typical issue with ADCs and can be corrected for by removing the "average" from the data.

### Waterfall
The channelized output can be seen below. The spectrum was channelized to 25kHz and downsampled to about 30kHz. As can be seen here, the DC tone is present in channel 1 and is the largest signal present. After the DC tone, is the tone in bin 117 with the tone in 39 following. The bin at 117 corresponds to the expected location of our signal while the bin at 39 appears to be spurious. We are confident that both tones are a result of our radio because the start and end time for the radio can be clearly seen at the beginning of the waterfall.

![image](https://github.com/Ryankearns9/DigComm_final/blob/main/imgs/Waterfall_handheld.png)

### Channelized Spectrum
The below spectrum shows the channelized spectrum of our handheld radio. As can be seen, siginificant spurs still exist. These spurs have severly degraded our signal and may make it impossible to demodulate. The experiment will need to be redone without this saturation

![image](https://github.com/Ryankearns9/DigComm_final/blob/main/imgs/RockyTalkieOutput.png)

The phase for this signal suggests we have not successfully basebaded the signal of interest. An ideally basebanded signal should experience a constant phase rather than the increasing phase seen here.

![image](https://github.com/Ryankearns9/DigComm_final/blob/main/imgs/RockyTalkiePhase.png)

### Demodulation
As a result of the saturation effects, demodulation attempts have been unsuccessful. Future work will include retaking the data from a further distance to try and get a cleaner signal

## Broadcast Radio
The below plot displays the spectrum when captured at 93 MHz. This spectrum is significantly cleaner than that seen in the previous section. Here we can clearly make out the main bulb of a FM waveform at 93.3MHz. This is clearly an FM waveform and will be targeted for this project.

![image](https://github.com/Ryankearns9/DigComm_final/blob/main/imgs/radio_spectrum.png)

### Waterfall
The channelized spectrum is shown below. The spectrum was split into 200kHz channels to target the FCC channelization scheme. This higher chanenl size results in a much lower resolution wateterfall curve but the channels can still be clearly identified. Our signal of interest is in channel 3 below:

![image](https://github.com/Ryankearns9/DigComm_final/blob/main/imgs/waterfall_broadcast.png)

### Channelized Spectrum
By selecting our channel of interest, we see the FM waveform main bulb. This is the characteristic main lobe of an FM waveform and contains the majority of the energy and information. From here, we should be able to demodulate the information without issue of the adjacent channels or noise interfering with the demodulation process 

![image](https://github.com/Ryankearns9/DigComm_final/blob/main/imgs/Broadcast_Channel.png)

### Demodulation
Demodulation of the FM waveform has successfully been conducted. Audio quality is low. This is likely a result of over filtering the spectrum. Future work should include changing the filtering structure to recover better audio quality.

# Future Work

## Real Time Analysis
All code was built intending for real time analysis. C code was begin to this end. Unforunately, without the ability to demodulate, these efforts were paused until demodulation could be proven. Once successfully demodulating the waveform, this code will be updated to run in real time.
