vlib work
vlog tb.sv
vsim -novopt -suppress 12110 tb +testName=EMPTY
add wave -r sim:/tb/dut/*
run -all


