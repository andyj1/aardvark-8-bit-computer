//////////////////////////////////////////////////////////////////////////////////
// Created by: Team Aardvark
// Course: Cooper Union ECE151A Spring 2016
// Professor: Professor Marano
// Module Name: 
// Description: 
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ns

module signext_2to8 (dataout,datain);

//-------------Input Ports-----------------------------
input [1:0] datain;	//input 

//-------------Output Ports----------------------------
output [7:0] dataout; 	//8 bits of output

//-------------Input ports Data Type-------------------
// By rule all the input ports should be wires
wire [1:0]datain;

//-------------Output Ports Data Type------------------
// Output port can be a storage element (reg) or a wire
reg [7:0] dataout;

//-------------Intermediate Ports Data Type-------------
reg [6:0] sign;

//------------------Instructions-----------------------
always @ datain
begin
	if (datain >= 2'b10) begin
		sign = 6'b111111;
	end if (datain < 2'b10) begin
		sign = 6'b000000;
	end
	dataout = {sign,datain};
end
endmodule