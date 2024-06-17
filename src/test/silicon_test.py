import serial
import serial.tools.list_ports
import time
import sys
import os
import time
import random
import argparse

KEYWORD="FT232R"

class Uart:
    def send(self, d):
        self.ser.write(d.to_bytes(1, byteorder='big'))
        while(self.ser.out_waiting > 0):
            pass

    def get(self):
        d = int.from_bytes(self.ser.read(1), byteorder='big')
        return int(d)

    def create(self,port,baud):
        self.ser = serial.Serial(
            port=port,
            baudrate=baud,
            parity=serial.PARITY_NONE,
            stopbits=serial.STOPBITS_ONE,
            bytesize=serial.EIGHTBITS,
            xonxoff=False,
            rtscts=False,
            dsrdtr=False,
            timeout=0.1
        )
        self.ser.flushInput()
        self.ser.flushOutput()

    def destory(self):
        self.ser.close()

    def search(self):
        ports = serial.tools.list_ports.comports()
        for port, desc, _ in sorted(ports):
            if KEYWORD in desc:
                print(f"Found: {port} to contain {KEYWORD}")
                return str(port)
            else:
                print(f"Skipping: {desc}")
        print("Error: No port found")
        sys.exit(1)

    def waiting(self):
        return self.ser.inWaiting()

class Test(Uart):

    def load_data(self, d):
        for i in range(10):
            n = d >> (36 - (i*4))
            n &= 0xF
            n <<= 4
            self.send(n)

    def unload_data(self):
        d = 0
        for i in range(5):
            while True:
                self.send(0x01)
                x = self.ser.read(1)
                if len(x) != 0:
                    d <<= 8
                    break
            d |= int.from_bytes(x, byteorder='big')
        return d

    def full_sample(self):
        self.send(0x02)
        return self.unload_data()

    def scope(self):
        timeout = True
        while timeout:
            timeout = False
            self.send(0x03)
            d = 0
            for i in range(5):
                self.send(0x01)
                d <<= 8
                x = self.ser.read(1)
                if len(x) == 0:
                    timeout = True
                    break
                d |= int.from_bytes(x, byteorder='big')
        ds = []
        for s in range(8):
            ds.append(d >> (35-(s*5)) & 0x1F)
        return ds

    def chk_uart_ok(self, loop=25, debug=False):
        fail = False
        for i in range(loop):
            CHK = random.randint(0,0xFFFFFFFFFF)
            self.load_data(CHK)
            a = self.unload_data()
            if(debug):
                print(f"{i:010X}: {CHK:010X}->{a:010X} = {CHK==a}")
            if(CHK != a):
                return False
        return True


    def log_full_sample(self, samples, logname):
        with  open(logname, 'w+') as f:
            for sample in range(samples):
                s = f"{self.full_sample():032b}\n\r"
                print(s,end='')
                f.write(s)


def main(temp, volt):
    u = Test()
    p = u.search()
    u.create(p,9600)

    # Basic UART echo
    print("UART Test...")
    if u.chk_uart_ok(10, True):
        print("PASS")
    else:
        print("FAIL")
        sys.exit(0)

    u.log_full_sample(100, f"{int(volt*1000):04d}mV_{temp:03d}C.log")

    u.destory()

if "__main__" == __name__:
    parser = argparse.ArgumentParser()
    parser.add_argument('-t', '--temp', default=21)
    parser.add_argument('-v', '--volt', default=1.8)
    args = parser.parse_args()
    main(int(args.temp), float(args.volt))

