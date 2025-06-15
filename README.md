# 5-State FSM Traffic Controller (Verilog)

## Overview

This project implements a 5-State Finite State Machine (FSM) Traffic Controller using Verilog HDL. The design controls traffic signals with support for:
- Regular vehicle flow (Green, Yellow, Red)
- Pedestrian crossing requests
- Emergency vehicle override

The system ensures safe and efficient traffic management by dynamically handling normal operation, pedestrian signals, and emergency conditions.

## FSM Design

The controller operates in 5 distinct states:

- **Red State (100):** Vehicles stop; pedestrians may cross if requested.
- **Yellow State (010):** Transition phase before switching between red and green.
- **Green State (001):** Vehicles move normally.
- **Pedestrian State (100):** Pedestrian signal active.
- **Emergency State (100):** Emergency mode activated, giving priority to emergency vehicles.

*Note: Some states share the same encoded value, but internal logic manages correct transitions based on conditions.*

## State Transition Logic

- The system moves from Green State to Yellow State when the counter exceeds Green_Time.
- It moves from Yellow State to Red State when the counter exceeds Yellow_Time.
- In Red State, if a pedestrian request is active (Ped_signal = 1), it transitions to Pedestrian State. Otherwise, it goes to Green State after Red_Time expires.
- At any time, if the emergency signal (emergency_signal = 1) is active, the FSM moves to Emergency State.
- The system remains in Emergency State until the counter exceeds EMG_Time and emergency_signal returns to 0, after which it transitions back to Green State.

## Features

- Fully parameterized FSM-based traffic controller
- Handles normal traffic flow, pedestrian requests, and emergency vehicle prioritization
- Parameterized time settings: Green_Time, Yellow_Time, Red_Time, Ped_Time, EMG_Time
- Verilog HDL implementation
- Can be easily simulated and synthesized for FPGA deployment

## Files Included

- `traffic.v` — Verilog module containing the FSM logic
- `traffic_tb.v` — Testbench for simulation and verification

## Tools Used

- Verilog HDL
- Simulation software (ModelSim, Vivado, Quartus Prime, etc.)
