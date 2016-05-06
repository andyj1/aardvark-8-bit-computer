//////////////////////////////////////////////////////////////////////////////////
// Created by: Team Aardvark
// Course: Cooper Union ECE151A Spring 2016
// Professor: Professor Marano
// Module Name: 
// Description: 
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ns
`include "ALUctrl.v"
module ALUctrl_tb ();

//-------------Input-------------------
reg [2:0] ALUctrlbits;	//control bits from ALU control unit
reg [7:0] data1;			//8 bits of data1
reg [7:0] data2;			//8 bits of data2

reg clk;
//-------------Output------------------
wire [7:0] result;
wire zero;

//------------------Instructions-----------------------
always 
	#2 clk = ~clk;
initial
	begin
		clk = 1'b0;	
		$display($time, "<<starting the simultaion>>");
		
		ALUctrlbits = 3'b101;
		data1 = 8'b01000001;
		data2 = 8'b10111111;	

		$monitor("ALUctrlbits=%b, data1=%b,data2=%b,result=%b,zero=%b", ALUctrlbits,data1,data2,result,zero);
		
		$display($time, "<<finishing the simulation>>");
		
		#20 $finish;
	end
	
ALUctrl aluctrl(zero, result, ALUctrlbits, data1, data2);

endmodule
