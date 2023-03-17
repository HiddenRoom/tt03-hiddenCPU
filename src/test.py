import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, FallingEdge, Timer, ClockCycles

@cocotb.test()
async def test_my_design(dut):
    dut._log.info("start");
    clock = Clock(dut.clk, 1, units="ms");
    cocotb.start_soon(clock.start());
    dut.rst.value = 1;
    await ClockCycles(dut.clk, 1);
    dut.rst.value = 0;
    await ClockCycles(dut.clk, 5);
    dut._log.info(dut.outBus.value);
    #assert dut.outBus.value == 0b00000100; # outputting pc 5 cycles after reset so it should be 5
    dut.rst.value = 1;
    await ClockCycles(dut.clk, 1);
    dut.rst.value = 0;
    dut.instruction.value = 0b101101; # special case nop mov switches output from pc to r3
    await ClockCycles(dut.clk, 1);
    dut._log.info(dut.outBus.value);
    dut.instruction.value = 0b111110; # mov r3, r2 
    await ClockCycles(dut.clk, 1);
    dut._log.info(dut.outBus.value);
    #assert dut.outBus.value == 0b00000010; # r2 should be 0b00000010 after reset 
