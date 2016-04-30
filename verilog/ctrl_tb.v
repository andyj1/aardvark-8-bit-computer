//////////////////////////////////////////////////////////////////////////////////
// Created by: Team Aardvark
// Course: Cooper Union ECE151A Spring 2016
// Professor: Professor Marano
// Module Name: 
// Description: 
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ns
`include "ctrl.v"
module ctrl_tb ();

//-------------Input-------------------
reg jctrlctrl;
reg [3:0] instructions;
reg clk;

//-------------Output------------------
wire jctrl;
wire jrctrl;
wire memWrite;
wire memRead;
wire [1:0] memToReg;
wire [2:0] ALUop;
wire ALUsrc;
wire regWrite;
wire beqctrl;
wire ractrl;
wire jalctrl;

//------------------Instructions-----------------------
always
	#1 clk = ~clk;

initial 
	begin		
		$display($time, "<<starting the simultaion>>");
		instructions = 4'b0011;
		jctrlctrl = 0;
		
		$monitor("jctrl=%b,jrctrl=%b,memWrite=%b,memRead=%b,memToReg=%b,ALUop=%b,ALUsrc=%b,regWrite=%b,beqctrl=%b,ractrl=%b",jctrl, jrctrl,memWrite,memRead,memToReg,ALUop,ALUsrc,regWrite,beqctrl,ractrl);
				
		#100 $finish;
		$display($time, "<<finishing the simulation>>");
	end

ctrl ctrl0(jctrl, jrctrl, memWrite, memRead, memToReg, ALUop, ALUsrc, regWrite, beqctrl, ractrl, jalctrl, jctrlctrl, instructions);

endmodule
