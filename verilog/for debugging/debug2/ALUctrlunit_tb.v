//////////////////////////////////////////////////////////////////////////////////
// Created by: Team Aardvark
// Course: Cooper Union ECE151A Spring 2016
// Professor: Professor Marano
// Module Name: 
// Description: 
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ns
`include "ALUctrlunit.v"
module ALULctrlunit_tb ();

//-------------Input-------------------
reg [2:0] ALUop;
reg funct;
reg clk;
//-------------Output------------------
wire [2:0] ALUctrlbits;

//------------------Instructions-----------------------
always 
	#2 clk = ~clk;
initial
begin
	clk = 1'b0;	
	$display($time, "<<starting the simultaion>>");
	
	ALUop = 3'b110;
	funct = 1'b1;
	
	$monitor("ALUop=%b, funct=%b,ALUctrlbits=%b", ALUop, funct,ALUctrlbits);
	
	$display($time, "<<finishing the simulation>>");
	
	#20 $finish;
end

ALUctrlunit aluctrlunit(ALUctrlbits, ALUop, funct);

endmodule
