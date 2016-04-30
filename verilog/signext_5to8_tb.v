`include "signext_5o8.v"
module signext_5to8_tb();
	wire [7:0] dOut;
	reg [4:0] dIn;
	reg clk = 0;

	initial begin
		dIn = 0;
		$monitor("time: %t, dIn: %b, dOut: %b", $time, dIn, dOut);
		#5 dIn = -1; 
		#10 $finish;
	end
	
	signext_5to8 ext1(dOut, dIn);
endmodule
