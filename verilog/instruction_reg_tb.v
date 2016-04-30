`timescale 1ns / 1ns
`include "instruction_reg.v"
module instruction_reg_tb ();

//-------------Input-------------------
reg [7:0] instruction_input;
reg clk;
//-------------Output------------------
wire [4:0] j_immediate;
wire [1:0] jump_opcode_check;
wire funct;
wire [2:0] instruction_to_control_unit;
wire [1:0] rt;
wire [1:0] rs;
wire [1:0] i_immediate;

//------------------Instructions-----------------------
always 
	#2 clk = ~clk;
initial
begin
	clk = 1'b0;	
	$display($time, "<<starting the simultaion>>");
	
	instruction_input = 8'b00010000;
	

	$monitor("j_immediate=%b\t, jump_opcode_check=%b\t,funct=%b\t,instruction_to_control_unit=%b\t,rt=%b\t,rs=%b\t,i_immediate=%b\n", j_immediate,jump_opcode_check,funct,instruction_to_control_unit,rt,rs,i_immediate);
	
	$display($time, "<<finishing the simulation>>");
	
	#20 $finish;
end

instruction_reg instreg(j_immediate,jump_opcode_check, instruction_to_control_unit, rt, rs, i_immediate, funct, instruction_input);

endmodule
