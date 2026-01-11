# Creating Workspace
#vlib work

# Compilation command
vlog tb.sv

# Optimization command
vopt tb +cover=fcbest -o TOGGLE

# Elaboration command
vsim -coverage TOGGLE +testName=TOGGLE

# Saving Coverage
coverage save -onexit TOGGLE.ucdb

# Add wave signals
add wave -r sim:/tb/pif/*

# Run all simulation
run -all


