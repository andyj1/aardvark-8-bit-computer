`include "memory.v"
module memory_tb();
	reg [7:0] address;
	wire [7:0] instruction;
	reg clk = 0;

	initial begin
		address = 0;
		$monitor("time: %t, address: %b, instruction: %b", $time, address, instruction);
		#512 $finish;
	end
	
	always begin
		#1 clk = !clk;
	end

	always @(posedge clk) begin
		address = address + 1;
	end
	memory memory1(address, instruction);
endmodule
