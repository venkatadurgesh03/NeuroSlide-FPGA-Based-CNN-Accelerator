# NeuroSlide – FPGA Based CNN Accelerator

## Overview
NeuroSlide is a custom FPGA-based CNN accelerator developed for efficient real-time image classification and pothole detection. The design uses Verilog HDL with pipelining, parallel convolution units, and BRAM-based streaming architecture to accelerate CNN workloads.

## Key Features
- FPGA-oriented CNN accelerator architecture
- Verilog HDL implementation
- Parallel convolution engine
- ReLU activation and max pooling
- BRAM-based memory streaming
- Pipelined multi-stage processing
- Fixed-point hardware computation

## CNN Pipeline
Input Image (64x64)  
→ Convolution Layer 1 (8 Filters)  
→ ReLU  
→ Max Pooling  
→ Convolution Layer 2 (16 Filters)  
→ ReLU  
→ Max Pooling  
→ Flattening  
→ ANN Classifier

## Hardware Concepts Used
- Line Buffers
- Sliding Window Convolution using Systolic Arrays
- Parallel MAC Operations
- BRAM Memory Access
- Pipelined Dataflow

## Tools Used
- Verilog HDL
- FPGA Design Flow
- RTL Simulation
- Xilinx Vivado

## Project Status
Architecture designed and functionally verified through simulation and implementation in zedboard

## Author
Venkata Durgesh
