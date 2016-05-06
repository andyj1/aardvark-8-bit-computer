//////////////////////////////////////////////////////////////////////////////////
// Created by: Team Aardvark
// Course: Cooper Union ECE151A Spring 2016
// Professor: Professor Marano
// Module Name: Addition.v
// Description: Compare between 11111111 and jOpCode to make sure its jump
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ns

module Compare(j_in, zero);

//-------------Input Ports-----------------------------
input wire [7:0] j_in;
//-------------Output Ports----------------------------
output reg zero; 	

//------------------Instructions-----------------------

always @(j_in)
begin
	if (j_in == 8'b11111111) begin
		zero = 0;
	end else begin
		zero = 1;
	end
end


endmodule
