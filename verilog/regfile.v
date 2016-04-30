//////////////////////////////////////////////////////////////////////////////////
// Module Name: regfile.v
// Description: stores all the registers
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ns

module regile(RegWrite, readreg1, readreg2, write1, write_data, data1, data2, sCtrl0, sCtrl1);

//−−−−−−−−−−−−−Input Ports−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
input RegWrite;		//control wire
input sCtrl0;
input sCtrl1;
input [1:0] readreg1;	//address of reg1
input [1:0] readreg2;	//address of reg2
input [1:0] write1;	//address of write register
input [7:0] write_data;	//things to write into register

//−−−−−−−−−−−−−Output Ports−−−−−−−−−−−−−−−−−−−−−−−−−−−−
output [7:0] data1;	//value in reg1
output [7:0] data2;	//value in reg2

//-------------Input Types-----------------------------

wire RegWrite;
wire sCtrl0;
wire sCtrl1;
reg readreg1;
reg readreg2;
reg write1;
reg write_data;

//-------------Output Types----------------------------
	
reg data1;
reg data2;

//-------------Storage Data----------------------------
reg[7:0] s1;
reg[7:0] s2;
reg[7:0] sp;
reg[7:0] ra;
reg[7:0] comp1;
reg[7:0] comp0;

//-------------load instructions---------------
//8 bit wide, 256 address deep register memory
initial begin
	s0 = 0;
	s1 = 0;
	sp = 0;
	ra = 0;
	comp0 = 0;
	comp1 = 0;
end

always 
begin
//Read data
	if (readreg1 == 0) begin
		assign data1 = s1;
	end if (readreg1 = 1) begin
		assign data1 = s2;
	end if (readreg1 = 2) begin
		assign data1 = sp;
	end if (readreg1 = 3) begin
		assign data1 = ra;
	end 

	if (readreg2 = 0) begin
		assign data2 = s1;
	end if (readreg2 = 1) begin
		assign data2 = s2;
	end if (readreg2 = 2) begin
		assign data2 = sp;
	end if (readreg2 = 3) begin
		assign data2 = ra;
	end 

	if (RegWrite == 1) begin
		if (write1 = 0) begin
			assign s1 = write_data;
		end if (write1 = 1) begin
			assign s2 = write_data;
		end if (write1 = 2) begin
			assign sp = write_data;
		end if (write1 = 3) begin
			assign ra = write_data;
		end 
	end if (sCtrl0 == 1) begin
		assign comp0 = write_data;
	end if (sCtrl1 == 1) begin
		assign comp1 = write_data;
	end
	
//write data
end
endmodule



