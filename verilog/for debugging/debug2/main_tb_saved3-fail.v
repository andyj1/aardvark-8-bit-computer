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

//instruction_reg.v
	//wire [7:0] instructions;	//from memory

	wire [4:0] j_immediate_5;
	wire [1:0] jump_opcode_check_2;
	wire funct;
	wire [2:0] instruction_to_control_unit_3;
	wire [1:0] rt_2;
	wire [1:0] rs_2;
	wire [1:0] i_immediate_2;
//instruction_reg.v

//pc.v
	//reg [7:0] pc_addr_in;
	
	wire [7:0] pc_addr_out;
	//reg [7:0] pc_addr_out;
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
	//reg [7:0] dataToWrite;

	wire jctrlctrl;
	wire [7:0] rt_data;
	wire [7:0] rs_data;

	reg [7:0] data_reg [3:0]; 	//3:$ra, 2:$sp, 1: $s1, 0: $s0 
	reg [1:0] address_reg [3:0];
	
//register_file.v

//signext_2to_8.v
	wire [7:0] rt_2_8;
//signext_2to_8.v

//mux2_1_ctrl1
	wire [7:0] alu_ctrl_in_8;
///mux2_1_ctrl1

//ALUctrlunit.v
	wire [2:0] ALUctrlbits;
//ALUctrlunit.v

//ALUctrl.v
	wire jumpflag;
	wire [7:0] alu_ctrl_result;
	wire slt_reg;
//ALUctrl.v

//ALU.v pc
	wire zero_X;
	wire [7:0] pc_next_8;
	reg [7:0] ones_8;
//ALU.v pc

//mux2_1_ctrl1 
	wire [7:0] pc_next_next_8;
//mux2_1_ctrl1

//ALU.v alu3
	wire zero_XX;
	wire[7:0] alu3_result_8;
//ALU.v alu3

//mux5
	wire [7:0] pc_next_next_next_8;
//mux5

//or
	wire jumpflag_or_output;
//or

//mux6
	wire [7:0] next_next_pc_8;
//mux6

//mux7
 wire [7:0] final_next_pc;
//mux7

//alu5
	wire zero_XXX;
	wire [7:0] pc_plus_two;
//alu5

//mux8
	wire [7:0] readData;	//from memory
	wire [7:0] dataToWrite;
//mux8


//memory
	reg [7:0] MDR [255:0];		//8 bit wide, 256 address deep register memory
	wire [7:0] instructions;
	
//memory

reg [7:0] initialreg;
reg clk;

parameter INSTRUCTIONS = "./test.bin";
//------------------Instructions-----------------------

always 
	#1 clk = ~clk;
initial 
	begin
		$display($time, "<<starting the simultation>>");

		//instructions = 8'b11100101;
		//dataToWrite = 0;
		//pc_addr_in = 8'b00001000;

		zero = 0;
		ones_8 = 8'b00000001;
		jump_opcode_check_alu_input = 8'b11111111;
		clk = 1'b0;	
		ra_address = 2'b11;

		$display("instructions:%b\nj_immediate_8=%b\njump_opcode_check_8=%b\nfunct=%b\ninstruction_to_control_unit_3=%b\nrt=%b\nrs=%b\ni_immediate=%b\nalu1_zero:%b\nfunct_input_ctrl_unit:%b\njctrl=%b\njrctrl=%b\nmemWrite=%b\nmemRead=%b\nmemToReg=%b\nALUop=%b\nALUsrc=%b\nregWrite=%b\nbeqctrl=%b\nractrl=%b\njctrlctrl:%b\ninst1:%b\ninst2:%b\nrs_write_addr:%b\nrt_data:%b\nrs_data:%b\ndataToWrite:%b\nslt_reg:%b\nrt_2_8:%b\nalu_ctrl_in_8:%b\nALUctrlbits:%b\njumpflag:%b\nalu_ctrl_result:%b\npc_addr_out:%b\npc_next_8:%b\npc_next_next_8:%b\nalu3_result_8:%b\npc_next_next_next_8:%b\nnext_next_pc_8:%b\nfinal_next_pc:%b\npc_plus_two:%b\nreadData:%b\n", instructions,j_immediate_8, jump_opcode_check_8, funct,instruction_to_control_unit_3, rt_2, rs_2, i_immediate_2, alu1_zero,funct_input_ctrl_unit,jctrl, jrctrl,memWrite,memRead,memToReg,ALUop,ALUsrc,regWrite,beqctrl,ractrl,jctrlctrl, instruction_to_control_unit_3, funct,rs_write_addr,rt_data, rs_data,dataToWrite,slt_reg,rt_2_8,alu_ctrl_in_8,ALUctrlbits,jumpflag, alu_ctrl_result,pc_addr_out,pc_next_8,pc_next_next_8,alu3_result_8,pc_next_next_next_8,next_next_pc_8,final_next_pc,pc_plus_two,readData);

		$display($time, "<<finishing the simulation>>");
		
		#1 $finish;
	end

memory mem(instructions, readData, pc_addr_out, memWrite, memRead, alu_ctrl_result, rs_data);

pc pc(pc_addr_out, final_next_pc);

mux2_1_ctrl1 mux4(pc_next_next_8, pc_next_8, j_immediate_8, jctrl);

ALU alu2(zero_X, pc_next_8, ones_8, pc_addr_out);

ALU alu3(zero_XX, alu3_result_8, pc_addr_out, rt_2_8);

mux2_1_ctrl1 mux5(pc_next_next_next_8, pc_next_8, alu3_result_8, jalctrl);

ALU alu5(zero_XXX, pc_plus_two, pc_next_next_next_8, ones_8);

or or1(jumpflag_or_output, jctrl, jumpflag);		//control for mux at upper right

mux2_1_ctrl1 mux6(next_next_pc_8, pc_next_next_next_8, rt_data, jrctrl);

mux2_1_ctrl1 mux7(final_next_pc, next_next_pc_8, pc_next_next_8, jumpflag_or_output);

mux3_1 mux8(dataToWrite, alu_ctrl_result, readData, pc_plus_two, memToReg);
//-----------
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
