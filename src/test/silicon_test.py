import serial
import serial.tools.list_ports
import time
import sys
import os
import time

KEYWORD="Lattice FTUSB Interface Cable"

class Uart:
    def send(self, d):
        self.ser.write(d)

    def get(self):
        d = self.ser.read(1)
        print(d)
        return int(d)

    def create(self,port,baud):
        self.ser = serial.Serial(
            port=port,
            baudrate=baud,
            parity=serial.PARITY_NONE,
            stopbits=serial.STOPBITS_ONE,
            bytesize=serial.EIGHTBITS,
            timeout=1
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
            self.send(0x01)
            d <<= 8
            d |= self.get()
        return d



def main():
    u = Test()
    p = u.search()
    u.create(p,115200)
    u.load_data(0xDEADBEEF)
    d = u.unload_data()
    print(d)
    u.destory()
    print("PASS")

if "__main__" == __name__:
    main()

