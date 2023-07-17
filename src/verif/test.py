import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, FallingEdge, Timer, ClockCycles

CLK = 50000000
BAUD = 115200
DELAY = int(CLK / BAUD)
DELAY_1_5 = int(DELAY * 1.5)

async def send(dut, d):
    dut.ui_in.value = 0x00
    await ClockCycles(dut.clk, DELAY)
    for i in range(8):
        dut.ui_in.value = (d >> i) & 1
        await ClockCycles(dut.clk, DELAY)
    dut.ui_in.value = 0x01
    await ClockCycles(dut.clk, DELAY)

async def get(dut):
    rx = 0
    while(1):
        await RisingEdge(dut.clk)
        if(dut.uo_out.value == 0):
            break
    await ClockCycles(dut.clk, DELAY_1_5)
    for i in range(8):
        rx >>= 1
        rx |= (dut.uo_out.value & 1) << 7
        await ClockCycles(dut.clk, DELAY)
    await ClockCycles(dut.clk, DELAY)
    return rx


async def load_data(dut, d):
    for i in range(8):
        n = d >> (28 - (i*4))
        n &= 0xF
        n <<= 4
        await send(dut, n)

async def unload_data(dut):
    d = 0
    for i in range(4):
        await send(dut, 0x01)
        d <<= 8
        d |= await get(dut)
    return d

@cocotb.test()
async def test_deadbeef(dut):
    dut._log.info("start")

    # Setup 50MHz clock
    clock = Clock(dut.clk, 20, units="ns")
    cocotb.start_soon(clock.start())

    # Reset design (active low)
    dut.rst_n.value = 0
    await ClockCycles(dut.clk, 10)
    dut.rst_n.value = 1

    await ClockCycles(dut.clk, 10)

    # Design has been selected
    dut.ena.value = 1

    # UART is idle
    dut.ui_in.value = 0x01
    await ClockCycles(dut.clk, 100)

    # Load
    await load_data(dut, 0xDEADBEEF)

    # Unload
    d = await unload_data(dut)

    assert d == 0xDEADBEEF

