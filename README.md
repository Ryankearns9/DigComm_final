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

The typical channelizer structure can be thought of as a mixer, followed by a filter, then a downsampler. This lab uses a technique known as a "WOLA Channelizer" which efficently breaks the entire spectrum down into sub-frequency bins. This is detailed in great detail within "Channelizers and Reconstructors: A Design Guide" by Bradford Watson.

## PyRTLSDR
To control the SDR and capture samples, PyRTLSDR was used. PyRTLSDR is an opensource library for controlling RTL-SDRs. Data was captured using this software and stored to text file for further processing. 

https://pyrtlsdr.readthedocs.io/en/latest/

## Spur
A spur refers to an unwanted frequency components caused by test equipment. These can have many causes such as aliasing, non-linearities, and ADC saturation. Saturation is specifically explored in the 

#Results
The below section outlines the results of the project.

## Handheld Radio
The below plot shows the frequency plot of the handheld radio.

![image](https://github.com/Ryankearns9/DigComm_final/blob/main/imgs/RationalResampler.PNG)
