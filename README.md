![](../../workflows/gds/badge.svg) ![](../../workflows/docs/badge.svg) ![](../../workflows/wokwi_test/badge.svg)![](../../workflows/test/badge.svg)

# tt04-delay-line

This project is part of TinyTapeout4

![](doc/tt_um_ashleyjr_delay_line.png)


## How it works

      - A delay line output changes based on time delay of different variables such as process, voltage and temperature.
      
      - There are may different delay line architectures.

         - https://springerplus.springeropen.com/articles/10.1186/s40064-016-2090-z. 
      
      - This implementation is a simple tapped delay line.
      
      - The continually changing data races through a chain of inverters.
      
      - The chain is sampled a different stages to become a digital signal.

      - An edge detection circuit is used find the rising which is then converted in a binary value.

      - A bank of flops is used to sample 8 sequential rising edge values.


## How to test
      
      - The UART is the only interface to the design.
      
      - The UART runs at 115200 baud,...
      
      - The bottom 4 bits [3:0] of the UART frame make up the command.
      
      - 4'h0: Shift In
         
         - Shift the top 4 bits of the frame in to memory

         - The memory is shifted to the left

         - The data is placed in to the bottom 4 bits [3:0]

         - This command is to test the silicon and debug software
      
      - 4'h1: Shift Out
         
         - Shift the top 8 bits [39:32] of memory out to UART Tx
      
      - 4'h2: Full Sample
         
         - Take a full 32-bit sample from the delay line and place in memory

         - The sample is placed in to the bottom 32 bits [31:0]

         - The shift out command may be used to read the sample
      
      - 4'h3: Scope
         
         - Take 8 samples from the delay line at a 25MHz sample rate

         - These sample use the edge detection logic to find the 
           position of the rising edge 
         
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


## Compromises

   - Ideally a clock signal would have been sent through the line to capture a new sample every cycle but this caused issues for timing analysis so the source data is sent from a flop.

   - Ideally the delay line would be longer to work at all process corners but as it stand the value centred for *tt* and only just fits for *ss* and *ff*.

   - Ideally the sample
 

