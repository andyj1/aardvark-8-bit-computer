#### 8-bit Computer Architecture design
##### Team Name: Aardvark; Members: Andy Jeong, Gordon Macshane, Brenda So

##### Abstract
###### This project aims to construct an 8-bit computer architecture in a subset of MIPS.

#### Instructions
  To compile, run and show waveform using gtkwave simulator:
	make –f Makefile
	
#### Terminal:

##### To compile separately on terminal: 
	iverilog -o <objectname> main_tb.v

##### To run the compiled object file:
	vvp <objectname>
