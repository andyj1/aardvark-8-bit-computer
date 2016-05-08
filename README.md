#### Aardvark 8-bit Computer Processor 
##### Team Name: Aardvark; 
##### Members: Andy Jeong, Gordon Macshane, Brenda So

#### Abstract
###### This project aims to construct an 8-bit computer architecture in a subset of MIPS. With a subset of MIPS ISA, an 8-bit processor was designed  using Verilog language. Each instruction is set to 1-byte, or 8-bit, length, and the main memory is word addressable while the instruction memory is byte addressable. There are 4 addressable registers: \$s1 (00), \$s2 (01), \$sp (10) and \$ra (11). Two other registers in the register file, \$slt\_0 and \$slt\_1, cannot be addressed directly, but may be well utilized for jumping (beq instruction). All registers are initialized at 0, while the \$sp pointer is initialized at 0xFF (255 in decimal), which is the top of the memory stack. 

#### Instructions
  To compile, run and show waveform using gtkwave simulator:
	make –f Makefile
	
#### Terminal:
##### To compile and run separately on terminal: 
	git clone https://github.com/brendabrandy/aardvark-8-bit-computer
	cd verilog/final
	iverilog -o <objectname> main_tb.v
	vvp <objectname>

	
