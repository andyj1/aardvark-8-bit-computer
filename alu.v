//////////////////////////////////////////////////////////////////////////////////
//Created by: Brenda So
//Created at: 04/17/2016
// Module Name: alu.v
// Description: ALU that takes in an ALU op code performs operations on 
// data1 and data2. Gives result or an output at zero (for jumping).
// 111: add
// 001: nand
// 010: comparison
// 011: shift left
// 100: shift right
// 101: equal
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ns

module alu_ctrl(ALUop, data1, data2, zero, result);

//?????????????Input Ports?????????????????????????????

input [2:0]ALUop;	//3 bits of ALU opcode
input [7:0]data1;	//8 bits of data
input [7:0]data2;	//8 bits of data

//?????????????Output Ports????????????????????????????

output [7:0] result; 	//8 bits of result
output zero; 			//Gives 1 for jumping

//?????????????Input ports Data Type???????????????????
// By rule all the input ports should be wires
wire [2:0]ALUop;	//3 bits of ALU opcode
wire [7:0]data1;	//8 bits of data
wire [7:0]data2;	//8 bits of data

//?????????????Output Ports Data Type??????????????????
// Output port can be a storage element (reg) or a wire
reg [7:0] result;
reg zero;

//?????????????Output Ports Data Type??????????????????
reg [7:0]save_bit;

//??????----?-??????Instructions---???????????????--???
always @ ALUop
begin
	result = 0;
	zero = 0;
	save_bit = 0;
	if (ALUop == 3'b000) begin		//addition
		result = data1 + data2;
	end 
	if (ALUop == 3'b001) begin	//nand
		result = ~(data1 & data2);
	end 
	if (ALUop == 3'b010) begin	//comparison
		if (data1 > data2) begin
			result = 0;
		end 
		if (data1 < data2) begin
			result = 1;
		end
	end 
	if (ALUop == 3'b011) begin	//shift left
		result = data1 << 1;
	end 
	if (ALUop == 3'b100) begin	//shift right
		//keep the sign
		if (data1 >= 8'b10000000) begin
			save_bit = 8'b10000000;
		end if (data1 < 8'b00000000) begin
			save_bit = 8'b00000000;
		end
		result = save_bit + (data1 >> 1);
		
	end 
	if (ALUop == 3'b101) begin	//equal
		if (data1 == data2) begin
			zero = 1;
		end
	end 
end


endmodule
