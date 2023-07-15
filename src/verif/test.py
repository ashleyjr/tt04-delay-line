import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, FallingEdge, Timer, ClockCycles

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

    # Design has been selected
    await ClockCycles(dut.clk, 1000)
    dut.ena.value = 1

    # Design has been selected
    await ClockCycles(dut.clk, 1000)
    dut.ena.value = 1

    # UART is idle
    await ClockCycles(dut.clk, 1000)
    dut.ui_in.value = 0x01


    await ClockCycles(dut.clk, 1000)
