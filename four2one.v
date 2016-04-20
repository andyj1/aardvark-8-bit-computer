//////////////////////////////////////////////////////////////////////////////////
//Created by: Brenda So
//Created at: 04/17/2016
// Module Name: four2one.v
// Description: four-to-one mux
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ns

module four2one(out, in0, in1, in2, in3, ctrl);

//−−−−−−−−−−−−−Input Ports−−−−−−−−−−−−−−−−−−−−−−−−−−−−−

input [1:0]ctrl;		//1 bit to control the mux
input [7:0]in0;	//input 1
input [7:0]in1;	//8 bits of data
input [7:0]in2;	//input 1
input [7:0]in3;	//8 bits of data


//−−−−−−−−−−−−−Output Ports−−−−−−−−−−−−−−−−−−−−−−−−−−−−

output [7:0] out; 	//8 bits of output

//−−−−−−−−−−−−−Input ports Data Type−−−−−−−−−−−−−−−−−−−
// By rule all the input ports should be wires
wire ctrl;	
wire [7:0]in0;	
wire [7:0]in1;	
wire [7:0]in2;	
wire [7:0]in3;	

//−−−−−−−−−−−−−Output Ports Data Type−−−−−−−−−−−−−−−−−−
// Output port can be a storage element (reg) or a wire
reg [7:0] out;

//−−−−−−----−-−−−−−−Instructions---−−−−−−−−−−−−−−−--−−−
always @ out
begin
	if (ctrl == 0) begin
		out = in0;
	end if (ctrl == 1) begin
		out = in1;
	end if (ctrl == 2) begin
		out = in2;
	end if (ctrl == 3) begin
		out = in3;
	end
end
endmodule