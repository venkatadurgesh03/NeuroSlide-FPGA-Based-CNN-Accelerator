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

## Repository Structure
- `src/` RTL source files
- `sim/` Testbench and simulation files
- `memory/` COE / memory init files
- `ip/` Vivado IP core files
- `docs/` Reports and documentation
- `images/` Screenshots and diagrams

## Applications
- Automated automobiles / ADAS systems
- Road surface and pothole detection
- Real-time embedded vision systems
- Smart transportation infrastructure

## Project Status
Architecture designed and functionally verified through simulation and implementation in zedboard

## Future Work
- Extend the current single-image inference pipeline to continuous frame-stream processing for real-time road monitoring.
- Improve throughput using deeper pipelining, higher parallelism, and optimized memory scheduling.
- Integrate camera input and live video preprocessing on FPGA platforms such as ZedBoard.
- Enhance pothole classification accuracy using improved CNN models and quantized weights.
- Add GPS tagging and wireless reporting for smart road maintenance systems.
- Explore low-power deployment for edge-based automotive and transportation applications.
- 
## Author
Venkata Durgesh
