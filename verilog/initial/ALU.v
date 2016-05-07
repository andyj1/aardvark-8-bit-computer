//////////////////////////////////////////////////////////////////////////////////
// Created by: Team Aardvark
// Course: Cooper Union ECE151A Spring 2016
// Professor: Professor Marano
// Module Name: 
// Description: 
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ns

module ALU (zero, result, data1, data2);

//-------------Input Ports-----------------------------
input wire [7:0] data1;			//8 bits of data1
input wire [7:0] data2;			//8 bits of data2

//-------------Output Ports----------------------------
output reg [7:0] result; 	//8 bits of result
output reg zero ; 			//Gives 1 for jumping

//------------------Instructions-----------------------

// 001: add
// 010: nand
// 011: comparison
// 100: shift left
// 101: shift right
// 110: equal

always @ data2 begin
	result = 0;
	zero = 0;

	if (data1 == 8'b00000001) begin	//addition
		result = data1 + data2;
	end 
	if (data1 == 8'b11111111) begin	//equality check
		if(data1 == data2)
			zero = 1;
	end 
	
end


endmodule