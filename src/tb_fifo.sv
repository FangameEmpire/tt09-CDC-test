// Testbench  designed for Quartus and ModelSim
`timescale 1ns/10ps
module fifo_testbench();
	// Choose a width
	localparam WIDTH = 8;
	
	// Module ports
	logic clk_i, rst_i, en_i;
	logic shift_i, load_i;
	logic data_valid_o;
	
	logic serial_i;
	logic serial_o;
	logic [WIDTH - 1:0] parallel_i;
	logic [WIDTH - 1:0] parallel_o;
	
	// Device under test
	fifo dut (.*);
	
	// Simulation parameters
	string current_test;
	
	// Set up a simulated clock.
	parameter CLOCK_PERIOD=100;
	initial begin
		clk_i <= 0;
		forever #(CLOCK_PERIOD/2) clk_i <= ~clk_i;
	end
	
	// Shift Register test
	initial begin
		// Reset
		current_test = "RESET";
		rst_i <= 1; en_i = 0; shift_i = 0; load_i = 0; serial_i = 0; parallel_i = 0; 	repeat(01) @(posedge clk_i);
		rst_i = 0;  																	repeat(01) @(posedge clk_i);
		
		// Shift in
		en_i = 1; serial_i = $urandom(); shift_i = 1;	repeat(04) @(posedge clk_i);
		shift_i = 0;									repeat(06) @(posedge clk_i);
	
	end // initial
	
endmodule // fifo_testbench