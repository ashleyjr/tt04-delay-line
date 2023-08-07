
# Delay

- Current RTL 
- Magic extraction with parasitics
- Clock rising @ 20ns, @40ns
- Supply @ 1.8V
- Temprature @ 27C
- Timing in sim where rising edge appears at 0.9V crossing point

| Corner     | dl_0 (ns) | dl_8 (ns) | dl_16 (ns) | dl_24 (ns) | dl_32 (ns) | Rising edge positon |
| ---------- | --------- | --------- | ---------- | ---------- | ---------- | ------------------- |
| ss         | 38.090    | 46.067    | 54.045     | 62.079     | 70.056     | ??? - crashed       | 
| tt         | 32.476    | 37.961    | 43.495     | 49.029     | 54.369     | 12/13               |
| ff         | 28.400    | 31.150    | 35.000     | 38.300     | 41.80      | 30/32 - Missing 31? |


| Corner     | dl_8 - dl_0 (ns) | dl_16 - dl_8 (ns) | dl_24 - dl_16 (ns) | dl_32 - dl_16 (ns) |
| ---------- | ---------------- | ----------------- | ------------------ | ------------------ |
| ss         | 7.977            | 7.978             | 8.034              | 7.977              |
| tt         | 5.485            | 5.534             | 5.534              | 5.340              |
| ff         | 2.750            | 3.850             | 3.300              | 3.500              | 

- Delay per inv in x_delay_line_cell
- 512 = 16 invs per cell * 32 stages
- (dl_32 - dl_0) / 512

| Corner     | Stage (ns) |
| ---------- | ---------- |
| ss         | 0.0624     |
| tt         | 0.0428     |
| ff         | 0.0262     |

- Delay per inv in x_delay_line_cell
- 256 = 16 invs per cell * 16 stages
- (dl_0 - 20) / 256

| Corner     | Stage (ns) |
| ---------- | ---------- |
| ss         | 0.0707     |
| tt         | 0.0487     |
| ff         | 0.0328     |

