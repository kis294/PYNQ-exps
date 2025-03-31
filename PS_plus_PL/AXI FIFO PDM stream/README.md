 
# ABOUT
This project is about interfacing PDM microphone with Pynq. 
All files are availble in the respective folders.

## Pre-reqs
    - Vivado 2022.1
    - Pynq board
    - PDM microphone from Adafruit
    - Jumper wires to the PMODB pins.
     NOTE:Avoid long wires as we are dealing with 2.5 MHz signals
    - Audacity software(optional)
    - Tone generator App
    
## Working Principle
    Each digital signal can be thought of as pulses. By modulating the pulses we can represent them as PWM(Pulse width modulation), PAM(Pulse amplitude modulation) , PPM (Pulse position modulation), PDM (Pulse Density Modulation) signals.

    The MEMS microphone we are using uses PDM. That is, as the input 
    signal's amplitude reaches max we get steady 1 or when it reaches min we get steady 0. In between, the peaks and troughs we get more
    pulses as amplitude increases or less pulses as the signal 
    decreases.

## Files
    pdm_microphone.v - Takes 1-bit RAW pdm and makes removes 
    metastability. Generates a 2.5 MHz signal CLK.On receiving power and this clk signal, the microphone gives output.

    pdm_clk_gen.v    - Generates 2.5MHz from 100MHz clock. Hardcoded for testing

    tlast_gen.v      - The CIC filter used does not have tlast required
    for AXI DMA. The output of CIC goes to tlast_gen block.

    counter.v        - In absence, of oscilloscope this can be useful 
    as you can hook up an led in place of MCLK. This is only for debug and verification.


## Output
    Jupyter notebook successfully can generate a wav file. This WAV file can be examined on Audacity. Alternatively, you can do an FFT in Python.

## Future scope
    TLAST generator stores generates signal on 256 bytes. So, the maximum you can read from DMA is 256 bytes. Need to figure out how to capture more bytes like 5 second 
    or 1 second.