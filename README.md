![](../../workflows/gds/badge.svg) ![](../../workflows/docs/badge.svg) ![](../../workflows/wokwi_test/badge.svg)![](../../workflows/test/badge.svg)

# tt04-delay-line

This project is part of [TinyTapeout4](https://github.com/TinyTapeout/tt04-submission-template)

![](doc/tt_um_ashleyjr_delay_line.png)

## info.yaml

```info.yaml
```

## Expected perfomrance 

## Compromises

- Clock Input

   - Ideally a clock signal would have been sent through the line to capture a new sample every cycle but this caused issues for timing analysis so the source data is sent from a flop.

- Length

   - Ideally the delay line would be longer to work at all process corners but as it stand the value centred for *tt* and only just fits for *ss* and *ff*.

- Area for sample memory

   - Ideally the sample
 

