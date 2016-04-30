//////////////////////////////////////////////////////////////////////////////////
// Created by: Team Aardvark
// Course: Cooper Union ECE151A Spring 2016
// Professor: Professor Marano
// Module Name: 
// Description: 
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ns

module ALUctrl(ALUctrlbits, ALUop, funct, t0, t1);

//-------------Input-------------------
input [2:0] ALUop;
input funct;
input t0;	//slt_0 register from register file
input t1;	//slt_1 register from register file
//-------------Output------------------
output [2:0] ALUctrlbits;

wire [2:0] ALUop;
wire funct, t0, t1;
reg [2:0] ALUctrlbits;

//------------------Instructions-----------------------
initial
	ALUctrlbits = 3'b000;

always @(~ALUop || ~funct) begin
	if ((ALUop == 3'b000) && (funct == 1)) begin
		//add
		ALUctrlbits = 3'b001;
	end if ((ALUop == 3'b001) && (funct == 1)) begin
		//nand
		ALUctrlbits = 3'b010;
	end if ((ALUop == 3'b010) && (funct == 0)) begin
		//slt_0
		ALUctrlbits = 3'b011;
	end if ((ALUop == 3'b010) && (funct == 1)) begin
		//slt_1
		ALUctrlbits = 3'b011;
	end if ((ALUop == 3'b011) && (funct == 0)) begin
		//sl
		ALUctrlbits = 3'b100;
	end if ((ALUop == 3'b011) && (funct == 1)) begin
		//sr
		ALUctrlbits = 3'b101;
	end if ((ALUop == 3'b101) && (funct == 0)) begin
		//addi 
		ALUctrlbits = 3'b001; //same as add
	end if (ALUop == 3'b110) begin
		//beq
		ALUctrlbits = 3'b110;
	end 

end

endmodule
