//////////////////////////////////////////////////////////////////////////////////
//Created by: Brenda So
//Created at: 04/17/2016
// Module Name: signext5.v
// Description: Extent the sign from 5 bits to 8 bits
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ns

module signext5(out,in);

//−−−−−−−−−−−−−Input Ports−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
input [4:0]in;	//input 

//−−−−−−−−−−−−−Output Ports−−−−−−−−−−−−−−−−−−−−−−−−−−−−
output [7:0] out; 	//8 bits of output

//−−−−−−−−−−−−−Input ports Data Type−−−−−−−−−−−−−−−−−−−
// By rule all the input ports should be wires
wire [4:0]in;

//−−−−−−−−−−−−−Output Ports Data Type−−−−−−−−−−−−−−−−−−
// Output port can be a storage element (reg) or a wire
reg [7:0] out;

//−−−−−−−−−−−−−Intermediate Ports Data Type−−−−−−−−−−−−−
reg [2:0] sign;

//−−−−−−----−-−−−−−−Instructions---−−−−−−−−−−−−−−−--−−−
always @ in
begin
	if (in >= 5'b10000) begin
		sign = 3'b111;
	end if (in < 5'b10000) begin
		sign = 3'b000;
	end
	out = {sign,in};
end
endmodule