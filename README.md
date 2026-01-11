# FIFO SystemVerilog Testbench (Separate WR/RD Architecture)

A professional, layered verification environment built to validate a **Synchronous FIFO**. This project features a modular architecture where **Write (WR)** and **Read (RD)** operations are handled by independent classes, simulating a real-world asynchronous-like traffic flow within a synchronous design.

## 📋 Features
* **Dual-Agent Architecture:** Independent Generator, Driver, and Monitor classes for Write and Read ports.
* **Constrained Randomization:** Targeted stimulus to hit FIFO boundary conditions like `Full`, `Empty`, and `Overflow`.
* **Interface-Based Design:** Utilizes `interface`, `clocking blocks`, and `modports` to ensure race-free sampling in Questa Sim.
* **Self-Checking Scoreboard:** Uses a SystemVerilog queue-based reference model to verify data integrity (First-In, First-Out).
* **Inter-Component Mailboxes:** Thread-safe communication between generators, drivers, and monitors.

---

## 🏗️ Testbench Architecture

The environment is structured to decouple the Write and Read logic, allowing them to run concurrently via `fork...join` blocks.



1.  **WR Agent:** Handles data generation and driving for the input side.
2.  **RD Agent:** Handles command generation and monitoring for the output side.
3.  **Scoreboard:** Collects data from both monitors and performs real-time comparison.

---

## 📂 File Structure

| File | Description |
| :--- | :--- |
| `fifoAsyn.v` | The RTL implementation of the Synchronous FIFO. |
| `fifoInterface.sv` | Interface containing `wr_cb` and `rd_cb` clocking blocks. |
| `wrTx.sv` | Data packet and constraints for Write operations. |
| `rdTx.sv` | Control packet for Read operations. |
| `monitor.sv` | Captures both WR and RD activity from the interface. |
| `scoreboard.sv` | Compares driven data against captured data using a queue. |
| `environment.sv` | Instantiates and connects all separate WR/RD components. |
| `top_tb.sv` | Top-level module for clock, reset, and DUT instantiation. |

---

## 🚀 Running in Questa Sim

Follow these steps to compile and simulate the project using Siemens Questa Sim:

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



