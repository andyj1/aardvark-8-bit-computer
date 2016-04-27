//////////////////////////////////////////////////////////////////////////////////
// Created by: Team Aardvark
// Course: Cooper Union ECE151A Spring 2016
// Professor: Professor Marano
// Module Name: 
// Description: 
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ns

module signext_5to8 (dataout,datain);

//-------------Input Ports-----------------------------
input [4:0] datain;	//input 

//-------------Output Ports----------------------------
output [7:0] dataout; 	//8 bits of output

//-------------Input ports Data Type-------------------
// By rule all the input ports should be wires
wire [4:0]datain;

//-------------Output Ports Data Type------------------
// Output port can be a storage element (reg) or a wire
reg [7:0] dataout;

//-------------Intermediate Ports Data Type-------------
reg [3:0] sign;

//------------------Instructions-----------------------
always @ datain
begin
	if (datain >= 5'b10000) begin
		sign = 3'b111;
	end if (datain < 5'b10000) begin
		sign = 3'b000;
	end
	dataout = {sign,datain};
end
endmodule
