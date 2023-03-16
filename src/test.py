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
    dut.instruction.value = 0b110110; 
    await ClockCycles(dut.clk, 1);
    dut.rst.value = 0;
    await ClockCycles(dut.clk, 5);
    dut._log.info(dut.outBus.value);
    assert dut.outBus.value == 0b00000100; # outputting pc 5 cycles after reset so it should be 5
