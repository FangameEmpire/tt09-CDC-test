// Testbench  designed for Quartus and ModelSim
`timescale 1ns/10ps
module alu_Testbench();
	// Choose a width
	LOCALPARAM WIDTH = 8;

	// Module ports
	wire en_i;
	wire [02:00] ctl_i;
	
	wire [WIDTH * 2 - 1:00] AB_i;
	wire [WIDTH * 2 - 1:00] BC_o;
	
	// Device under test
	alu due (en_i, ctl_i, AB_i, BC_o);
	
	// ALU tests
	initial begin
		// Reset case
		en_i = 0; ctl_i = 0; AB_i = 0;
		
		// Test pass
		
		// Test arithmetic
		
		// Test logic
		
		//  Test random input for each mode
		
		// Test random input for random mode
	end // initial

endmodule // alu_Testbench

`timescale 1ns/10ps
module enabled_decoder_32_testbench ();
	logic [ 4:0] in;
	logic [31:0] out;
	logic        en;
	
	enabled_decoder_32 dut (.*);
	
	initial begin
		en = 1;
		for (int i = 0; i < 32; i = i + 1) begin
			in = i; #10;
		end // for
		in = 0; #10;
		
		en = 0;
		for (int i = 0; i < 32; i = i + 1) begin
			in = i; #10;
		end // for
		in = 0; #10;
		
	end // initial
	
endmodule // enabled_decoder_32_testbench
