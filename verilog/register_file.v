//////////////////////////////////////////////////////////////////////////////////
// Created by: Team Aardvark
// Course: Cooper Union ECE151A Spring 2016
// Professor: Professor Marano
// Module Name: 
// Description: 
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ns

module register_file (jctrlctrl, rt_data, rs_data, ra_addr, slt0_reg, slt1_reg, regWrite, beqctrl, jrctrl, rt_addr, rs_addr, dataToWrite);

input wire regWrite;
input wire beqctrl;
input wire jrctrl;
input wire [1:0] rt_addr;
input wire [1:0] rs_addr;
input wire [7:0] dataToWrite;
output reg jctrlctrl;
output reg [7:0] rt_data;
output reg [7:0] rs_data;
output reg [7:0] ra_addr;
output reg slt0_reg, slt1_reg;

reg [7:0] data_reg [3:0]; 	//3:$ra, 2:$sp, 1: $s1, 0: $s0 
reg [3:0] address [1:0];
//------------------Instructions-----------------------
initial 
	begin
		ra_addr = 8'b0;
		jctrlctrl = 0;
		address[0] = rt_addr;
		address[1] = rs_addr;
		slt0_reg = 0;
		slt1_reg = 1;
		data_reg[3] = 0;
		data_reg[2] = 0;
		data_reg[1] = 0;
		data_reg[0] = 0;
	end

//Write
always @(regWrite)
	if(regWrite) 
	begin
		data_reg[address[1]] = dataToWrite;
	end
//SLT0/1 register value assignment
always @(beqctrl)
	begin
		if(data_reg[address[0]] == data_reg[address[1]])
		begin
			slt0_reg = 1;
			slt1_reg = 1;
			jctrlctrl = 1;
		//in Testbench, call ALU to compute equality check
		end
	end

//only when jr, output the fixed $ra address
always @(jrctrl)
	begin
		assign ra_addr = 8'b10110011;
	end
	
//when there is an input address, data reg at that input address = its dataReadReg
always @(rt_addr || rs_addr)
	begin
		rt_data = data_reg[address[0]];
		rs_data = data_reg[address[1]];
	end

	
endmodule
