![](../../workflows/gds/badge.svg) ![](../../workflows/docs/badge.svg) ![](../../workflows/wokwi_test/badge.svg)![](../../workflows/test/badge.svg)

# tt04-delay-line

This project is part of [TinyTapeout4](https://github.com/TinyTapeout/tt04-submission-template)

![](doc/tt_um_ashleyjr_delay_line.png)


- A delay line output changes based on time delay of different variables such as process, voltage and temperature.

- There are may different delay line architectures.

   - https://springerplus.springeropen.com/articles/10.1186/s40064-016-2090-z. 

- This implementation is a simple tapped delay line.

- The continually changing data races through a chain of inverters.

- The chain is sampled at different stages to become a digital signal.

- An edge detection circuit is used find the rising which is then converted in a binary value.

- A bank of flops is used to sample 8 sequential rising edge values.


## Test

- https://github.com/ashleyjr/tt04-delay-line/blob/main/src/test/silicon_test.py

   - This python script uses pyserial to run a set of tests on the design

   - python3 silicon_test.py --help

- UART

   - The UART is the only interface to the design
   
      - 9600 baud
      
      - Least significant bit first
      
      - 1 Start bit
      
      - 8 Data bits
      
      - No parity bit
      
      - 1 Stop bit
      
      - Taken from https://github.com/ashleyjr/rtl-uart
      
      - The bottom 4 bits [3:0] of the UART frame make up the command
   
   - 4'h0: Shift In
   
      - Shift the top 4 bits [7:4] of the frame in to memory
      
      - The memory is shifted 4 places to the left
      
      - The data is placed in to the bottom 4 bits [3:0]
      
      - This command is to test the silicon and debug software
   
   - 4'h1: Shift Out
   
      - Shift the top 8 bits [39:32] of memory out to UART Tx
      
      - The memory is shifted 8 places to the left 
   
   - 4'h2: Full Sample
   
      - Take a full 32-bit sample from the delay line and place in memory
      
      - The sample is placed in to the bottom 32 bits [31:0]
      
      - The shift out command may be used to read the sample
   
   - 4'h3: Scope
   
      - Take 8 samples from the delay line at a 25MHz sample rate
   
      - These sample use the edge detection logic to find the position of the rising edge 
   
      - These samples are 5 bits wide
      
      - The samples are shifted in to the memory
      
      - Sample 0: [39:35]
      - Sample 1: [34:30]
      - Sample 2: [29:25]
      - Sample 3: [24:20]
      - Sample 4: [19:15]
      - Sample 5: [14:10]
      - Sample 6: [9:5]
      - Sample 7: [4:0]
      
      - The shift out command may be used to read the sample
   
   - 4'h4 to 4'hF inclusive
   
      - Ignored

## Expected performance 

Sweeping supply voltage against different parts of the design.
All simulated with ngspice using *tt* at 27C.

   - The delay from launch flop to each tap in the delay line. 

![](doc/graph_taps.png)

   - The supply voltages and input delay lines code.

![](doc/graph_d_trace.png)
 
   - The supply voltages and ouptut delay lines code.

![](doc/graph_q_trace.png)

   - The same data displayed as text.

```
D
                543210fedcba9876543210fedcba9876543210fedcba9876543210
2.0995e-08:	    000000000000000000000000000000000000000000000000000000
4.0995e-08:	    000000000000000000011111111111111111111111111111111111
6.0995e-08:	    111111111111111111100000000000000000000000000000000000
8.0995e-08:	    000000000000000000111111111111111111111111111111111111
1.00995e-07:	 111111111111111111000000000000000000000000000000000000
1.20995e-07:	 000000000000000001111111111111111111111111111111111111
1.40995e-07:	 111111111111111110000000000000000000000000000000000000
1.60995e-07:	 000000000000000011111111111111111111111111111111111111
1.80995e-07:	 111111111111111100000000000000000000000000000000000000
2.00995e-07:	 000000000000000111111111111111111111111111111111111111
2.20995e-07:	 111111111111111000000000000000000000000000000000000000
2.40995e-07:	 000000000000001111111111111111111111111111111111111111

Q
                fedcba9876543210fedcba9876543210
2.0995e-08:	    00000000000000000000000000000000
4.0995e-08:	    00000000000000000000000000000000
6.0995e-08:	    00000000000000000011111111111111
8.0995e-08:	    11111111111111111100000000000000
1.00995e-07:	 00000000000000000111111111111111
1.20995e-07:	 11111111111111111000000000000000
1.40995e-07:	 00000000000000001111111111111111
1.60995e-07:	 11111111111111110000000000000000
1.80995e-07:	 00000000000000011111111111111111
2.00995e-07:	 11111111111111100000000000000000
2.20995e-07:	 00000000000000111111111111111111
2.40995e-07:	 11111111111111000000000000000000
```


## Compromises

- Clock Input

   - Ideally a clock signal would have been sent through the line to capture a new sample every cycle but this caused issues for timing analysis so the source data is sent from a flop.

- Length

   - Ideally the delay line would be longer to work at all process corners but as it stands the value is centred for *tt* and only just fits for *ss* and *ff*.

- Area available for sample memory

   - Ideally the sample memory would be a lot larger to take longer samples but only 8 samples are possible at 25MHz.
 
- Resynchronisers

   - Ideally metastability resolving resyncs would be used to avoid propagation throughout the design but since this is an experiment is preferred to have more area over increased MTBF.

- Baud Rate

   - The FPGA example would only run at 9600 baud with a PLL multiplying a reference clock from 12MHz to 48MHz 


