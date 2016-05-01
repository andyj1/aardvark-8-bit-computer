#### 8-bit Computer Architecture design
##### Team Name: Aardvark; Members: Andy Jeong, Gordon Macshane, Brenda So

##### Abstract
###### This project aims to construct a circuit on Verilog Hardware Description Language whereby the paper processor (https://sites.google.com/site/kotukotuzimiti/Paper_Processor) is implemented. The Verilog code takes in the modules (.v) – checking, dff_reset_negedge, dff_reset_posedge, halt, increment, jno, programcounter, fulladder, memory – which take the inputs and outputs the data bits according to the primitive logic gates event-driven cases (always block) and time delays (#). The instruction.bin file takes in the instruction codes, which are picked out based on the logic, and determines the data output.

#### Instructions
  To compile, run and show waveform using gtkwave simulator:
	make –f Makefile
	
#### Terminal:

##### To compile separately on terminal: 
	iverilog -o <objectname> main_tb.v

##### To run the compiled object file:
	vvp <objectname>
