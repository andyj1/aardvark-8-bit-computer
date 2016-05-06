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
reg ALUsrc;		//I type control for immediate
reg [1:0] rt_addr;
reg [1:0] rs_addr;
reg [7:0] dataToWrite;
reg slt_reg;
reg [1:0] rs_write_addr;

wire jctrlctrl;
wire [7:0] rt_data;
wire [7:0] rs_data;

reg [7:0] data_reg [3:0]; 	//3:$ra, 2:$sp, 1: $s1, 0: $s0 
reg [1:0] address_reg [3:0];
reg clk;
//------------------Instructions-----------------------
always 
	#1 clk = ~clk;

initial 
	begin
		rt_addr = 2'b00;
		rs_addr = 2'b01;
		clk = 1'b0;	
		regWrite = 0;
		beqctrl = 0;
		jrctrl = 0;
		ALUsrc= 0;
		dataToWrite = 8'b00101010;
		slt_reg = 1;
		rs_write_addr = 2'b01;
		$display($time, "<<starting the simultaion>>");
		
		$monitor("regWrite: %b, beqctrl: %b, jrctrl: %b, ALUsrc: %b, rt_addr: %b, rs_addr: %b, dataToWrite: %b, slt_reg: %b, rs_write_addr: %b, jctrlctrl: %b, rt_data: %b, rs_data: %b", regWrite, beqctrl, jrctrl, ALUsrc, rt_addr, rs_addr, dataToWrite, slt_reg, rs_write_addr, jctrlctrl, rt_data, rs_data);
		
		$display($time, "<<finishing the simulation>>");
		
		#20 $finish;
	end

register_file rf(jctrlctrl, rt_data, rs_data, regWrite, beqctrl, jrctrl, ALUsrc, rt_addr, rs_addr, dataToWrite, slt_reg, rs_write_addr);

endmodule
