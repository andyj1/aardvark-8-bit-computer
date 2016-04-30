//////////////////////////////////////////////////////////////////////////////////
// Created by: Team Aardvark
// Course: Cooper Union ECE151A Spring 2016
// Professor: Professor Marano
// Module Name: 
// Description: 
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ns

module memory(mem_data, instructions, pc, address);

input wire [7:0] pc;
input wire [7:0] address;

output reg [7:0] instructions;
output reg [7:0] mem_data;

parameter INSTRUCTIONS = "./test.bin";

reg [7:0] ram_reg [255:0]; //8 bit wide, 256 address deep register memory

initial 
	begin
		$readmemb(INSTRUCTIONS, mem_data);  
	end

assign data = mem_data[address];

//Instruction memory
always @ pc
	begin
		instructions = pc;
	end


//data memory
	//NOT FINISHED

endmodule