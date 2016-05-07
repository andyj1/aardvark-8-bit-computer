//////////////////////////////////////////////////////////////////////////////////
// Created by: Team Aardvark
// Course: Cooper Union ECE151A Spring 2016
// Professor: Professor Marano
// Module Name: 
// Description: 
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ns
`include "add1.v"
`include "pc.v"
`include "memory.v"
`include "instruction_reg.v"
`include "signext_2to8.v"
`include "signext_5to8.v"
`include "ALU_zero.v"
`include "mux2_1_ctrl1.v"
`include "mux2_1_ctrl1_in2.v"
`include "ctrl.v"
`include "register_file.v"
`include "ALUctrlunit.v"
`include "ALUctrl.v"
`include "mux2_1_ctrl1_out1.v"
`include "mux3_1.v"
`include "addimm.v"

module main_tb ();
//WIRES
wire [7:0] pcAddrIn;		//new pc address
wire [7:0] pcAddrOut;		//current pc address
wire [7:0] instruction;		//current instruction
wire [7:0] rt_data;		//Data from rt that goes into ALU
wire [7:0] rs_data;		//Data from rs that goes into ALU
wire [2:0] ALUctrlbits;		//ALU control 
wire jumpFlag_ALUctrl;		//branching decision
wire [7:0] ALUresult;		//results from calculation of main ALU
wire beqSatisfied;
wire sltReg;
wire [7:0] pcAddrOutPlusImm;
wire [7:0] pcFinalOut;
wire [7:0] jrAddr;
wire [7:0] jalAddr;
wire [7:0] pcAddrIn;
wire [1:0] nextctrl;
wire [7:0] pcAddrOutPlusOne;

//DECODER
wire [7:0] readData;		//data read from instruction memory, currently unused
wire [4:0] jImm5;		//inst[4:0], obtain PC relative address
wire [7:0] jImm8;		//extended jImm5
wire [1:0] jumpCheck2;	//inst[7:6], to see whether instruction is jump
wire [7:0] jumpCheck8;	//extended jOpCodeCheck
wire [2:0] inst2CtrlUnit;		//Opcode from instruction register
wire [1:0] rtAddr;
wire [1:0] rsAddr;
wire [1:0] iImm2;
wire funct;
wire jumpCtrlToMux;		//Ctrl to MUX for control unit (ctrlJumpMUX)
wire muxJumpFlag;		//jump control that ultimately goes into ctrl unit 

//REGISTER FILE
wire [7:0] rtData;
wire [7:0] rsData;
wire [1:0] rsWriteAddr;	
wire [7:0] dataToWrite;
wire [7:0] muxALUsrc;
wire [7:0] iImm8;
reg [1:0] returnAddr;

wire [7:0] s0_data;
wire [7:0] s1_data;
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
	#2 clk = ~clk;
	end
initial 
	begin
		$monitor("instruction: %b",instruction);
		//initialize unused wires
		clk = 0;
		reset = 0;
		//pcAddrIn = 8'b00000000;
		returnAddr = 2'b11;
		#1 reset = 0;
		$monitor("%b",pcFinalOut);
		zero = 0;		
		#100 $finish;
	end


