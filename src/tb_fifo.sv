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
		current_test = "SHIFT IN";
		en_i = 1; serial_i = $urandom(); shift_i = 1;	repeat(04) @(posedge clk_i);
		shift_i = 0; serial_i = $urandom();				repeat(06) @(posedge clk_i);
		
		// Load in
		current_test = "LOAD IN";
		parallel_i = $urandom(); load_i = 1; 			repeat(03) @(posedge clk_i);
		
		// Shift competing with load
		current_test = "SHIFT/LOAD PRIORITY";
		parallel_i = $urandom();						repeat(04) @(posedge clk_i);
		serial_i = $urandom(); shift_i = 1;     		repeat(04) @(posedge clk_i);
		for (int i = 0; i < 6; i++) begin
			shift_i = 0; serial_i = $urandom(); 
			load_i = 0;									repeat(01) @(posedge clk_i);
		end
		parallel_i = $urandom(); load_i = 1; 			repeat(04) @(posedge clk_i);
		
		// Test disable before and during shift
		current_test = "DISABLE AND SHIFT";
		en_i = 0; load_i = 0;							repeat(02) @(posedge clk_i);
		serial_i = $urandom(); shift_i = 1;     		repeat(04) @(posedge clk_i);
		for (int i = 0; i < 4; i++) begin
			en_i = 1; serial_i = $urandom();  			repeat(01) @(posedge clk_i);
		end
		en_i = 0;										repeat(04) @(posedge clk_i);
		for (int i = 0; i < 11; i++) begin
			en_i = 1; serial_i = $urandom();  			repeat(01) @(posedge clk_i);
		end
		en_i = 0; shift_i = 0;							repeat(04) @(posedge clk_i);
		en_i = 1; serial_i = $urandom();				repeat(04) @(posedge clk_i);
		
		// Test disable before and during load
		current_test = "DISABLE AND LOAD";
		en_i = 0; parallel_i = $urandom(); load_i = 1;	repeat(02) @(posedge clk_i);
		for (int i = 0; i < 1; i++) begin
			en_i = 1; parallel_i = $urandom();  	 	repeat(01) @(posedge clk_i);
		end
		en_i = 0; parallel_i = $urandom();				repeat(04) @(posedge clk_i);
		en_i = 1;										repeat(04) @(posedge clk_i);
		
		
		// Test reset
		current_test = "RESET DURING SHIFT";
		load_i = 0; shift_i = 1;						repeat(02) @(posedge clk_i);
		for (int i = 0; i < 3; i++) begin
			en_i = 1; serial_i = $urandom();  			repeat(01) @(posedge clk_i);
		end
		for (int i = 0; i < 4; i++) begin
			rst_i = 1; en_i = 1; serial_i = $urandom(); repeat(01) @(posedge clk_i);
		end
		for (int i = 0; i < 6; i++) begin
			rst_i = 0; en_i = 1; serial_i = $urandom(); repeat(01) @(posedge clk_i);
		end
		shift_i = 0;									repeat(08) @(posedge clk_i);
		
		// End the simulation.
		$stop;
	
	end // initial
	
endmodule // fifo_testbench