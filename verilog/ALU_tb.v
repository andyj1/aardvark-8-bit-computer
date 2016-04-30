`timescale 1ns / 1ns
`include "ALU.v"
module ALU_tb ();

//-------------Input-------------------
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
	
	data1 = 8'b00000001;
	data2 = 8'b11111110;	

	$monitor("data1=%b,data2=%b,result=%b,zero=%b", data1,data2,result,zero);
	
	$display($time, "<<finishing the simulation>>");
	
	#20 $finish;
end
ALU alu(zero, result, data1, data2);

endmodule
