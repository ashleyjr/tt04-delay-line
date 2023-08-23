import matplotlib.pyplot as plt
import numpy as np

BULK=16
DL=33
DATAS=32
TAPS=BULK+DL # bulk + dl
THRESHOLD=0.9

class Analysis:

    def __init__(self, filename):
        f = open(filename,"r+")
        self.logfile= f.read()
        f.close()
        self.__extractLogfile()
        self.__extractClockCrossings()
        self.__sampleTaps()
        self.__sampleOutputData()

        self.__extractTapCrossings()
        self.__sampleOutputData()
        self.__extractEdges()


    def __extractLogfile(self):
        self.time = []
        self.clk = []
        self.dl = {}
        self.data = {}
        self.vdd = []
        for tap in range(TAPS):
            self.dl[f"{tap}"] = []
        for d in range(DATAS):
            self.data[f"{d}"] = []
        for line in self.logfile.split("\n")[0:-1]:
            d = line.split(" ")
            d = list(filter(None, d))
            self.time.append(float(d[0]))
            self.clk.append(float(d[1]))
            for i in range(TAPS):
                self.dl[f"{i}"].append(float(d[3+(2*i)]))
            for i in range(DATAS):
                self.data[f"{i}"].append(float(d[4+TAPS+(2*i)]))
            self.vdd.append(float(d[-1]))

    def __extractClockCrossings(self):
        self.clk_crossings = []
        for i,t in enumerate(self.time[0:-1]):
            a = self.clk[i]
            b = self.clk[i+1]
            if (a < THRESHOLD) and (b >= THRESHOLD):
                self.clk_crossings.append(i)

    def __extractTapCrossings(self):
        self.tap_crossings = {}
        cycle = 0
        for i,t in enumerate(self.time[0:-1]):
            for tap in range(TAPS):
                a = self.dl[f"{tap}"][i]
                b = self.dl[f"{tap}"][i+1]
                if (a < THRESHOLD) and (b >= THRESHOLD):
                    if tap == 0:
                        self.tap_crossings[f"{cycle}"] = []
                        offset = t

                    self.tap_crossings[f"{cycle}"].append(t-offset)

                    if tap == TAPS-1:
                        cycle += 1

    def __sampleTaps(self):
        self.sample_taps = {}
        for i in self.clk_crossings:
            s = ""
            for d in range(TAPS):
                v = self.dl[f"{d}"][i]
                if(v >= THRESHOLD):
                    s = f"1{s}"
                else:
                    s = f"0{s}"
            self.sample_taps[str(self.time[i])] = s


    def __sampleOutputData(self):
        self.sample = {}
        for i in self.clk_crossings:
            s = ""
            for d in range(DATAS):
                v = self.data[f"{d}"][i]
                if(v >= THRESHOLD):
                    s = f"1{s}"
                else:
                    s = f"0{s}"
            self.sample[str(self.time[i])] = s

    def __extractEdges(self):
        self.edges = {}
        for s in self.sample:
            taps = self.sample[s]
            self.edges[s] = -1
            for i in range(1,len(taps)):
                if (taps[len(taps)-i] == "1") and (taps[len(taps)-i-1] == "0"):
                    self.edges[s] = i

    def getTime(self):
        return self.time

    def getVdd(self):
        return self.vdd

    def getClock(self):
        return self.clk

    def getTrace(self):
        return self.dl

    def getTaps(self):
        return self.dl

    def getTapCrossings(self):
        return self.tap_crossings

    def getSampleTaps(self):
        return self.sample_taps

    def getSamples(self):
        return self.sample

    def getEdges(self):
        return self.edges


class Plotter:

    def __init__(self, name, taps=False, trace=False):
        self.name = name
        self.taps = taps
        self.trace = trace
        assert self.taps ^ self.trace
        plt.figure()

    def plotTaps(self, taps):
        assert self.taps == True
        for t in taps:
            plt.scatter(range(len(taps[t])),taps[t], s=1, label=t)
        plt.grid(which='minor')
        plt.legend()
        plt.title(self.name)
        plt.xlabel("Position")
        plt.ylabel("Time (ns)")


    def plotTrace(self, time, voltage):
        assert self.trace == True
        plt.plot(time,voltage)

    def save(self):
        plt.savefig(f"graph_{self.name}.png", dpi=200)

def main():
    #ss = Analysis("analysis/004_corners_sim/delay_line_ss.log")
    #tt = Analysis("analysis/004_corners_sim/delay_line_tt.log")
    #ff = Analysis("analysis/004_corners_sim/delay_line_ff.log")

    v = Analysis("analysis/006_voltage_change_2/delay_line_tt_voltage.log")



    #p = Plotter("ss_trace", trace=True)
    #taps = ss.getTrace()
    #p.plotTrace(ss.getTime(),ss.getClock())
    #p.plotTrace(ss.getTime(),taps[str(TAPS-DL)])
    #p.plotTrace(ss.getTime(),taps[str(TAPS-1)])
    #p.save()

    p = Plotter("v_trace", trace=True)
    taps = v.getTrace()
    #p.plotTrace(v.getTime(),v.getClock())
    #p.plotTrace(v.getTime(),taps[str(TAPS-DL)])
    #p.plotTrace(v.getTime(),taps[str(TAPS-1)])
    p.plotTrace(v.getTime(),v.getVdd())
    p.save()


    def print_guide(name, l):
        print(f"{name}")
        s = ""
        for i in range(l):
            s = f"{str(hex(i % 16))[2]}{s}"
        print(s)

    for test in [v]:
        print_guide("D", 65)
        samples = test.getSampleTaps()
        for s in samples:
            print(f"{s}:\t{samples[s]}")

    print("Sampled Data:")
    for test in [v]:
        print_guide("Q", 48)
        samples = test.getSamples()
        for s in samples:
            print(f"{s}:\t{samples[s]}")


    # Plot the clock
    #p = Plotter("tt_clk", trace=True)
    #p.plotTrace(u.getTime(),u.getClock())
    #p.save()

    # Plot the clock
    p = Plotter("taps", taps=True)
    p.plotTaps(v.getTapCrossings())
    p.save()




if "__main__" == __name__:
    main()
