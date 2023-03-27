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
    dut.instruction.value = 0b001011; # r2 + r3 = 5
    await ClockCycles(dut.clk, 1);
    assert dut.outBus.value == 0b00000011; # r3 will be written to the state it had before being added to
    dut._log.info(dut.outBus.value);
    dut.instruction.value = 0b001011; # r2 + r3 = 8
    await ClockCycles(dut.clk, 1);
    dut._log.info(dut.outBus.value);
    dut.instruction.value = 0b101110; # r3 ^ r2 = 0b00001000 ^ 0b00000011 = 0b00001011
    await ClockCycles(dut.clk, 1);
    dut._log.info(dut.outBus.value);
    dut.instruction.value = 0b001111;
    await ClockCycles(dut.clk, 1);
    dut._log.info(dut.outBus.value);
    assert dut.outBus.value == 0b00001011;
    dut.instruction.value = 0b001111;
    await ClockCycles(dut.clk, 1);
    dut._log.info(dut.outBus.value);
    dut.instruction.value = 0b111111; # swap output to pc which will be 13 since that many instructions - 1 have been run since reset
    await ClockCycles(dut.clk, 1);
    dut._log.info(dut.outBus.value);
    dut.instruction.value = 0b111111;
    await ClockCycles(dut.clk, 1);
    dut._log.info(dut.outBus.value);
    assert dut.outBus.value == 0b00001101;
    await RisingEdge(dut.clk);
    dut._log.info(dut.outBus.value);
    assert dut.outBus.value == 0b00101100; # swap back
    '''
    TODO
    
    add test of mov instruction 
    '''
