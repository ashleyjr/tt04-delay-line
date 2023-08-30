import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, FallingEdge, Timer, ClockCycles
from cocotb.handle import Force

CLK = 50000000
BAUD = 9600
DELAY = int(CLK / BAUD)
DELAY_1_5 = int(DELAY * 1.5)


# Delay line LUT
# - Contains the delay need to position the delay
# - All in fs
dl_lut = [
    56000,
    54000,
    52000,
    51000,
    50000,
    48000,
    47000,
    45000,
    44000,
    43000,
    42000,
    41000,
    40000,
    39000,
    38000,
    37000,
    36500,
    35500,
    34500,
    34000,
    33500,
    32500,
    32000,
    31500,
    31000,
    30500,
    30000,
    29500,
    29000,
    28500,
    28000,
    27500
]

# Checker with debug output
def check(dut, expected, got):
    if(expected != got):
        dut._log.info(f"Expected: {expected}/{hex(expected)}")
        dut._log.info(f"Got:      {got}/{hex(got)}")
        assert(False)

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
    for i in range(10):
        n = d >> (36 - (i*4))
        n &= 0xF
        n <<= 4
        await send(dut, n)

async def unload_data(dut):
    d = 0
    for i in range(5):
        await send(dut, 0x01)
        d <<= 8
        d |= await get(dut)
    return d

async def dl(dut):
    await send(dut, 0x02)

async def short(dut):
    await send(dut, 0x03)
    await send(dut, 0x01)
    d = await get(dut)
    return d >> 3

async def scope(dut):
    await send(dut, 0x03)
    d = await unload_data(dut)
    samples = []
    for i in range(8):
        samples.append(0x1F & (d >> 35))
        d <<= 5
    return samples

async def pvt(dut, delay):
    for bulk in range(22):
        for inv in range(16):
            exec(f"dut.u_dut.u_delay_line.u_bulk_{bulk}.u_inv_{inv}.sel.value = delay")
    for dl in range(32):
        for inv in range(12):
            exec(f"dut.u_dut.u_delay_line.u_dl_{dl}.u_inv_{inv}.sel.value = delay")

async def pvt_change(dut, time, delay0, delay1):
    await pvt(dut, delay0)
    await Timer(time, units="ns")
    await pvt(dut, delay1)

@cocotb.test(skip=True)
async def deadbeef(dut):
    dut._log.info("start")

    # Turn off to speed up sim
    await pvt(dut,0)

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
    await load_data(dut, 0x123456789A)

    # Unload
    d = await unload_data(dut)

    check(dut, 0x123456789A, d)

@cocotb.test(skip=True)
async def capture_short_sweep(dut):
    dut._log.info("start")

    # Turn off to speed up sim
    await pvt(dut,0)

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

    # Sweep the entire delay line
    for i in range(len(dl_lut)):
        dut._log.info(f"Delay line pos: {i} ({dl_lut[i]}fs per inv)")
        await pvt(dut,dl_lut[i])
        d = await short(dut)
        check(dut, i,d)


@cocotb.test()
async def capture_long(dut):
    dut._log.info("start")

    # Turn off to speed up sim
    await pvt(dut,0)

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

    # Capture delay line
    # - Spped up by turning on then off
    await pvt(dut,dl_lut[16])
    await dl(dut)
    await pvt(dut,0)

    # Unload
    d = await unload_data(dut)

    check(dut, 0x000000000FFFF,d)

@cocotb.test(skip=True)
async def capture_scope(dut):
    dut._log.info("start")

    # Turn off to speed up sim
    await pvt(dut,0)

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

    # Run the scope but change half way through
    await cocotb.start(pvt_change(dut, 74200, dl_lut[7], dl_lut[8]))
    s = await scope(dut)
    dut._log.info(f"Scope: {s}")

    assert(s == [7, 7, 7, 7, 7, 7, 7, 8] )




