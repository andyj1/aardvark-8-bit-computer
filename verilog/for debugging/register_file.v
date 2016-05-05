//////////////////////////////////////////////////////////////////////////////////
// Created by: Team Aardvark
// Course: Cooper Union ECE151A Spring 2016
// Professor: Professor Marano
// Module Name: 
// Description: 
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ns

module register_file (jctrlctrl, rt_data, rs_data, regWrite, beqctrl, jrctrl, ALUsrc, rt_addr, rs_addr, dataToWrite, slt_reg, rs_write_addr);

input wire regWrite;
input wire beqctrl;
input wire jrctrl;
input wire ALUsrc;		//I type control for immediate
input wire [1:0] rt_addr;
input wire [1:0] rs_addr;
input wire [7:0] dataToWrite;
input wire slt_reg;
input wire [1:0] rs_write_addr;

output reg jctrlctrl;
output reg [7:0] rt_data;
output reg [7:0] rs_data;

reg [7:0] data_reg [3:0]; 	 
reg [1:0] address_reg [3:0];	//3:$ra, 2:$sp, 1: $s1, 0: $s0
//------------------Instructions-----------------------
initial 
	begin
		jctrlctrl = 0;
		address_reg[0] = 2'b00;
		address_reg[1] = 2'b00;
		address_reg[2] = 2'b00;
		address_reg[3] = 2'b00;
		rt_data = 8'b00000000;
		rs_data = 8'b00000000;
		data_reg[3] = 8'b00000000;
		data_reg[2] = 8'b11111111;	//sp
		data_reg[1] = 8'b00000000;
		data_reg[0] = 8'b00000000;

	end

//when there is an input address, data reg at that input address = its dataReadReg
always @ (rt_addr || rs_addr)
	fork
		rt_data = data_reg[address_reg[rt_addr]];
		rs_data = data_reg[address_reg[rs_data]];
	join

//Write
always @(regWrite)
	begin
		if(dataToWrite)
			data_reg[address_reg[1]] = dataToWrite;		//rs_addr = address_reg[1] = write register address
	end
	
//SLT0|SLT1 register value assignment
always @(beqctrl)
	begin
		if(rt_data < rs_data)
			rt_data = slt_reg;
		if(rt_data > rs_data)
			rs_data = slt_reg;
			
		//in Testbench, call *ALU (rt_data, rs_data)* to compute equality check
		//output: jctrlctrl --> input to control
	end


//only when jr, output the fixed $ra address_reg
always @*
	if (jrctrl)
	begin
		//if jrctrl, rs_write_addr = addr($ra) = 11
		rs_data = data_reg[rs_write_addr];
	end

always @*
	if (ALUsrc)
	begin
		rs_data = data_reg[2]; 		//stack pointer value -> reg[rs] when I type
	end


	
endmodule
