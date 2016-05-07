//////////////////////////////////////////////////////////////////////////////////
// Created by: Team Aardvark
// Course: Cooper Union ECE151A Spring 2016
// Professor: Professor Marano
// Module Name: 
// Description: 
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ns
`include "Addition.v"
`include "pc_update.v"
`include "memory.v"
`include "instruction_reg.v"
`include "signext_2to8.v"
`include "signext_5to8.v"
`include "Compare.v"
`include "mux2_1_ctrl1.v"
`include "mux2_1_ctrl1_in2.v"
`include "ctrl.v"
`include "register_file.v"
`include "ALUctrlunit.v"
`include "ALUctrl.v"
`include "mux2_1_ctrl1_out1.v"
`include "mux3_1.v"
`include "Addition2.v"

module main_tb ();
//WIRES
wire [7:0] pcAddrIn;		//new pc address
wire [7:0] pcAddrOut;		//current pc address
wire [7:0] instruction;		//current instruction
wire [7:0] rt_data;		//Data from rt that goes into ALU
wire [7:0] rs_data;		//Data from rs that goes into ALU
wire [2:0] ALUctrlbits;		//ALU control 
wire beqDecision;		//branching decision
wire [7:0] ALUresult;		//results from calculation of main ALU
wire [7:0] jalAddr;
wire [7:0] jrAddr;

//DECODER
wire [7:0] readData;		//data read from instruction memory, currently unused
wire [4:0] jImm;		//inst[4:0], obtain PC relative address
wire [7:0] newjImm;		//extended jImm
wire [1:0] jOpcodeCheck;	//inst[7:6], to see whether instruction is jump
wire [7:0] newjOpcodeCheck;	//extended jOpCodeCheck
wire [2:0] instCtrl;		//Opcode from instruction register
wire [1:0] rtAddr;
wire [1:0] rsAddr;
wire [1:0] iImm;
wire funct;
wire jumpDecision;		//Ctrl to MUX for control unit (ctrlJumpMUX)
wire finaljumpDecision;		//jump control that ultimately goes into ctrl unit 

//REGISTER FILE
wire [7:0] rtData;
wire [7:0] rsData;
wire [1:0] rsWriteAddr;	
wire [7:0] dataToWrite;
wire [7:0] finalToALU;
wire [7:0] iImmext;
reg [1:0] returnAddr;

wire [7:0] s1_data;
wire [7:0] s2_data;
wire [7:0] sp_data;
wire [7:0] ra_data;

//CONTROLS FROM CONTROL UNIT
wire jctrl; 				//control jal MUX
wire jrctrl;				//control jr MUX
wire memWrite;				//control to write to data memory
wire memRead;				//control to read from data memory
wire [1:0] memToReg;			//control of writeback
wire [2:0] ALUOp;			//control to ALU control
wire ALUsrc;				//control to MUXing between rt and immediate
wire regWrite;				//control to register write
wire beqctrl;				//control for beq
wire ractrl;				//control for choosing between ra and rs
wire jalctrl;				//control choosing between PC and PC+immediate for jal
wire [1:0]sltCtrl;			//control for slt_0 and slt_1

//REGISTERS
reg clk;
reg zero;		//register that stores the memory 0 for comparisons

//TEMPORARY
reg reset;		//reset pc counter


//------------------Instructions-----------------------

always begin
	#1 clk = ~clk;
	end
initial 
	begin
		$monitor("%b : %b ALUctrlbits: %b ALUresult: %b %b: %b %b: %b zero: %b beqctrl: %b", pcAddrOut, instruction, ALUctrlbits, ALUresult, rtAddr, finalToALU, rsAddr, rsData, beqDecision, beqctrl);
		//initialize unused wires
		clk = 0;
		reset = 1;
		returnAddr = 2'b11;
		#1 reset = 0;
		zero = 0;		//consistently zero
		#100 $finish;
	end

//Main memory with data memory and instruction memory
memory mainMem(instruction, readData, pcAddrOut, memWrite, memRead, ALUresult, rtData); 
//Main PC counter						
pc mainPC(clk , pcAddrIn, pcAddrOut , reset);
//Overarching control unit												
ctrl mainCtrl(jctrl, jrctrl, memWrite, memRead, memToReg, ALUOp, ALUsrc, nextctrl, regWrite, beqctrl, ractrl, jalctrl, sltCtrl, instCtrl, finaljumpDecision);
//Register File		
register_file mainRegfile(rtData, rsData, regWrite, beqctrl, jrctrl, ALUsrc, rtAddr, rsWriteAddr, dataToWrite, sltCtrl, rsAddr, s1_data, s2_data, sp_data, ra_data);	
//Main ALU
ALUctrl mainALU(beqDecision, ALUresult, ALUctrlbits, finalToALU,rsData);		

Addition add1(pcAddrOut, pcAddrIn);			//adding pc by 1
Addition add2(pcAddrImm, pcAddrIn, newjImm);
Compare compare1(newjOpcodeCheck, jumpDecision);	//Check for jump code
instruction_reg instReg(jImm, jOpcodeCheck,instCtrl, rtAddr, rsAddr, iImm, funct, instruction);	//instruction register for decoding
signext_2to8 ext1(newjOpcodeCheck,jOpcodeCheck);	//sign extension for jump opcode check
signext_5to8 ext2(newjImm,jImm);			//sign extension for jump immediate
signext_2to8 ext3(iImmext,rtAddr);			//sign extension for I instruction
mux2_1_ctrl1 ctrlJumpMux(finaljumpDecision, zero, funct, jumpDecision);		//choose between Jumps
mux2_1_ctrl1_in2 ctrlImm(finalToALU, rtData, iImmext, ALUsrc);			//choose between rt and immediate
mux2_1_ctrl1_out1 ctrlJR(rsWriteAddr, rsAddr, returnAddr, ractrl);		//choose between ra and rsAddr
mux3_1 ctrlwb(dataToWrite, ALUresult, readData, pcAddrIn, memToReg);		//choose between memory, ALU and PC to writeback to regFile
mux3_1 ctrlnextpc(pcAddrIn, pcAddrOut, rsData, pcAddrImm, nextctrl);

mux2_1_ctrl1_out1 ctrljalMUX(jalAddr, pcAddrOut, pcAddrImm, jalctrl);		//choose between jal and pc+1
mux2_1_ctrl1_out1 ctrljrMUX(jrAddr, jalAddr, rsAddr, jrctrl);			//choose between jr $ra and whatever comes from from ctrljalMUX
and (beqSatisfied, beqctrl, beqDecision);						//see whether conditions of beq is satisfied, with beqctrl and zero from ALU
mux2_1_ctrl1_out1 ctrlbeqMUX(pcFinalOut, jrAddr, pcAddrOut, beqSatisfied);		//choose between beq relative address and whatever comes out from ctrljrMUX

endmodule
