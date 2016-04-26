//////////////////////////////////////////////////////////////////////////////////
// Created by: Team Aardvark
// Course: Cooper Union ECE151A Spring 2016
// Professor: Professor Marano
// Module Name: 
// Description: 
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ns
//NOT FINISHED YET

module ctrl(jctrl, jrctrl, memWrite, memRead, memToReg, ALUop, ALUsrc, regWrite, brctrl, ractrl, instr);

//-------------Input Ports-----------------------------

input [3:0] instr;		

//-------------Output Ports----------------------------

output jctrl;
output jrctrl;
output memWrite;
output memRead;
output memToReg;
output [2:0]ALUop;
output ALUsrc;
output regWrite;
output brctrl;
output ractrl;

//-------------Input ports Data Type-------------------
// By rule all the input ports should be wires
wire [3:0] instr;		

//-------------Output Ports Data Type------------------
// Output port can be a storage element (reg) or a wire
reg jctrl;
reg jrctrl;
reg memWrite;
reg memRead;
reg memToReg;
reg [2:0]ALUop;
reg ALUsrc;
reg regWrite;
reg brctrl;
reg ractrl;

//------------------Instructions-----------------------
always @ instr
begin
	jctrl = 0;
	jrctrl = 0;
	memWrite = 0;
	memRead = 0;
	memToReg = 0;
	ALUop = 3'b000;
	ALUsrc = 0;
	regWrite = 0;
	brctrl = 0;
	ractrl = 0;


	//*****add conditions for brctrl and ractrl
	if(inst[3] == 0) begin
		regWrite = 1;
		if (instr == 4'b0000) begin	//add
				ALUop = 3'b000;
		end if (instr == 4'b0010) begin	//nand
				ALUop = 3'b001;
		end if (instr == 4'b0100) begin	//slt_0
				ALUop = 3'b010;
		end if (instr ==4'b0101) begin	//slt_1
				ALUop = 3'b010;
		end if (instr == 4'b0110) begin	//sl
				ALUop = 3'b011;
		end if (instr == 4'b0111) begin	//sr
				ALUop = 3'b100;
		end if (instr == 4'b1000) begin	//lw
				memRead = 1;
				memToReg = 1;
		end if (instr == 4'b1001) begin //sw
				memWrite = 1;
		end if (instr == 4'b1010) begin	//addi (didn't add to excel sheet)
				ALUop = 3'b101;
		end if (instr == 4'b1011) begin	//jr
				jrctlr = 1;
		end if (instr == 4'b1100) begin	//beq	
				ALUop = 3'b101;
			jctrl = 1;
		end if (instr == 4'b1110) begin //jal
				jctrl = 1;	
		end
	end
end
	
endmodule