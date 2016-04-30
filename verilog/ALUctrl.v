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
input wire [2:0] ALUctrlbits;	//control bit from ALU control unit
input wire [7:0] data1;			//8 bits of data1
input wire [7:0] data2;			//8 bits of data2

//-------------Output Ports----------------------------
output reg [7:0] result; 	//8 bits of result
output reg zero; 			//Gives 1 for jumping

reg [7:0] save_msb;

//------------------Instructions-----------------------

// 001: add/addi
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
	if (ALUctrlbits == 3'b001) begin	//add
		result = data1 + data2;
	end 
	if (ALUctrlbits == 3'b010) begin	//nand
		result = ~(data1 & data2);
	end 
	if (ALUctrlbits == 3'b011) begin	//comparison
		if (data1 > data2) begin
			zero = 0;
		end 
		if (data1 < data2) begin
			zero = 1;
		end
	end 
	if (ALUctrlbits == 3'b100) begin	//shift left
		result = data1 << 1;
	end 
	if (ALUctrlbits == 3'b101) begin	//shift right
		if (data1 >= 8'b10000000) begin
			save_msb = 8'b10000000;
		end if (data1 < 8'b10000000) begin
			save_msb = 8'b00000000;
		end
		result = save_msb + (data1 >> 1);
	end 
	if (ALUctrlbits == 3'b110) begin	//equality check
		if (data1 == data2) begin
			zero = 1;
		end
	end 
end


endmodule