//////////////////////////////////////////////////////////////////////////////////
// Created by: Team Aardvark
// Course: Cooper Union ECE151A Spring 2016
// Professor: Professor Marano
// Module Name: 
// Description: 
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ns

module mux2_1(output1, input1, input2, ctrl);

//-------------Input Ports-----------------------------
input ctrl;		//1 bit to control the mux
input [7:0] input1;	//input 1
input [7:0] input2;	//8 bits of data

//-------------Output Ports----------------------------

output [7:0] output1; 	//8 bits of outputput

//-------------Input ports Data Type-------------------
wire ctrl;	
wire [7:0]input1;	
wire [7:0]input2;	

//-------------Output Ports Data Type------------------
reg [7:0]output;

//------------------Instructions-----------------------
initial 
	output1 = 1;

always @ output1
begin
	if (ctrl == 0)
		output = input1;
	if (ctrl == 1) begin
		output = input2;
end
endmodule