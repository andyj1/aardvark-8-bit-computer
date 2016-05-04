//////////////////////////////////////////////////////////////////////////////////
// Created by: Team Aardvark
// Course: Cooper Union ECE151A Spring 2016
// Professor: Professor Marano
// Module Name: 
// Description: 
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ns

module mux2_1(output1, input1);

//-------------Input Ports-----------------------------
input wire [7:0] input1;

//-------------Output Ports----------------------------

output reg [7:0] output1; 	//8 bits of output

//------------------Instructions-----------------------
initial begin
	output1 = 0;
end

always @(input1)
	output1 = input1;

endmodule