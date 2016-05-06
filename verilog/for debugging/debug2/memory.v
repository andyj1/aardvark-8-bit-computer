//////////////////////////////////////////////////////////////////////////////////
// Created by: Team Aardvark
// Course: Cooper Union ECE151A Spring 2016
// Professor: Professor Marano
// Module Name: 
// Description: 
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ns

module memory(instructions, readData, pc, memWrite, memRead, input_addr, dataMemWrite);

//fetch
input wire [7:0] pc;

output wire [7:0] instructions;

//store
input wire memWrite, memRead;
input wire [7:0] input_addr;	//address of memory where dataMemWrite will be written onto
input wire [7:0] dataMemWrite;	//data to be written onto memory
output reg [7:0] readData;		//data of the memory at the specified address

reg [7:0] MDR [255:0];		//8 bit wide, 256 address deep register memory

parameter INSTRUCTIONS = "test.bin";

initial 
	begin
		$readmemb(INSTRUCTIONS, MDR);  
		
		readData = 8'b0;
	end
//fetch
	assign instructions  = MDR[pc];

//store
always @ (memRead)
	begin
		readData = MDR[input_addr]; //load word at the specified address
	end
always @ (memWrite)
	begin
		MDR[input_addr] = dataMemWrite;
	end

endmodule