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
//`include "memory.v"
`include "ALU.v"
`include "ALUctrl.v"
`include "ALUctrlunit.v"
`include "signext_5to8.v"
`include "signext_2to8.v"
`include "pc.v"
`include "mux2_1_ctrl1_out1.v"
`include "mux2_1_ctrl1_in2.v"

module main_tb ();

//instruction_reg.v
	reg [7:0] instruction_input;

	wire [4:0] j_immediate_5;
	wire [1:0] jump_opcode_check_2;
	wire funct;
	wire [2:0] instruction_to_control_unit_3;
	wire [1:0] rt_2;
	wire [1:0] rs_2;
	wire [1:0] i_immediate_2;
//instruction_reg.v

//pc.v
	reg [7:0] pc_addr_in;
	
	wire [7:0] pc_addr_out;
//pc.v

//signext_5to8
	wire [7:0] j_immediate_8;
	wire [7:0] jump_opcode_check_8;
//signext_5to8

//ALU.v
	wire [7:0] result_X;
	wire alu1_zero;
	reg [7:0] jump_opcode_check_alu_input;
//ALU.v

//mux2_1_ctrl1_out1.v
	reg zero;
	wire funct_input_ctrl_unit;
//mux2_1_ctrl1_out1.v

//ctrl.v
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
//ctrl.v

//mux2_1_ctrl1_in2
	reg [1:0] ra_address;
	wire [1:0] rs_write_addr;
//mux2_1_ctrl1_in2

//register_file.v
	reg [1:0] rt_addr;
	reg [1:0] rs_addr;
	reg [7:0] dataToWrite;
	reg slt_reg;

	wire jctrlctrl;
	wire [7:0] rt_data;
	wire [7:0] rs_data;

	reg [7:0] data_reg [3:0]; 	//3:$ra, 2:$sp, 1: $s1, 0: $s0 
	reg [1:0] address_reg [3:0];
	
//register_file.v

//signext_2to_8.v
	wire [7:0] rt_2_8;
//signext_2to_8.v


reg clk;
//------------------Instructions-----------------------

always 
	#1 clk = ~clk;
initial 
	begin
		clk = 1'b0;	
		ra_address = 2'b11;
		instruction_input = 8'b10110101;
		zero = 0;
		dataToWrite = 0;
		slt_reg = 0;

		
		jump_opcode_check_alu_input = 8'b11111111;

		$display($time, "<<starting the simultation>>");
		
		$monitor("j_immediate_8=%b\njump_opcode_check_8=%b\nfunct=%b\ninstruction_to_control_unit_3=%b\nrt=%b\nrs=%b\ni_immediate=%b\nalu1_zero:%b\nfunct_input_ctrl_unit:%b\njctrl=%b\njrctrl=%b\nmemWrite=%b\nmemRead=%b\nmemToReg=%b\nALUop=%b\nALUsrc=%b\nregWrite=%b\nbeqctrl=%b\nractrl=%b\njctrlctrl:%b\ninst1:%b\ninst2:%b\nrs_write_addr:%b\nrt_data:%b\nrs_data:%b\ndataToWrite:%b\nslt_reg:%b\nrt_2_8:%b\n", j_immediate_8, jump_opcode_check_8, funct,instruction_to_control_unit_3, rt_2, rs_2, i_immediate_2, alu1_zero,funct_input_ctrl_unit,jctrl, jrctrl,memWrite,memRead,memToReg,ALUop,ALUsrc,regWrite,beqctrl,ractrl,jctrlctrl, instruction_to_control_unit_3, funct,rs_write_addr,rt_data, rs_data,dataToWrite,slt_reg,rt_2_8);

		$display($time, "<<finishing the simulation>>");
		
		#100 $finish;
	end

instruction_reg instreg(j_immediate_5,jump_opcode_check_2, instruction_to_control_unit_3, rt_2, rs_2, i_immediate_2, funct, instruction_input);

signext_5to8 ext1(j_immediate_8, j_immediate_5);

signext_2to8 ext2(jump_opcode_check_8, jump_opcode_check_2);

ALU alu(alu1_zero, result_X, jump_opcode_check_8, jump_opcode_check_alu_input);

mux2_1_ctrl1_out1 mux1(funct_input_ctrl_unit, zero, funct, alu1_zero);

register_file rf(jctrlctrl, rt_data, rs_data, regWrite, beqctrl, jrctrl, ALUsrc, rt_2, rs_2, dataToWrite, slt_reg, rs_write_addr);

ctrl ctrl(jctrl, jrctrl, memWrite, memRead, memToReg, ALUop, ALUsrc, regWrite, beqctrl, ractrl, jalctrl, jctrlctrl, instruction_to_control_unit_3, funct);

mux2_1_ctrl1_in2 mux2(rs_write_addr, rs_2, ra_address, ractrl);

signext_2to8 ext3(rt_2_8, rt_2);


endmodule
