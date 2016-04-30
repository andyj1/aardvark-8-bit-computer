//////////////////////////////////////////////////////////////////////////////////
// Created by: Team Aardvark
// Course: Cooper Union ECE151A Spring 2016
// Professor: Professor Marano
// Module Name: 
// Description: 
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ns
`include "register_file.v"

module register_file_tb ();

reg regWrite;
reg beqctrl;
reg jrctrl;
reg [3:0] rt_addr;
reg [3:0] rs_addr;
reg [7:0] dataToWrite;
wire jctrlctrl;
wire [7:0] rt_data;
wire [7:0] rs_data;
wire [7:0] ra_addr;
wire slt0_reg, slt1_reg;

reg [7:0] data_reg [3:0]; 	//3:$ra, 2:$sp, 1: $s1, 0: $s0 
reg [3:0] address [1:0];
reg clk;
//------------------Instructions-----------------------
always 
	#1 clk = ~clk;

initial 
	begin
		clk = 1'b0;	
		$display($time, "<<starting the simultaion>>");
		
		$monitor("regWrite: %b, beqctrl: %b, jrctrl: %b, rt_addr: %b, rs_addr: %b, dataToWrite: %b", regWrite, beqctrl, jrctrl, rt_addr, rs_addr, dataToWrite);
		
		$display($time, "<<finishing the simulation>>");
		
		#20 $finish;
	end

register_file rf(jctrlctrl, rt_data, rs_data, ra_addr, slt0_reg, slt1_reg, regWrite, beqctrl, jrctrl, rt_addr, rs_addr, dataToWrite);

endmodule
