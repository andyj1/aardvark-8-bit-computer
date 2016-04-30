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
reg [7:0] pc;
reg [7:0] address;

wire [7:0] instructions;
wire [7:0] mem_data;

reg clk;

initial 
	clk = 0;
	begin
		pc = 8'b0;
		address = 8'b0;
		$monitor("pc: %b, address: %b, instruction: %b", pc, address, instructions);
		#100 $finish;
	end

always 
	begin
		#1 clk = ~clk;
	end

always @(posedge clk) 
	begin
		address = address + 1;
	end

	memory mem(mem_data, instructions, pc, address);
endmodule
