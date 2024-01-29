vlib work

vlog -sv interface.sv
vlog -sv env_pkg.sv test_pkg.sv
vlog -sv counter.sv counter_tb.sv

vsim -novopt -suppress 12110 tb

do {wave.do}

run -all