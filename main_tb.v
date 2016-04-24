//////////////////////////////////////////////////////////////////////////////////
//
// School: The Cooper Union
// Course: ECE151A Spring 2016
// Assignment: Final Project -- 8-bit computer
// Group members: Andy Jeong, Brenda So, Gordon Macshane
// Date: 04/20/2016
// DUT (Device Under Testing)
//////////////////////////////////////////////////////////////////////////////////

`include "signext5.v"
`include "alu.v"
`include "ctrl.v"
`include "mux4_1.v"
`include "mux2_1.v"

`timescale 1ns / 1ns

module main_tb();

//?????????????Input Ports?????????????????????????????
// inputs to the DUT are reg type
reg [4:0]reg_data1;
reg reg_clk;
//?????????????Output Ports????????????????????????????
// outputs from the DUT are wire type
wire [7:0]wire_result;

//??????----?-??????Instructions---???????????????--???

// instantiate the DUT using named instantiation
signext5 signext(wire_result, reg_data1);

//initial blocks are sequential and start at time 0
initial
	reg_clk = 0;
	always $1 clk = ~clk;

begin	
	
	$display("<<Starting the Simulation>>");
	reg_data1 = 5'b10101;
	$monitor("data1: %b result: %b", reg_data1, wire_result);
	$monitor("data1: %d result: %d", reg_data1, wire_result);
end

//ctrl(jctrl, jrctrl, memWrite, memRead, memToReg, ALUop, instr);
//alu(ALUop, data1, data2, zero, result);
//mux4_1(out, in0, in1, in2, in3, ctrl);
//mux2_1(out, in0, in1, ctrl);

endmodule
		