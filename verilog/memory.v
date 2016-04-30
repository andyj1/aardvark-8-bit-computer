//////////////////////////////////////////////////////////////////////////////////
// Module Name: memory.v
// Description: loads data from instruction binary file
// von Neumann has 1 memory, harvard has 2 
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ns

module memory(addr, data);

parameter Instructions = "./example.bin";

//−−−−−−−−−−−−−Input Ports−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
input [7:0] addr;

//−−−−−−−−−−−−−Output Ports−−−−−−−−−−−−−−−−−−−−−−−−−−−−
output [7:0] data;

reg [7:0] ram_reg [0:255];   
wire [7:0] addr; 
wire [7:0] data;
	
//-------------load instructions---------------
//8 bit wide, 256 address deep register memory
initial begin
        $readmemb(Instructions, ram_reg);       
end

assign data = ram_reg[addr];

endmodule
