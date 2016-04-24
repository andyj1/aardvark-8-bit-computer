//////////////////////////////////////////////////////////////////////////////////
//Created by: Brenda So
//Created at: 04/17/2016
// Module Name: ctrl.v
// Description: control unit of 8 bit computer
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ns

module ctrl(jctrl, jrctrl, memwrite, memread, memtoreg, ALUop, instr);

//−−−−−−−−−−−−−Input Ports−−−−−−−−−−−−−−−−−−−−−−−−−−−−−

input [3:0] instr;		

//−−−−−−−−−−−−−Output Ports−−−−−−−−−−−−−−−−−−−−−−−−−−−−

output jctrl;
output jrctrl;
output memwrite;
output memread;
output memtoreg;
output [2:0]ALUop;

//−−−−−−−−−−−−−Input ports Data Type−−−−−−−−−−−−−−−−−−−
// By rule all the input ports should be wires
wire [3:0] instr;		

//−−−−−−−−−−−−−Output Ports Data Type−−−−−−−−−−−−−−−−−−
// Output port can be a storage element (reg) or a wire
reg jctrl;
reg jrctrl;
reg memwrite;
reg memread;
reg memtoreg;
reg [2:0]ALUop;

//−−−−−−----−-−−−−−−Instructions---−−−−−−−−−−−−−−−--−−−
always @ instr
begin
	jctrl = 0;
	jrctrl = 0;
	memwrite = 0;
	memread = 0;
	memtoreg = 0;
	ALUop = 0;
	if (instr == 0) begin	//add
		ALUop = 3'b111;
	end if (instr == 2) begin	//nand
		ALUop = 3'b001;
	end if (instr == 4) begin	//slt_0
		ALUop = 3'b010;
	end if (instr == 5) begin	//slt_1
		ALUop = 3'b010;
	end if (instr == 6) begin	//sl
		ALUop = 3'b011;
	end if (instr == 7) begin	//sr
		ALUop = 3'b100;
	end if (instr == 8) begin	//lw
		memread = 1;
		memtoreg = 1;
	end if (instr == 9) begin 	//sw
		memwrite = 1;
	end if (instr == 10) begin	//addi (didn't add to excel sheet)
		ALUop = 3'b111;
	end if (instr == 11) begin	//jr
		jrctlr = 1;
	end if (instr == 12) begin	//beq	
		alu_op = 3'b101;
		jctrl = 1;
	end if (instr == 13) begin //jal
		jctrl = 1;	
	end
end
endmodule