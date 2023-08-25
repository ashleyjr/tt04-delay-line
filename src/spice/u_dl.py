import matplotlib.pyplot as plt
import numpy as np

BULK=21
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
                self.data[f"{i}"].append(float(d[3+(2*TAPS)+(2*i)]))
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

    def getData(self):
        return self.data

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
        self.times = []
        self.traces = []
        self.labels = []

    def plotTaps(self, taps, labels):
        assert self.taps == True
        for i,t in enumerate(taps):
            plt.scatter(range(len(taps[t])),taps[t], s=1, label=labels[i])
        plt.grid(True, which='major')
        plt.grid(True, which='minor')
        plt.legend()
        plt.title(self.name)
        plt.xlabel("Position")
        plt.ylabel("Time (ns)")

    def plotRef(self, x0, y0, x1, y1):
        plt.plot([x0,x1],[y0,y1],linewidth=1)
        #plt.xlim([x0,x1])

    def plotTrace(self, time, voltage, label=""):
        assert self.trace == True
        self.times.append(time)
        self.traces.append(voltage)
        self.labels.append(label)

    def save(self):
        #plt.subplots(len(self.traces),1)
        plt.rcParams.update({'font.size': 4})
        i = 1
        for label,time,trace in zip(self.labels,self.times,self.traces):
            plt.subplot(len(self.traces),1,i)
            plt.plot(time,trace)
            plt.gca().get_xaxis().set_visible(False)
            plt.ylabel(f"{label} (V)")
            i += 1
        plt.gca().get_xaxis().set_visible(True)
        plt.xlabel('Time (s)')
        plt.savefig(f"graph_{self.name}.png", dpi=200)

def main():
    #ss = Analysis("analysis/004_corners_sim/delay_line_ss.log")
    #tt = Analysis("analysis/004_corners_sim/delay_line_tt.log")
    #ff = Analysis("analysis/004_corners_sim/delay_line_ff.log")

    v = Analysis("analysis/007_voltage_change_3/delay_line_tt_voltage.log")

    def print_guide(name, l):
        print(f"{name}")
        s = ""
        for i in range(l):
            s = f"{str(hex(i % 16))[2]}{s}"
        print(s)

    for test in [v]:
        print_guide("D", 70)
        samples = test.getSampleTaps()
        for s in samples:
            print(f"{s}:\t{samples[s]}")

    print("Sampled Data:")
    for test in [v]:
        print_guide("Q", 48)
        samples = test.getSamples()
        for s in samples:
            print(f"{s}:\t{samples[s]}")


    p = Plotter("q_trace", trace=True)
    taps = v.getTrace()
    p.plotTrace(v.getTime(),v.getVdd(),"VDD")
    p.plotTrace(v.getTime(),v.getClock(), "CLK")
    for i in range(8,18):
        p.plotTrace(v.getTime(),v.getData()[f"{i}"],f"Q[{i}]")
    p.save()

    p = Plotter("d_trace", trace=True)
    taps = v.getTrace()
    p.plotTrace(v.getTime(),v.getVdd(),"VDD")
    p.plotTrace(v.getTime(),v.getClock(), "CLK")
    for i in range(25,TAPS-13):
        p.plotTrace(v.getTime(),v.getTaps()[f"{i}"],f"Q[{i}]")
    p.save()

    # Plot the delays
    p = Plotter("taps", taps=True)
    p.plotTaps(v.getTapCrossings(), ["750mV","770mV","790mV","810mV","830mV", "850mV"])
    p.plotRef(0,2e-8,50,2e-8)
    p.plotRef(35,0,35,3e-8)
    p.plotRef(36,0,36,3e-8)
    p.plotRef(37,0,37,3e-8)
    p.save()

if "__main__" == __name__:
    main()
