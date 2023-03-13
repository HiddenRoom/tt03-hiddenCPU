SIM ?= icarus
TOPLEVEL_LANG ?= verilog

VERILOG_SOURCES += $(PWD)/tb.v $(PWD)/top.v $(PWD)/decode.v $(PWD)/mux.v $(PWD)/add.v $(PWD)/ALU.v $(PWD)/sub.v $(PWD)/xor.v $(PWD)/movAndBranch.v

TOPLEVEL = tb

MODULE = test

include $(shell cocotb-config --makefiles)/Makefile.sim
