import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, FallingEdge, Timer, ClockCycles


async def send(dut, d):
    dut.ui_in.value = 0x00
    await ClockCycles(dut.clk, 434)
    for i in range(8):
        dut.ui_in.value = (d >> i) & 1
        await ClockCycles(dut.clk, 434)
    dut.ui_in.value = 1
    await ClockCycles(dut.clk, 434)

async def load_data(dut, d):
    for i in range(8):
        n = d >> (28 - (i*4))
        n &= 0xF
        n <<= 4
        await send(dut, n)

async def unload_data(dut):
    for i in range(4):
        await send(dut, 0x01)
        await ClockCycles(dut.clk, 20000)

@cocotb.test()
async def test_my_design(dut):
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
    await unload_data(dut)



    await ClockCycles(dut.clk, 1000)
