//////////////////////////////////////////////////////////////////////////////////
// Created by: Team Aardvark
// Course: Cooper Union ECE151A Spring 2016
// Professor: Professor Marano
// Module Name: Addition.v
// Description: Adding 1 to PC to increment it
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ns

module Addition(pc_in, pc_out);

//-------------Input Ports-----------------------------
input wire [7:0] pc_in;			//8 bits of data1
input wire clk;
//-------------Output Ports----------------------------
output reg [7:0] pc_out; 	//8 bits of result

//------------------Instructions-----------------------

// 001: add
// 010: nand
// 011: comparison
// 100: shift left
// 101: shift right
// 110: equal

always @(pc_in)
begin
	pc_out = pc_in + 1;
end


endmodule
