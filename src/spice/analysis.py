import matplotlib.pyplot as plt
import numpy as np

f = open("output.txt","r+")
t = f.read()


data = {}
keys = []
state = "init"
index = 0
for l in t.split("\n"):
    # Transistions
    if l == "Variables:":
        state = "vars"
    elif l == "Values:":
        state = "vals"
    else:
        # State
        if state == "vars":
            data[l] = []
            keys.append(l)
        elif state == "vals":
            if index == len(keys):
                index = 0
            else:
                if '\t' in l:
                    d = l.split('\t')[-1]
                    data[keys[index]].append(float(d))
                    index += 1

x = data['\t0\ttime\ttime']
y = data['\t1\tv(x0.u_delay_line.dl_0)\tvoltage']
plt.plot(x,y)
y = data['\t2\tv(x0.u_delay_line.dl_8)\tvoltage']
plt.plot(x,y)
y = data['\t3\tv(x0.u_delay_line.dl_16)\tvoltage']
plt.plot(x,y)
y = data['\t4\tv(x0.u_delay_line.dl_24)\tvoltage']
plt.plot(x,y)
plt.grid()
plt.savefig("graph_full.png", dpi=400)
plt.xlim([0.41e-07, 0.44e-07])
plt.savefig("graph_zoom.png", dpi=400)
