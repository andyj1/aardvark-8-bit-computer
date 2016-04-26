//////////////////////////////////////////////////////////////////////////////////
// Created by: Team Aardvark
// Course: Cooper Union ECE151A Spring 2016
// Professor: Professor Marano
// Module Name: 
// Description: 
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ns

module alu_ctrl(zero, result, type,data1, data2);

//-------------Input Ports-----------------------------
input [7:0] type;
input [7:0] data1;			//8 bits of data1
input [7:0] data2;			//8 bits of data2

//-------------Output Ports----------------------------
output [7:0] result; 	//8 bits of result
output zero; 			//Gives 1 for jumping

//-------------Input ports Data Type-------------------
wire [7:0] type;
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

always @ type begin
	result = 0;
	zero = 0;
	save_msb = 0;

	if (type == 8'b00000001) begin	//addition
		result = data1 + data2;
	end 
	if (type == 8'b11111111) begin	//equality check
		if(data1 == data2)
			zero = 1;
	end 
	
end


endmodule