//Main PC counter						
pc mainPC(clk , pcAddrIn, pcAddrOut , reset); 
//INPUT: pcAddrIn
//OUTPUT: pcAddrOut 
//---------------------------------------------------------------------------
memory mainMem(instruction, readData, pcAddrOut, memWrite, memRead, ALUresult, rtData); 
//INPUT: pcAddrOut, memWrite, memRead, ALUresult, rtData
//OUTPUT: instruction, readData
//---------------------------------------------------------------------------
instruction_reg instReg(jImm5, jumpCheck2, inst2CtrlUnit, rtAddr, rsAddr, iImm2, funct, instruction);	//instruction register for decoding
//INPUT: instruction
//OUTPUT: jImm5, jumpCheck2, inst2CtrlUnit, rtAddr, rsAddr, iImm2, funct
//---------------------------------------------------------------------------
signext_2to8 ext1(jumpCheck8, jumpCheck2);	//sign extension for jump opcode check
//INPUT: jumpCheck2
//OUTPUT: jumpCheck8
//---------------------------------------------------------------------------
signext_5to8 ext2(jImm8, jImm5);			//sign extension for jump immediate
//INPUT: jImm5
//OUTPUT: jImm8
//---------------------------------------------------------------------------
signext_2to8 ext3(iImm8, iImm2);			//sign extension for I instruction
//INPUT: iImm2
//OUTPUT: iImm8
//---------------------------------------------------------------------------
ALU_zero compareforjump(jumpCtrlToMux, jumpCheck8);	//Check for jump code
//INPUT: jumpCheck8
//OUTPUT: jumpCtrlToMux
//---------------------------------------------------------------------------
mux2_1_ctrl1 ctrlJumpMux(muxJumpFlag, zero, funct, jumpCtrlToMux);		//choose between Jumps
//INPUT: zero, funct
//OUTPUT: muxJumpFlag
//CONTROL: jumpCtrlToMux
//---------------------------------------------------------------------------
mux2_1_ctrl1_out1 ctrlJR(rsWriteAddr, rtAddr, returnAddr, ractrl);		//choose between ra and rsAddr
//INPUT: rtAddr, returnAddr
//OUTPUT: rsWriteAddr
//CONTROL: ractrl
//---------------------------------------------------------------------------
ctrl mainCtrl(jctrl, jrctrl, memWrite, memRead, memToReg, ALUOp, ALUsrc, nextctrl, regWrite, beqctrl, ractrl, jalctrl, sltCtrl, inst2CtrlUnit, muxJumpFlag);
//INPUT: inst2CtrlUnit, muxJumpFlag(== funct if R or I type)
//OUTPUT: jctrl, jrctrl, memWrite, memRead, memToReg, ALUOp, ALUsrc, nextctrl, regWrite, beqctrl, ractrl, jalctrl, sltCtrl
//---------------------------------------------------------------------------
//Register File		
register_file mainRegfile(rtData, rsData, s0_data, s1_data, sp_data, ra_data, regWrite, beqctrl, jrctrl, ALUsrc, rtAddr, rsWriteAddr, dataToWrite, sltCtrl, rsAddr);
//INPUT: regWrite, beqctrl, jrctrl, ALUsrc, rtAddr, rsWriteAddr, dataToWrite, sltCtrl, rsAddr
//OUTPUT: rtData, rsData, s0_data, s1_data, sp_data, ra_data
//---------------------------------------------------------------------------
mux2_1_ctrl1_in2 ctrlImm(muxALUsrc, rtData, iImm8, ALUsrc);			//choose between rt and immediate
//INPUT: rtData, iImm8
//OUTPUT: muxALUsrc
//CONTROL: ALUsrc
//---------------------------------------------------------------------------
ALUctrlunit aluctrlunit(ALUctrlbits, ALUOp, funct);		
//INPUT: ALUOp, funct
//OUTPUT: ALUctrlbits
//---------------------------------------------------------------------------
ALUctrl aluctrl(jumpFlag_ALUctrl, ALUresult, sltReg, ALUctrlbits, muxALUsrc, rsData);		
//INPUT: ALUctrlbits, muxALUsrc, rsData
//OUTPUT: jumpFlag_ALUctrl, ALUresult, sltReg		here: ALUresult is computed value if R type, effective address in memory if I type
//---------------------------------------------------------------------------
add1 add1(pcAddrOut, pcAddrOutPlusOne);			
//INPUT: pcAddrOut
//OUTPUT pcAddrOutPlusOne					for R or I type, PC(final) = PC(current) + 1
//---------------------------------------------------------------------------
addimm addimm(pcAddrOutPlusImm, pcAddrOut, jImm8);
//INPUT: pcAddrIn
//OUTPUT: pcAddrOutPlusImm					for J type, PC(final) = PC(current) + immediate
//IMMEDIATE: jImm8

//---------------------------------------------------------------------------pcPlusTwo == originally pcAddrIn
mux3_1 ctrlwb(dataToWrite, ALUresult, readData, pcAddrOutPlusOne, memToReg);		//choose between memory, ALU and PC to writeback to regFile
//INPUT: ALUresult, readData, pcAddrOutPlusOne (for jal next pc)
//OUTPUT: dataToWrite
//CONTROL: memToReg

//---------------------------------------------------------------------------
mux3_1 ctrlnextpc(pcAddrIn, pcAddrOut, rsData, pcAddrOutPlusImm, nextctrl);
//INPUT: pcAddrOut, rsData, pcAddrOutPlusImm
//OUTPUT: pcAddrIn
//CONTROL: nextctrl
//---------------------------------------------------------------------------
and a1(beqSatisfied, jumpCtrlToMux, beqctrl);
//INPUT: jumpCtrlToMux, beqctrl
//OUTPUT: beqSatisfied
//---------------------------------------------------------------------------

mux2_1_ctrl1_in2 ctrljalMUX(jalAddr, pcAddrOut, pcAddrOutPlusImm, jalctrl);		//choose between jal(pc+imm) and pc+1
mux2_1_ctrl1_in2 ctrljrMUX(jrAddr, jalAddr, rsData, jrctrl);			//choose between jr $ra and whatever comes from from ctrljalMUX
mux2_1_ctrl1_in2 ctrlbeqMUX(pcFinalOut, pcAddrOut,jrAddr, beqSatisfied);		//choose between beq relative address and whatever comes out from ctrljrMUX

endmodule




