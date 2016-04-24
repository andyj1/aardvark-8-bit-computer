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
reg [4:0]data1;

//?????????????Output Ports????????????????????????????
// outputs from the DUT are wire type
wire [7:0]result;

//??????----?-??????Instructions---???????????????--???

// instantiate the DUT using named instantiation
signext5 signext(result, data1);

//initial blocks are sequential and start at time 0
initial
begin

	
	
	$display("<<Starting the Simulation>>");
	data1 = 5'b10101;
	$display("data1: %b result: %b", data1, result);
	$display("data1: %d result: %d", data1, result);
end

//ctrl(jctrl, jrctrl, memWrite, memRead, memToReg, ALUop, instr);
//alu(ALUop, data1, data2, zero, result);
//four2one(out, in0, in1, in2, in3, ctrl);
//two2one(out, in0, in1, ctrl);

endmodule
		