import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, FallingEdge, Timer, ClockCycles

@cocotb.test()
async def test_my_design(dut):
    dut._log.info("start");
    clock = Clock(dut.clk, 1, units="ms");
    cocotb.start_soon(clock.start());
    await ClockCycles(dut.clk, 1);
    dut.rst.value = 1;
    await ClockCycles(dut.clk, 1);
    dut.rst.value = 0;
    dut.instruction.value = 0b110101;
    await ClockCycles(dut.clk, 1);
    dut.instruction.value = 0b001101;
    await ClockCycles(dut.clk, 1);
    dut._log.info(dut.outBus.value);
    await RisingEdge(dut.clk);
    assert dut.outBus.value == 0b00000100; # r3 will be 4 since it got the 1 in r1 added to it
    dut.instruction.value = 0b001001; # increasing memory pointer to uninitialized location
    await ClockCycles(dut.clk, 1);
    dut._log.info(dut.outBus.value);
    dut.instruction.value = 0b111010;
    await ClockCycles(dut.clk, 1);
    dut._log.info(dut.outBus.value);
    dut.instruction.value = 0b011001; # decrementing to the initialized location
    await ClockCycles(dut.clk, 1);
    dut._log.info("should be xxxxxxxx for 2 below");
    dut._log.info(dut.outBus.value);
    dut.instruction.value = 0b111010;
    await ClockCycles(dut.clk, 1);
    dut._log.info(dut.outBus.value);
    await RisingEdge(dut.clk);
    dut._log.info(dut.outBus.value);
    assert dut.outBus.value == 0b00000011; # r3 will be written to the state it had before being added to
