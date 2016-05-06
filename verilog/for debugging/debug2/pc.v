//////////////////////////////////////////////////////////////////////////////////
// Created by: Team Aardvark
// Course: Cooper Union ECE151A Spring 2016
// Professor: Professor Marano
// Module Name: 
// Description: 
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ns

module pc(clk , input1, output1 , reset);

//-------------Input Ports-----------------------------
input wire reset;
input [7:0] input1;
input clk;
//-------------Output Ports----------------------------
output reg [7:0] output1; 	//8 bits of output

//------------------Instructions-----------------------

always @(posedge clk) 
	begin
		if(!reset)
			output1 = input1;
		else	
			output1 = 8'b00000000;
	end
endmodule

