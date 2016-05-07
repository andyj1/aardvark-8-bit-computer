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
module main_tb ();

//instruction_reg.v
	wire [7:0] instruction_input;
	wire [4:0] j_immediate_5;
	wire [1:0] jump_opcode_check_2;
	wire funct;
	wire [2:0] instruction_to_control_unit_3;
	wire [1:0] rt_addr;
	wire [1:0] rs_addr;
	wire [1:0] i_immediate_2;
//pc.v
	reg [7:0] pc_addr_in;
	wire [7:0] pc_addr_out;
//signext_5to8
	wire [7:0] j_immediate_8;
	wire [7:0] jump_opcode_check_8;
//ALU.v
	wire [7:0] result_X;
	wire alu1_zero;
	reg [7:0] jump_opcode_check_alu_input;
//mux2_1_ctrl1_out1.v
	reg zero;
	wire funct_input_ctrl_unit;
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
//mux2_1_ctrl1_in2
	reg [1:0] ra_address;
	wire [1:0] rs_write_addr;
//register_file.v
	reg [7:0] dataToWrite;
	wire jctrlctrl;
	wire [7:0] rt_data;
	wire [7:0] rs_data;
	reg [7:0] data_reg [3:0]; 	//3:$ra, 2:$sp, 1: $s1, 0: $s0 
	reg [1:0] address_reg [3:0];
//signext_2to_8.v
	wire [7:0] rt_addr_8;
//mux2_1_ctrl1
	wire [7:0] alu_ctrl_in_8;
//memory
	wire [7:0] readData;
	reg [7:0] MDR [255:0];
	reg [7:0] alu_ctrl_result;
//ALUctrlunit
	wire [2:0] ALUctrlbits;
//ALUctrl
	wire slt_reg, aluctrl_zero;
	wire [7:0] aluctrl_result;
reg clk;
//------------------Instructions-----------------------

always begin
	#1 clk = ~clk;
	end
initial 
	begin
		$monitor("time: %d\n pc_addr_out: %b \n pc_addr_in: %b \ninstruction_input:%b\n",$time, pc_addr_out, pc_addr_in, instruction_input);
		clk = 0;	
		ra_address = 2'b11;
		zero = 0;
		dataToWrite = 0;
		pc_addr_in = 8'b00000000;
		jump_opcode_check_alu_input = 8'b11111111;
		alu_ctrl_result = 8'b00001001;
		#5 display("time: %d\n pc_addr_out: %b \n pc_addr_in: %b \ninstruction_input:%b\n",$time, pc_addr_out, pc_addr_in, instruction_input);
		$display($time, "<<starting the simultation>>");
		#100 $finish;
		$display($time, "<<finishing the simulation>>");
	end

pc pc(pc_addr_out, pc_addr_in, clk);

memory mem(instruction_input, readData, pc_addr_out, memWrite, memRead, alu_ctrl_result, rs_data);
instruction_reg instreg(j_immediate_5,jump_opcode_check_2, instruction_to_control_unit_3, rt_addr, rs_addr, i_immediate_2, funct, instruction_input);

signext_5to8 ext1(j_immediate_8, j_immediate_5);

signext_2to8 ext2(jump_opcode_check_8, jump_opcode_check_2);

ALU alu(alu1_zero, result_X, jump_opcode_check_8, jump_opcode_check_alu_input);

mux2_1_ctrl1_out1 mux1(funct_input_ctrl_unit, zero, funct, alu1_zero);

mux2_1_ctrl1_in2 mux2(rs_write_addr, rs_addr, ra_address, ractrl);

register_file rf(jctrlctrl, rt_data, rs_data, regWrite, beqctrl, jrctrl, ALUsrc, rt_addr, rs_addr, dataToWrite, slt_reg, rs_write_addr);

ctrl ctrl(jctrl, jrctrl, memWrite, memRead, memToReg, ALUop, ALUsrc, regWrite, beqctrl, ractrl, jalctrl, jctrlctrl, instruction_to_control_unit_3, funct);

signext_2to8 ext3(rt_addr_8, rt_addr);

mux2_1_ctrl1 mux3(alu_ctrl_in_8, rt_data, rt_addr_8, ALUsrc);

ALUctrlunit aluctrlunit(ALUctrlbits, ALUop, funct);

ALUctrl aluctrl(slt_reg, aluctrl_zero, aluctrl_result, ALUctrlbits, rs_data, alu_ctrl_in_8);

endmodule
