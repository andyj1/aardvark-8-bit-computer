//////////////////////////////////////////////////////////////////////////////////
// Created by: Team Aardvark
// Course: Cooper Union ECE151A Spring 2016
// Professor: Professor Marano
// Module Name: 
// Description: 
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ns

module pc_tb();

//-------------Input Ports-----------------------------
reg [7:0] input1;
reg reset;
reg clk;
//-------------Output Ports----------------------------

wire [7:0] output1; 	//8 bits of output

//------------------Instructions-----------------------
always
	#1 clk = ~clk;
initial begin
	clk = 1;
	reset = 0;
	input1 = 8'b00000001;
	$monitor("%b", output1);

	#10 $finish;
end

pc pc(clk, input1,output1,reset);
endmodule