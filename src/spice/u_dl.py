import matplotlib.pyplot as plt
import numpy as np

BULK=16
DL=33
DATAS=32
TAPS=BULK+DL # bulk + dl
THRESHOLD=0.9

## Delay line data
f = open("delay_line.log","r+")
t = f.read()

time = []
clk = []
dl = {}
data = {}

for tap in range(TAPS):
    dl[f"{tap}"] = []

for d in range(DATAS):
    data[f"{d}"] = []


# Extract data
for line in t.split("\n")[0:-1]:
    d = line.split(" ")
    d = list(filter(None, d))
    time.append(float(d[0]))
    clk.append(float(d[1]))
    for i in range(TAPS):
        dl[f"{i}"].append(float(d[3+(2*i)]))
    for i in range(DATAS):
        data[f"{i}"].append(float(d[4+TAPS+(2*i)]))


# Find clk crossing index in arrays
clk_crossings = []
for i,t in enumerate(time[0:-1]):
    a = clk[i]
    b = clk[i+1]
    if (a < THRESHOLD) and (b >= THRESHOLD):
        clk_crossings.append(i)

# Find tap crossings
tap_crossings = []
for i,t in enumerate(time[0:-1]):
    for tap in range(TAPS):
        a = dl[f"{tap}"][i]
        b = dl[f"{tap}"][i+1]
        if (a < THRESHOLD) and (b >= THRESHOLD):
            tap_crossings.append(t)

# Sample data output
for i in clk_crossings:
    s = ""
    for d in range(DATAS):
        v = data[f"{d}"][i]
        if(v >= THRESHOLD):
            s = f"1{s}"
        else:
            s = f"0{s}"
    print(f"@{time[i]}: {s}")

# Plot crossings
plt.figure(1)
plt.scatter(range(len(tap_crossings)),tap_crossings)
plt.savefig("graph_crossings.png", dpi=200)

# Plot voltage
plt.figure(2)
plt.plot(time,clk)
for d in dl:
    plt.plot(time,dl[d],label=d)
plt.savefig("graph_voltage.png", dpi=200)

