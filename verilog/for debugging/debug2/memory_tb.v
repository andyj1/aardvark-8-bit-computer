//////////////////////////////////////////////////////////////////////////////////
// Created by: Team Aardvark
// Course: Cooper Union ECE151A Spring 2016
// Professor: Professor Marano
// Module Name: 
// Description: 
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns/1ns
`include "memory.v"

module memory_tb();

//fetch
reg [7:0] pc;
wire [7:0] instructions;
//store
reg memWrite, memRead;
reg [7:0] input_addr;	//address of memory where dataMemWrite will be written onto
reg [7:0] dataMemWrite;	//data to be written onto memory
wire [7:0] readData;		//data of the memory at the specified address

reg [7:0] MDR [255:0];		//8 bit wide, 256 address deep register memory
reg clk;

always 
	#1 clk = ~clk;
initial
	begin
		clk = 1'b0;	
		pc = 8'b00000000;
		input_addr = 8'b0000001;
		memWrite = 0;
		memRead = 0;
		dataMemWrite = 0;
		$display("instructions: %b\n pc : %b\n memWrite: %b\n memRead: %b\n dataMemWrite: %b\n readData: %b\n", instructions, pc, memWrite, memRead, dataMemWrite, readData);
		#100 $finish;
	end

//always @(posedge clk)
//	pc = pc + 1;


	memory mem(instructions, readData, pc, memWrite, memRead, input_addr, dataMemWrite);
endmodule
