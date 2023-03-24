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
    dut.instruction.value = 0b001101;
    await ClockCycles(dut.clk, 1);
    dut._log.info(dut.outBus.value);
    dut.instruction.value = 0b110101;
    await ClockCycles(dut.clk, 1);
    dut.instruction.value = 0b001111;
    await ClockCycles(dut.clk, 1);
    dut._log.info(dut.outBus.value);
    dut.instruction.value = 0b011101;
    await ClockCycles(dut.clk, 1);
    dut._log.info(dut.outBus.value);
    dut._log.info(dut.outBus.value);
    dut.instruction.value = 0b111010;
    await ClockCycles(dut.clk, 1);
    dut._log.info(dut.outBus.value);
    await RisingEdge(dut.clk);
    dut._log.info(dut.outBus.value);
