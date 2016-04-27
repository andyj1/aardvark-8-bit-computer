//////////////////////////////////////////////////////////////////////////////////
// Created by: Team Aardvark
// Course: Cooper Union ECE151A Spring 2016
// Professor: Professor Marano
// Module Name: 
// Description: 
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ns

module ALUctrl(zero, result, ALUctrlbits, data1, data2);

//-------------Input Ports-----------------------------
input [2:0] ALUctrlbits;	//control bit from ALU control unit
input [7:0] data1;			//8 bits of data1
input [7:0] data2;			//8 bits of data2

//-------------Output Ports----------------------------
output [7:0] result; 	//8 bits of result
output zero; 			//Gives 1 for jumping

//-------------Input ports Data Type-------------------
wire [2:0] ALUctrlbits;	//3 bits of ALU opcode
wire [7:0] data1;	//8 bits of data
wire [7:0] data2;	//8 bits of data

//-------------Output Ports Data Type------------------
reg [7:0] result;
reg zero;

//-------------Output Ports Data Type------------------
reg [7:0]save_msb;

//------------------Instructions-----------------------

// 001: add
// 010: nand
// 011: comparison
// 100: shift left
// 101: shift right
// 110: equal

initial begin
	result = 0;
	zero = 0;
	save_msb = 0;
end

always @ ALUctrlbits begin
	if (ALUctrlbits == 3'b001) begin		//addition
		result = data1 + data2;
	end 
	if (ALUctrlbits == 3'b010) begin	//nand
		result = ~(data1 & data2);
	end 
	if (ALUctrlbits == 3'b011) begin	//comparison
		if (data1 > data2) begin
			result = 0;
		end 
		if (data1 < data2) begin
			result = 1;
		end
	end 
	if (ALUctrlbits == 3'b100) begin	//shift left
		result = data1 << 1;
	end 
	if (ALUctrlbits == 3'b101) begin	//shift right
		//keep the sign
		if (data1 >= 8'b10000000) begin
			save_msb = 8'b10000000;
		end if (data1 < 8'b00000000) begin
			save_msb = 8'b00000000;
		end
		result = save_bit + (data1 >> 1);
		
	end 
	if (ALUctrlbits == 3'b110) begin	//equal
		if (data1 == data2) begin
			zero = 1;
		end
	end 
end


endmodule