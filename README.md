# cpe_487_finalProject_csecModule
*Theodore Rogalski, Ryan Manley, Mircea Florescu*
## Introduction
This project implements the SHA-256 hashing algorithm on a Nexys A7-100T FPGA using VHDL, with plaintexts entered using a USB keyboard and the output displayed through the VGA port on the FPGA.
## Expected Behavior 
The expected behavior of the system is as follows, first in sentences and then in bullet points.

### Written Description 
The user connects a keyboard and monitor to the FPGA  using the keyboard’s USB cable and VGA HDMI Adapter respectively. Then, they may upload the code onto the board, and will be able to type an arbitrary 32 bit (8 hex characters, 4 bytes, 4 ASCII characters) into it. As they type, they will see both the inputted text from the keyboard on the screen in ASCII as well as the plaintext run through the well known SHA-256 hashing algorithm as in the following image:

## INCLUDE IMAGE HERE

### Bullet Point Description				




## Background
The SHA-256 hashing algorithm converts a plaintext into a 256-bit hash. Details on this process are available [here](https://www.boot.dev/blog/computer-science/how-sha-2-works-step-by-step-sha-256/#step-5---create-message-schedule-w). Implementing this algorithm on an FPGA requires the usage of a hardware design language, in this case VHDL. Convenient entry of plaintext is made possible by the usage of a peripheral keyboard. The result of the encoding may be displayed on the screen using the VGA port.
## Tutorial
# Parts Needed
1. Nexys A7-100T FPGA Board
2. VGA to HDMI Converter (Ventron Brand confirmed working)
3. Keyboard with USB cable connection
4. Monitor with HDMI Port 
5. Micro USB to USB-A connector

# Step-by-Step Instructions

1. Open the Vivado IDE (version 2025.2 confirmed working)
2. Download the CPE487_Cybersecurity_Module folder, and open it using the Vivado IDE
3. Click Generate Bitstream in the bottom left
4. Once the bitstream has finished generating, click "Open Hardware Manager" and connect the computer to the FPGA board using the USB to Micro USB connector 
5. Ensure that the board is in the correct physical configuration (turned on, blue connector on the JTAG connected as shown, etc.)
6. Press Auto-connect to the board, then program device once available
7. Once device is programmed, the 8 hexadecimal display ports will be turned on and set to 0 
8. Type into the keyboard; each ASCII character will be shifted into the keycode signal, which is 32 bits long with the end being truncated, the beginning 
9. 
 



A description of the expected behavior of the project, attachments needed (speaker module, VGA connector, etc.), related images/diagrams, etc. (10 points of the Submission category)
The more detailed the better – you all know how much I love a good finite state machine and Boolean logic, so those could be some good ideas if appropriate for your system. If not, some kind of high level block diagram showing how different parts of your program connect together and/or showing how what you have created might fit into a more complete system could be appropriate instead.



A summary of the steps to get the project to work in Vivado and on the Nexys board (5 points of the Submission category)



Description of inputs from and outputs to the Nexys board from the Vivado project (10 points of the Submission category)

Inputs: 
Clock: 
100MHZCLK - A 100 MHz clock coming from the board

USB HID: 
PS2_CLK - The board’s built-in clock for the USB-A port (which is also referred to as the PS/2 port in the board’s master constraints file)
PS2_DATA - The data input from the USB-A port



7-Segment Display: 
SEG[6:0] - An array containing the seven segments for any given anode of the built-in display
DP - Decimal point for the array (unused for our purposes)
AN[7:0] - The anodes corresponding to each of the eight digits of the display

VGA Connector: 
VGA_R[3:0] - The four bits of the red output for the VGA connector
VGA_G[3:0] - The four bits of the green output for the VGA connector
VGA_B[3:0] - The four bits of the blue output for the VGA connector
VGA_HS - The horizontal sync speed
VGA_VS - the vertical sync speed

USB-RS232 Interface: 
UART_TXD - The USB-RS232’s transmit pin

As part of this category, if using starter code of some kind (discussed below), you should add at least one input and at least one output appropriate to your project to demonstrate your understanding of modifying the ports of your various architectures and components in VHDL as well as the separate .xdc constraints file.
Images and/or videos of the project in action interspersed throughout to provide context (10 points of the Submission category)
“Modifications” (15 points of the Submission category)
If building on an existing lab or expansive starter code of some kind, describe your “modifications” – the changes made to that starter code to improve the code, create entirely new functionalities, etc. Unless you were starting from one of the labs, please share any starter code used as well, including crediting the creator(s) of any code used. It is perfectly ok to start with a lab or other code you find as a baseline, but you will be judged on your contributions on top of that pre-existing code!

For the VGA Module, we took the array of 5x7 characters from galaga_game.vhd alongside the baseline function of text_draw. We added any missing characters to the array, added a helper function that translates the ascii code into its requisite character, and modified text_draw by removing all unrelated processes and adding two additional ones (one for printing the plaintext and the other for printing the hash). 

If you truly created your code/project from scratch, summarize that process here in place of the above.
Conclude with a summary of the process itself – who was responsible for what components (preferably also shown by each person contributing to the github repository!), the timeline of work completed, any difficulties encountered and how they were solved, etc. (10 points of the Submission category)
Ryan Manley - SHA-256 Implementation
Theodore Rogalski - Keyboard Input
Mircea Florescu - VGA Output/text draw
And of course, the code itself separated into appropriate .vhd and .xdc files. (50 points of the Submission category; based on the code working, code complexity, quantity/quality of modifications, etc.)
You are not really expected to be github experts – as long as one of you can confidently create the repository and help others add to it, that should be sufficient. If no group members fall under this criteria, discuss with me as soon as possible.
This is a group assignment, and for the most part you are graded as a group. I reserve the right to modify single student grades for extenuating circumstances, such as a clear lack of participation from a group member. You are allowed to rely on the expertise of your group members in certain aspects of the project, but you should all have at least a cursory understanding of all aspects of your project.
One additional note: You MAY use genAI or similar tools to assist with formatting your github repo, to create starter code that you then further modify to meet your final project objectives, or to assist you for troubleshooting or similar tasks. You MUST cite any occurrences of you doing so. You MAY NOT use genAI to do your project for you, or to completely write your repo's content for you. GenAI does not know what you actually did for your project - only you do!

Generative AI Citations:
- The most important thing 



 
A description of the expected behavior of the project, attachments needed (speaker module, VGA connector, etc.), related images/diagrams, etc. (10 points of the Submission category)
The more detailed the better – you all know how much I love a good finite state machine and Boolean logic, so those could be some good ideas if appropriate for your system. If not, some kind of high level block diagram showing how different parts of your program connect together and/or showing how what you have created might fit into a more complete system could be appropriate instead.
A summary of the steps to get the project to work in Vivado and on the Nexys board (5 points of the Submission category)
Description of inputs from and outputs to the Nexys board from the Vivado project (10 points of the Submission category)
As part of this category, if using starter code of some kind (discussed below), you should add at least one input and at least one output appropriate to your project to demonstrate your understanding of modifying the ports of your various architectures and components in VHDL as well as the separate .xdc constraints file.
Images and/or videos of the project in action interspersed throughout to provide context (10 points of the Submission category)
“Modifications” (15 points of the Submission category)
If building on an existing lab or expansive starter code of some kind, describe your “modifications” – the changes made to that starter code to improve the code, create entirely new functionalities, etc. Unless you were starting from one of the labs, please share any starter code used as well, including crediting the creator(s) of any code used. It is perfectly ok to start with a lab or other code you find as a baseline, but you will be judged on your contributions on top of that pre-existing code!
If you truly created your code/project from scratch, summarize that process here in place of the above.
Conclude with a summary of the process itself – who was responsible for what components (preferably also shown by each person contributing to the github repository!), the timeline of work completed, any difficulties encountered and how they were solved, etc. (10 points of the Submission category)
And of course, the code itself separated into appropriate .vhd and .xdc files. (50 points of the Submission category; based on the code working, code complexity, quantity/quality of modifications, etc.)
You are not really expected to be github experts – as long as one of you can confidently create the repository and help others add to it, that should be sufficient. If no group members fall under this criteria, discuss with me as soon as possible.
This is a group assignment, and for the most part you are graded as a group. I reserve the right to modify single student grades for extenuating circumstances, such as a clear lack of participation from a group member. You are allowed to rely on the expertise of your group members in certain aspects of the project, but you should all have at least a cursory understanding of all aspects of your project.
One additional note: You MAY use genAI or similar tools to assist with formatting your github repo, to create starter code that you then further modify to meet your final project objectives, or to assist you for troubleshooting or similar tasks. You MUST cite any occurrences of you doing so. You MAY NOT use genAI to do your project for you, or to completely write your repo's content for you. GenAI does not know what you actually did for your project - only you do!
