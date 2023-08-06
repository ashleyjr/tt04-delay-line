import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, FallingEdge, Timer, ClockCycles
from cocotb.handle import Force

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

async def dl(dut):
    await send(dut, 0x02)

async def pvt(dut, v):
    dut.u_dut.u_delay_line.u_dl_0.sel.value = v
    dut.u_dut.u_delay_line.u_dl_1.sel.value = v
    dut.u_dut.u_delay_line.u_dl_2.sel.value = v
    dut.u_dut.u_delay_line.u_dl_3.sel.value = v
    dut.u_dut.u_delay_line.u_dl_4.sel.value = v
    dut.u_dut.u_delay_line.u_dl_5.sel.value = v
    dut.u_dut.u_delay_line.u_dl_6.sel.value = v
    dut.u_dut.u_delay_line.u_dl_7.sel.value = v
    dut.u_dut.u_delay_line.u_dl_8 .sel.value = v
    dut.u_dut.u_delay_line.u_dl_9 .sel.value = v
    dut.u_dut.u_delay_line.u_dl_10.sel.value = v
    dut.u_dut.u_delay_line.u_dl_11.sel.value = v
    dut.u_dut.u_delay_line.u_dl_12.sel.value = v
    dut.u_dut.u_delay_line.u_dl_13.sel.value = v
    dut.u_dut.u_delay_line.u_dl_14.sel.value = v
    dut.u_dut.u_delay_line.u_dl_15.sel.value = v
    dut.u_dut.u_delay_line.u_dl_16.sel.value = v
    dut.u_dut.u_delay_line.u_dl_17.sel.value = v
    dut.u_dut.u_delay_line.u_dl_18.sel.value = v
    dut.u_dut.u_delay_line.u_dl_19.sel.value = v
    dut.u_dut.u_delay_line.u_dl_20.sel.value = v
    dut.u_dut.u_delay_line.u_dl_21.sel.value = v
    dut.u_dut.u_delay_line.u_dl_22.sel.value = v
    dut.u_dut.u_delay_line.u_dl_23.sel.value = v
    dut.u_dut.u_delay_line.u_dl_24.sel.value = v
    dut.u_dut.u_delay_line.u_dl_25.sel.value = v
    dut.u_dut.u_delay_line.u_dl_26.sel.value = v
    dut.u_dut.u_delay_line.u_dl_27.sel.value = v
    dut.u_dut.u_delay_line.u_dl_28.sel.value = v
    dut.u_dut.u_delay_line.u_dl_29.sel.value = v
    dut.u_dut.u_delay_line.u_dl_30.sel.value = v
    dut.u_dut.u_delay_line.u_dl_31.sel.value = v
    dut.u_dut.u_delay_line.u_dl_32.sel.value = v

@cocotb.test()
async def deadbeef(dut):
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

@cocotb.test()
async def capture(dut):
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

    # Force delay model
    await pvt(dut,500)

    # Capture delay line
    await dl(dut)

    # Unload
    d = await unload_data(dut)

    assert d == 0x0000007F

