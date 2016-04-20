//////////////////////////////////////////////////////////////////////////////////
//  Created by: Brenda So
//  Created at: 04/20/2016
// Module Name: tb.v
// Description: TestBench 
// NOTE: DUT stands for Device Under Testing
//////////////////////////////////////////////////////////////////////////////////
module tb;

//−−−−−−−−−−−−−Input Ports−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
// inputs to the DUT are reg type
reg [4:0]data1;

//−−−−−−−−−−−−−Output Ports−−−−−−−−−−−−−−−−−−−−−−−−−−−−
// outputs from the DUT are wire type
wire [7:0]result;

//−−−−−−----−-−−−−−−Instructions---−−−−−−−−−−−−−−−--−−−

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

endmodule
		