//////////////////////////////////////////////////////////////////////////////////
// Created by: Team Aardvark
// Course: Cooper Union ECE151A Spring 2016
// Professor: Professor Marano
// Module Name: 
// Description: 
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ns

module register_file (jctrlctrl, rt_data, rs_data, ra_addr, slt0_reg, slt1_reg, regWrite, beqctrl, jrctrl, rt_addr, rs_addr, dataToWrite, slt_reg);

input wire regWrite;
input wire beqctrl;
input wire jrctrl;
input wire [1:0] rt_addr;
input wire [1:0] rs_addr;
input wire [7:0] dataToWrite;
input wire slt_reg;

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
		slt1_reg = 0;
		data_reg[3] = 0;
		data_reg[2] = 0;
		data_reg[1] = 0;
		data_reg[0] = 0;
	end

//Write
always @(regWrite)
	begin
		if(dataToWrite)
			data_reg[address[1]] = dataToWrite;		//rs_addr = address[1] = write register address
	end
	

//SLT0/1 register value assignment
always @(beqctrl)
	begin
		if(rt_data < rs_data)
			rt_data = slt_reg;
		if(rt_data > rs_data)
			rs_data = slt_reg;

		rt_data = slt0_reg;
		rs_data = slt1_reg;
		//in Testbench, call *ALU (rt_data, rs_data)* to compute equality check
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
