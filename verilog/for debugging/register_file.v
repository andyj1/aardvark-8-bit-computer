//////////////////////////////////////////////////////////////////////////////////
// Created by: Team Aardvark
// Course: Cooper Union ECE151A Spring 2016
// Professor: Professor Marano
// Module Name: 
// Description: 
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ns

module register_file (rt_data, rs_data, regWrite, beqctrl, jrctrl, ALUsrc, rt_addr, rs_addr, dataToWrite, slt_reg, rs_write_addr, s1_data, s2_data, sp_data, ra_data);

input wire regWrite;
input wire beqctrl;
input wire jrctrl;
input wire ALUsrc;		//I type control for immediate
input wire [1:0] rt_addr;
input wire [1:0] rs_addr;
input wire [7:0] dataToWrite;
input wire [1:0] slt_reg;	//controlled by controlUnit now
input wire [1:0] rs_write_addr;


output reg [7:0] rt_data;
output reg [7:0] rs_data;

output reg [7:0] s1_data;
output reg [7:0] s2_data;
output reg [7:0] sp_data;
output reg [7:0] ra_data;

reg [7:0] data_reg [3:0]; 	 
reg [1:0] address_reg [3:0];	//3:$ra, 2:$sp, 1: $s1, 0: $s0
reg [7:0] t0;
reg [7:0] t1;



//------------------Instructions-----------------------
initial 
	begin
		address_reg[0] = 2'b00;
		address_reg[1] = 2'b01;
		address_reg[2] = 2'b10;
		address_reg[3] = 2'b11;
		rt_data = 8'b00000000;
		rs_data = 8'b00000000;
		data_reg[3] = 8'b00000100;	//ra
		data_reg[2] = 8'b11111111;	//sp
		data_reg[1] = 8'b00001000;	//s1
		data_reg[0] = 8'b01000000;	//s0
		t0 = 8'b00000000;
		t1 = 8'b00000000;
	end

//when there is an input address, data reg at that input address = its dataReadReg
always @*
	begin
	if (beqctrl == 0) begin
		if (rt_addr == 2'b00) begin
			rt_data = data_reg[0];
		end if (rt_addr == 2'b01) begin
			rt_data = data_reg[1];
		end if (rt_addr == 2'b10) begin
			rt_data = data_reg[2];
		end if (rt_addr == 2'b11) begin
			rt_data = data_reg[3];
		end

		if (jrctrl == 1) begin
			rs_data = data_reg[rs_write_addr];
		end if (ALUsrc == 1) begin
			rs_data = data_reg[2]; 
		end else begin
		
			if (rs_addr == 2'b00) begin
				rs_data = data_reg[0];
			end if (rs_addr == 2'b01) begin
				rs_data = data_reg[1];
			end if (rs_addr == 2'b10) begin
				rs_data = data_reg[2];
			end if (rs_addr == 2'b11) begin
				rs_data = data_reg[3];
			end
		end
	end if (regWrite == 1) begin
		if(dataToWrite)
			data_reg[address_reg[1]] = #1 dataToWrite;		//rs_addr = address_reg[1] = write register address
	end if (slt_reg == 2'b10) begin
		t0 = #1 dataToWrite;
	end if (slt_reg == 2'b11) begin
		t1 = #1 dataToWrite;
	end if (beqctrl == 1) begin
		//$display("Hello!");
		rt_data = t0;
		rs_data = t1;
	end
		
end
//Write

//always @(regWrite)
//	begin
//		if(dataToWrite)
//			data_reg[address_reg[1]] = #1 dataToWrite;		//rs_addr = address_reg[1] = write register address
//	end

//always @(slt_reg)
//begin
//	if (slt_reg == 2'b10) begin
//		t0 = dataToWrite;	
//	end if (slt_reg == 2'b11) begin
//		t1 = dataToWrite;
//	end
//end
	
//SLT0|SLT1 register value assignment
//always @(beqctrl)
//	begin
//	if (beqctrl == 1'b1) begin
//		rt_data = t0;
//		rs_data = t1;
		//in Testbench, call *ALU (rt_data, rs_data)* to compute equality check
		//output: jctrlctrl --> input to control
//	end
//	end
always @*
begin
	s1_data = data_reg[0];
	s2_data = data_reg[1];
	sp_data = data_reg[2];
	ra_data = data_reg[3];

end


//only when jr, output the fixed $ra address_reg
//always @*
//	if (jrctrl)
//	begin
//		//if jrctrl, rs_write_addr = addr($ra) = 11
//		rs_data = data_reg[rs_write_addr];
//	end
//
//always @*
//	if (ALUsrc == 1)
//	begin
//		$display("Hello!");
//		rs_data = data_reg[2]; 		//stack pointer value -> reg[rs] when I type
//	end


	
endmodule