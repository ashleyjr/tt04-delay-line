import argparse
import matplotlib.pyplot as plt
from matplotlib.ticker import MultipleLocator
import numpy as np
import os

class Analysis:

    def __init__(self, directory):
        self.v = []
        self.b = []
        for (dirpath, dirnames, filenames) in os.walk(directory):
            for filename in filenames:
                # Check file
                assert("mV_" in filename)
                assert("C.log" in filename)

                # Voltage
                data = filename.split(".")[0]
                v = int(data.split("mV_")[0]) / float(1000)

                # Load data
                with open(os.path.join(directory,filename)) as f:
                    lines = f.read()
                for line in lines.split("\n\n")[:-1]:
                    assert(len(line) == 32)
                    for i in range(32):
                        if line[31-i] == "1":
                            self.v.append(v)
                            self.b.append(i)


    def plot(self):
        plt.clf()
        plt.hist2d( self.v,
                    self.b,
                    bins=[80,32],
                    cmap='cool',
                    linewidth=1)
        ax = plt.gca()
        ax.minorticks_on()
        ax.yaxis.set_major_locator(MultipleLocator(4))
        ax.yaxis.set_minor_locator(MultipleLocator(1))
        ax.grid(which='major', color='black', linestyle='-', linewidth=0.2)
        ax.grid(which='minor', color='black', linestyle='-', linewidth=0.2)
        plt.savefig("graph.png", dpi=200)

def main(directory):
    u = Analysis(directory)
    u.plot()

if "__main__" == __name__:
    parser = argparse.ArgumentParser()
    parser.add_argument('-d', '--directory')
    args = parser.parse_args()
    main(args.directory)
