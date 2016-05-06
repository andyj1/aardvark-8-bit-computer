//////////////////////////////////////////////////////////////////////////////////
// Created by: Team Aardvark
// Course: Cooper Union ECE151A Spring 2016
// Professor: Professor Marano
// Module Name: 
// Description: 
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ns
`include "register_file.v"
`include "instruction_reg.v"
`include "ctrl.v"
`include "memory.v"
`include "ALU.v"
`include "ALUctrl.v"
`include "ALUctrlunit.v"
`include "signext_5to8.v"
`include "signext_2to8.v"
`include "pc.v"
`include "mux2_1_ctrl1_out1.v"
`include "mux2_1_ctrl1_in2.v"
`include "mux2_1_ctrl1.v"
`include "mux3_1.v"
module main_tb ();

	wire [4:0] j_immediate_5;
	wire [1:0] jump_opcode_check_2;
	wire funct;
	wire [2:0] instruction_to_control_unit_3;
	wire [1:0] rt_2;
	wire [1:0] rs_2;
	wire [1:0] i_immediate_2;
	reg [7:0] pc_addr_in;
	wire [7:0] pc_addr_out;
	//reg [7:0] pc_addr_out;
	wire [7:0] j_immediate_8;
	wire [7:0] jump_opcode_check_8;
	wire [7:0] result_X;
	wire alu1_zero;
	reg [7:0] jump_opcode_check_alu_input;
	reg zero;
	wire funct_input_ctrl_unit;
	reg jctrlctrl2;
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
	reg [1:0] ra_address;
	wire [1:0] rs_write_addr;
	reg [1:0] rt_addr;
	reg [1:0] rs_addr;
	wire jctrlctrl;
	wire [7:0] rt_data;
	wire [7:0] rs_data;
	reg [7:0] data_reg [3:0]; 
	reg [1:0] address_reg [3:0];
	wire [7:0] rt_2_8;
	wire [7:0] alu_ctrl_in_8;
	wire [2:0] ALUctrlbits;
	wire jumpflag;
	wire [7:0] alu_ctrl_result;
	wire slt_reg;
	wire zero_X;
	wire [7:0] pc_next_8;
	reg [7:0] ones_8;
	wire [7:0] pc_next_next_8;
	wire zero_XX;
	wire[7:0] alu3_result_8;
	wire [7:0] pc_next_next_next_8;
	wire jumpflag_or_output;
	wire [7:0] next_next_pc_8;
 	wire [7:0] final_next_pc;
	wire zero_XXX;
	wire [7:0] pc_plus_two;
	wire [7:0] readData;	
	wire [7:0] dataToWrite;
	reg [7:0] MDR [255:0];		
	wire [7:0] instructions;
	reg [7:0] initialreg;
	reg clk;
	reg reset;

	parameter INSTRUCTIONS = "./test.bin";
//------------------Instructions-----------------------

assign final_next_pc = 8'b0;
always 
	#1 clk = ~clk;
initial 
	
	begin

		clk = 1'b1;	
		reset = 0;
		zero = 0;
		ones_8 = 8'b00000001;
		jump_opcode_check_alu_input = 8'b11111111;
		ra_address = 2'b11;
		$monitor("%b",$time);
		$monitor("%b %b %b", pc_addr_out, instructions, dataToWrite);
		#10 $finish;

	end


pc pc(clk, pc_addr_out, final_next_pc, reset);

memory mem(instructions, readData, pc_addr_out, memWrite, memRead, alu_ctrl_result, rs_data);

mux2_1_ctrl1 mux4(pc_next_next_8, pc_next_8, j_immediate_8, jctrl);

ALU alu2(zero_X, pc_next_8, ones_8, pc_addr_out);

ALU alu3(zero_XX, alu3_result_8, pc_addr_out, rt_2_8);

mux2_1_ctrl1 mux5(pc_next_next_next_8, pc_next_8, alu3_result_8, jalctrl);

ALU alu5(zero_XXX, pc_plus_two, pc_next_next_next_8, ones_8);

or or1(jumpflag_or_output, jctrl, jumpflag);		//control for mux at upper right

mux2_1_ctrl1 mux6(next_next_pc_8, pc_next_next_next_8, rt_data, jrctrl);

mux2_1_ctrl1 mux7(final_next_pc, next_next_pc_8, pc_next_next_8, jumpflag_or_output);

mux3_1 mux8(dataToWrite, alu_ctrl_result, readData, pc_plus_two, memToReg);

instruction_reg instreg(j_immediate_5,jump_opcode_check_2, instruction_to_control_unit_3, rt_2, rs_2, i_immediate_2, funct, instructions);

signext_5to8 ext1(j_immediate_8, j_immediate_5);

signext_2to8 ext2(jump_opcode_check_8, jump_opcode_check_2);

ALU alu(alu1_zero, result_X, jump_opcode_check_8, jump_opcode_check_alu_input);

mux2_1_ctrl1_out1 mux1(funct_input_ctrl_unit, zero, funct, alu1_zero);

register_file rf(jctrlctrl, rt_data, rs_data, regWrite, beqctrl, jrctrl, ALUsrc, rt_2, rs_2, dataToWrite, slt_reg, rs_write_addr);

ctrl ctrl(jctrl, jrctrl, memWrite, memRead, memToReg, ALUop, ALUsrc, regWrite, beqctrl, ractrl, jalctrl, jctrlctrl, instruction_to_control_unit_3, funct);

mux2_1_ctrl1_in2 mux2(rs_write_addr, rs_2, ra_address, ractrl);

signext_2to8 ext3(rt_2_8, rt_2);

mux2_1_ctrl1 mux3(alu_ctrl_in_8, rt_data, rt_2_8, ALUsrc);

ALUctrlunit aluctrlunit(ALUctrlbits, ALUop, funct);

ALUctrl aluctrl(slt_reg, jumpflag, alu_ctrl_result, ALUctrlbits, rs_data, alu_ctrl_in_8);




endmodule
