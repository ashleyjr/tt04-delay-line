import matplotlib.pyplot as plt
import numpy as np

TAPS=33
f = open("u_dl.log","r+")
t = f.read()

time = []
clk = []
dl = {}
for tap in range(TAPS):
    dl[f"dl_{tap}"] = []

for line in t.split("\n")[0:-1]:
    data = line.split(" ")
    data = list(filter(None, data))
    time.append(float(data[0]))
    clk.append(float(data[1]))
    for tap in range(TAPS):
        dl[f"dl_{tap}"].append(float(data[3+(2*tap)]))


plt.plot(time,clk)
for d in dl:
    plt.plot(time,dl[d],label=d)
plt.savefig("graph.png", dpi=200)

