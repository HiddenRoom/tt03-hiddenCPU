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
    dut.instruction.value = 0b001001; # increasing memory pointer to uninitialized location
    await ClockCycles(dut.clk, 1);
    dut._log.info(dut.outBus.value);
    dut._log.info("test of add: opcode 0b00");
    assert dut.outBus.value == 0b00000100; # r3 will be 4 since it got the 1 in r1 added to it
    dut.instruction.value = 0b111010;
    await ClockCycles(dut.clk, 1);
    dut._log.info(dut.outBus.value);
    dut._log.info("test of subtraction via return to initialized memory location: opcode 0b01");
    dut.instruction.value = 0b011001; # decrementing to the initialized location
    await ClockCycles(dut.clk, 1);
    dut._log.info("should be xxxxxxxx for 2 below");
    dut._log.info(dut.outBus.value);
    dut.instruction.value = 0b111010;
    await ClockCycles(dut.clk, 1);
    dut._log.info(dut.outBus.value);
    dut.instruction.value = 0b001011; # r2 + r3 = 5
    await ClockCycles(dut.clk, 1);
    dut._log.info("test of memory read/write: opcode (extended for special operation) (read) 0b111010, (write) 0b110101");
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
    dut._log.info("test of xor: opcode 0b10");
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
    dut._log.info("test of swapping output to program counter: opcode (extended for special operation) 0b111111");
    assert dut.outBus.value == 0b00001100;
    dut.instruction.value = 0b011010; # r2 - r2 = 0
    await ClockCycles(dut.clk, 1);
    dut._log.info(dut.outBus.value);
    assert dut.outBus.value == 0b00101100; # swap back
    dut.instruction.value = 0b111110; # mov r3, r2
    await ClockCycles(dut.clk, 1);
    dut._log.info(dut.outBus.value);
    dut.instruction.value = 0b111101; # mov r3, r1  r3 = 1
    await ClockCycles(dut.clk, 1);
    dut._log.info(dut.outBus.value);
    dut._log.info("test of mov: opcode 0b11");
    assert dut.outBus.value == 0b00000000; # should be zero after moving r2 into r3 after zeroing r2
    dut.rst.value = 1;
    await ClockCycles(dut.clk, 1);
    dut.rst.value = 0;
    dut.instruction.value = 0b000101; # doubling r1, r1 = 2
    await ClockCycles(dut.clk, 1);
    dut._log.info(dut.outBus.value);
    dut.instruction.value = 0b000101; # doubling r1, r1 = 4
    await ClockCycles(dut.clk, 1);
    dut._log.info(dut.outBus.value);
    dut.instruction.value = 0b000101; # doubling r1, r1 = 8
    await ClockCycles(dut.clk, 1);
    dut._log.info(dut.outBus.value);
    dut.instruction.value = 0b000101; # doubling r1, r1 = 16
    await ClockCycles(dut.clk, 1);
    dut._log.info(dut.outBus.value);
    dut.instruction.value = 0b000101; # doubling r1, r1 = 32
    await ClockCycles(dut.clk, 1);
    dut._log.info(dut.outBus.value);
    dut.instruction.value = 0b000101; # doubling r1, r1 = 64
    await ClockCycles(dut.clk, 1);
    dut._log.info(dut.outBus.value);
    dut.instruction.value = 0b000101; # doubling r1, r1 = 128
    await ClockCycles(dut.clk, 1);
    dut._log.info(dut.outBus.value);
    dut.instruction.value = 0b000101; # doubling r1, OVERFLOW r1 = 0, carryFlag = 1, pc = 10
    await ClockCycles(dut.clk, 1);
    dut._log.info(dut.outBus.value);
    dut.instruction.value = 0b111111; # swap output to pc, pc = 9
    await ClockCycles(dut.clk, 1);
    dut._log.info(dut.outBus.value);
    dut.instruction.value = 0b110000; # adding to r3 to pc since carryFlag is high, pc = 10 + 3 - 1 = 12
    await ClockCycles(dut.clk, 1);
    dut._log.info(dut.outBus.value);
    await RisingEdge(dut.clk);
    dut._log.info(dut.outBus.value);
    dut._log.info("test of branch if carry: opcode (extended for special operation) 0b110000");
    assert dut.outBus.value == 0b00001100;

    '''
    TODO

    add test of conditional branching based on carry
    '''
