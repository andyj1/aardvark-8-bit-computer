//////////////////////////////////////////////////////////////////////////////////
// Created by: Team Aardvark
// Course: Cooper Union ECE151A Spring 2016
// Professor: Professor Marano
// Module Name: 
// Description: 
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ns

module ctrl(jctrl, jrctrl, memWrite, memRead, memToReg, ALUop, ALUsrc, regWrite, beqctrl, ractrl, jalctrl, jctrlctrl, inst1, inst2);

//-------------Input Ports-----------------------------
input wire jctrlctrl;
input wire [2:0] inst1;
input wire inst2;

//-------------Output Ports----------------------------

output reg jctrl;
output reg jrctrl;
output reg memWrite;
output reg memRead;
output reg [1:0] memToReg;
output reg [2:0]ALUop;
output reg ALUsrc;
output reg regWrite;
output reg beqctrl;
output reg ractrl;
output reg jalctrl;

reg [3:0] instructions;

//------------------Instructions-----------------------
initial
	begin
		jctrl = 0;
		jrctrl = 0;
		memWrite = 0;
		memRead = 0;
		memToReg = 2'b00;
		ALUop = 3'b000;
		ALUsrc = 0;
		regWrite = 0;
		beqctrl = 0;
		ractrl = 0;
		jalctrl = 0;
		instructions = {inst1,inst2};
	end
always @(inst1||inst2)
begin
	instructions = {inst1,inst2};
	if(jctrlctrl) 
		begin	//beq	
			ALUop = 3'b101;
			jctrl = 1;
		end
	
	case(instructions)

	4'b0001: begin	//add
			ALUop = 3'b000;
			regWrite = 1;
	end 
	4'b0011: begin	//nand
				ALUop = 3'b001;
				regWrite = 1;
			end
	4'b0100: begin	//slt_0
				ALUop = 3'b010;
				regWrite = 1;
			end
	4'b0101: begin	//slt_1
				ALUop = 3'b010;
				regWrite = 1;
			end
	4'b0110: begin	//sl
				ALUop = 3'b011;
				regWrite = 1;
			end
	4'b0111: begin	//sr
				ALUop = 3'b100;
				regWrite = 1;
			end
	4'b1000: begin	//lw
				ALUop = 111;
				memRead = 1;
				memToReg = 2'b01;
				regWrite = 1;
				ALUsrc = 1;
			end
	4'b1001: begin //sw
				ALUop = 111;
				memWrite = 1;
				ALUsrc = 1;
			end
	4'b1010: begin	//addi 
				ALUop = 3'b100;
				regWrite = 1;
				ALUsrc = 1;
			end
	4'b1011: begin	//jr
				jrctrl = 1;
				ractrl = 1;	//controls mux
			end
	4'b1100: begin	//beq	
				ALUop = 3'b101;
				jctrl = 1;
				beqctrl = 1;
				jalctrl = 1;
			end
	4'b1110: begin //jal
				jctrl = 1;
				memToReg = 2'b10;
				jalctrl = 1;
			end
	default: begin
				jctrl = 0;
				jrctrl = 0;
				memWrite = 0;
				memRead = 0;
				memToReg = 2'b00;
				ALUop = 3'b000;
				ALUsrc = 0;
				regWrite = 0;
				beqctrl = 0;
				ractrl = 0;
			end
	endcase
			
end
	
endmodule