
//////////////////////////////////////////////////////////////////////////////////
// Created by: Team Aardvark
// Course: Cooper Union ECE151A Spring 2016
// Professor: Professor Marano
// Module Name: 
// Description: 
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ns

module pc(clk , input1, output1, reset);

//-------------Input Ports-----------------------------
input reset;
input [7:0] input1;
input clk;

wire reset;
wire input1;
wire clk;
//-------------Output Ports----------------------------
output [7:0] output1; 	//8 bits of output
reg [7:0] output1;

//------------------Instructions-----------------------

initial begin
	output1 <= 8'b00000000;
end

always @(posedge clk) begin
	if (reset == 1) begin
		#1 output1 = 8'b00000000;
	end
	else begin
		#1 output1 <= input1;
	end
end

always @(reset) begin
	output1 = 8'b00000000;
end
endmodule
