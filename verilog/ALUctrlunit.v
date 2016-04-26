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

//-------------Input ports Data Type-------------------
wire [2:0] ALUop;
wire funct;
wire t0;	
wire t1;

//-------------Output Ports Data Type------------------
reg [2:0] ALUctrlbits;

//------------------Instructions-----------------------
always begin
	ALUctrlbit = 0;
	//FILL IN THIS SECTION
	//TODO: {ALUop and funct} --> ALUctrlbits
	if (ALUop == 000) && (funct == 1) begin
		//add
		ALUctrlbits = 001;
	end if (ALUop == 001) && (funct == 1) begin
		//nand
		ALUctrlbits = 010;
	end if (ALUop == 010) && (funct == 0) begin
		//slt_0
		ALUctrlbits = 011;
	end if (ALUop == 010) && (funct == 1) begin
		//slt_1
		ALUctrlbits = 011;
	end if (ALUop == 011) && (funct == 0) begin
		//sl
		ALUctrlbits = 100;
	end if (ALUop == 011) && (funct == 1) begin
		//sr
		ALUctrlbits = 101;
	end if (ALUop == 101) && (funct == 0) begin
		//addi 
		ALUctrlbits = 001; //same as add
	end if (ALUop == 110) begin
		//beq
		ALUctrlbits = 110;
	end 

end

endmodule
