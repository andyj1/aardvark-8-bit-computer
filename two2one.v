//////////////////////////////////////////////////////////////////////////////////
//Created by: Brenda So
//Created at: 04/17/2016
// Module Name: two2one.v
// Description: two-to-one mux
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ns

module two2one(out, in0, in1, ctrl);

//−−−−−−−−−−−−−Input Ports−−−−−−−−−−−−−−−−−−−−−−−−−−−−−

input ctrl;		//1 bit to control the mux
input [7:0]in0;	//input 1
input [7:0]in1;	//8 bits of data

//−−−−−−−−−−−−−Output Ports−−−−−−−−−−−−−−−−−−−−−−−−−−−−

output [7:0] out; 	//8 bits of output

//−−−−−−−−−−−−−Input ports Data Type−−−−−−−−−−−−−−−−−−−
// By rule all the input ports should be wires
wire ctrl;	
wire [7:0]in0;	
wire [7:0]in1;	

//−−−−−−−−−−−−−Output Ports Data Type−−−−−−−−−−−−−−−−−−
// Output port can be a storage element (reg) or a wire
reg [7:0]out;

//−−−−−−----−-−−−−−−Instructions---−−−−−−−−−−−−−−−--−−−
always @ out
begin
	if (ctrl == 0) begin
		out = in0;
	end if (ctrl == 1) begin
		out = in1;
	end
end
endmodule