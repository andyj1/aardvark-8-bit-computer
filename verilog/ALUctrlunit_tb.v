`timescale 1ns / 1ns
`include "ALUctrlunit.v"
module ALULctrlunit_tb ();

//-------------Input-------------------
reg [2:0] ALUop;
reg funct, t0, t1;
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
	t0 = 1'b1;
	t1 = 1'b1;
	
	$monitor("ALUop=%b, funct=%b,t0=%b,t1=%b,ALUctrlbits=%b", ALUop, funct,t0,t1,ALUctrlbits);
	
	$display($time, "<<finishing the simulation>>");
	
	#20 $finish;
end

ALUctrl aluctrl(ALUctrlbits, ALUop, funct, t0, t1);

endmodule
