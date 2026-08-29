# Asynchronous Mod-60 Counter in SystemVerilog

A cascaded asynchronous (ripple) Mod-60 counter designed in SystemVerilog. The design consists of a Mod-10 counter (BCD units digit) cascaded with a Mod-6 counter (tens digit) using toggle flip-flops (`t_ff`).

---

## Overview

The Mod-60 counter counts from `00` to `59` and resets back to `00`. It is implemented using:

- **Mod-10 Stage (`Q_10`):** A 4-bit asynchronous counter that counts from `0` to `9` (`0000` to `1001` binary) and resets upon reaching state `10` (`1010` binary).
- **Mod-6 Stage (`Q_6`):** A 3-bit asynchronous counter that counts from `0` to `5` (`000` to `101` binary) and resets upon reaching state `6` (`110` binary).
- **Cascading:** The clock for the Mod-6 stage is driven by the inverted MSB of the Mod-10 stage (`~Q_10[3]`), triggering the tens digit increment when the units digit overflows from 9 to 0.

---

## Repository Structure

```text
├── design.sv             # SystemVerilog source code (mod_60_counter, t_ff)
├── testbench.sv          # Testbench simulation file
├── waveform_result.pdf   # Simulated waveform output
└── README.md             # Project documentation
```

---

## Module Descriptions

### 1. `t_ff` (Toggle Flip-Flop)

- **Inputs:** `clk`, `rst` (active-low asynchronous reset), `t` (toggle enable)
- **Outputs:** `q` (registered output initialized to `1'b0`)
- **Behavior:** Inverts output on every positive clock edge when `t = 1'b1`.

### 2. `mod_60_counter`

- **Inputs:** `clk`
- **Outputs:**
  - `Q_10[3:0]` — 4-bit binary output for units digit (0–9)
  - `Q_6[2:0]` — 3-bit binary output for tens digit (0–5)
- **Reset Logic:**
  - `gated_rst_10 = ~(Q_10[3] & Q_10[1])` (Resets at 10)
  - `gated_rst_6 = ~(Q_6[2] & Q_6[1])` (Resets at 6)

---

## Simulation and Verification

The design can be compiled and simulated using standard EDA tools such as ModelSim, QuestaSim, Vivado, or EDA Playground.

### Running with Icarus Verilog / GTKWave

```bash
iverilog -g2012 -o mod_60_sim design.sv testbench.sv
vvp mod_60_sim
gtkwave dump.vcd
```
