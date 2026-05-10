# cpe_487_finalProject_csecModule
*Theodore Rogalski, Ryan Manley, Mircea Florescu*
## Introduction
This project implements the SHA-256 hashing algorithm on a Nexys A7-100T FPGA using VHDL, with plaintexts entered using a USB keyboard and the output displayd through the VGA port on the FPGA.
## Background
The SHA-256 hashing algorithm converts a plaintext into a 256-bit hash. Details on this process are available [here](https://www.boot.dev/blog/computer-science/how-sha-2-works-step-by-step-sha-256/#step-5---create-message-schedule-w). Implementing this algorithm on an FPGA requires the usage of a hardware design language, in this case VHDL. Convenient entry of plaintext is made possible by the usage of a peripheral keyboard. The result of the encoding may be displayed on the screen using the VGA port.
## Tutorial
Use the [Vivado IDE](https://www.amd.com/en/products/software/adaptive-socs-and-fpgas/vivado.html) to open the project once it has been downloaded. Then, Generate Bitstream -> Hardware Manager -> Program Device. Connect a keyboard to the Nexys A7-100T device. As you type, you will see the plaintext and the hash. 
