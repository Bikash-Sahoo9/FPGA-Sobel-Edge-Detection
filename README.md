# Sobel Edge Detection on FPGA

**Tool:** Xilinx Vivado 2025.1 ML Edition  
**Device:** Artix-7 FPGA (xc7a35tftg256-1)  
**Language:** Verilog HDL  

---

## 🎯 Project Overview
This project implements the **Sobel Edge Detection algorithm** on FPGA using Verilog HDL.  
It processes grayscale image pixels in real-time to detect edges by computing horizontal (Gx) and vertical (Gy) gradients.  

The project demonstrates a **complete FPGA design workflow**: RTL design, testbench simulation, synthesis, implementation, and bitstream generation.  

> **Note:** The project has been fully tested in Vivado software and the bitstream is generated, but no physical FPGA board is required to run it.

---

## 🧩 Features
- Verilog-based design for real-time edge detection  
- Pixel-level gradient computation modules  
- RTL simulation and functional verification  
- Synthesis and implementation in Vivado  
- Bitstream generation (`sobel_top.bit`) ready for FPGA programming

---

## 🖥️ Simulation and Implementation
- Verified the Sobel filter using **testbench simulation**.  
- Ran **RTL analysis** and **implemented design** in Vivado.  
- Generated `.bit` file without physical hardware.  
- RTL schematic and implemented design can be exported for documentation purposes.

---

## 👤 Author
**Bikash Ratan Sahoo**  
Electronics & Telecommunication Engineer  
📧 [bikashsahooclg09@gmail.com](mailto:bikashsahooclg09@gmail.com)  
🔗 [LinkedIn](https://www.linkedin.com/in/bikashsahoo09)
