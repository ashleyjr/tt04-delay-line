SIM ?= icarus
TOPLEVEL_LANG ?= verilog

VERILOG_SOURCES += $(PWD)/tb.sv
VERILOG_SOURCES += $(PWD)/../rtl/tt_um_ashleyjr_delay_line.sv 
VERILOG_SOURCES += $(PWD)/../rtl/x_uart_rx.sv
VERILOG_SOURCES += $(PWD)/../rtl/x_uart_tx.sv
VERILOG_SOURCES += $(PWD)/../rtl/x_driver.sv

TOPLEVEL = tb

MODULE = test

include $(shell cocotb-config --makefiles)/Makefile.sim
