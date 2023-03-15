import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, FallingEdge, Timer, ClockCycles

@cocotb.test()
async def test_my_design(dut):
    dut._log.info("start");
    clock = Clock(dut.clk, 1, units="ms");
    cocotb.start_soon(clock.start());
    dut._log.info("making sure reset works as intended");
    dut.rst.value = 1;
    dut.instruction.value = 52;
    await ClockCycles(dut.clk, 3);
    dut._log.info(dut.outBus.value);
