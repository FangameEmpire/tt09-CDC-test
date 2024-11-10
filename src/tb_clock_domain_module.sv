// Macros
`define Receive_New_Data \
done_shifting_i <= 1; new_data_i <= 0; 							repeat(01) @(posedge clk_prev_i); \
done_shifting_i <= 0; new_data_i <= 1; data_i <= $urandom();	repeat(01) @(posedge clk_prev_i); \
for (int i = 0; i < 6; i++) \
	data_i <= $urandom(); new_data_i <= 0;						repeat(01) @(posedge clk_prev_i); \
end \
done_shifting_i = 1;											repeat(01) @(posedge clk_prev_i);

// Testbench
`timescale 1ns/10ps
module clock_domain_module_testbench();
	// System ports
	logic clk_i, rst_i, en_i, clk_prev_i, rst_prev_i;
	
	// Control ports
	logic [2:0] ctl_i;
	logic new_data_i, done_shifting_i;
	logic new_data_o, done_shifting_o;
	logic [1:0] current_state_o;
	
	// Data ports
	logic data_i;
	logic data_o;
	
	// Device under test
	clock_domain_module dut (.*);
	
	// Simulation parameters
	string current_test;
	
	// Set up simulated clocks.
	parameter CLOCK_PERIOD=100;
	initial begin
		clk_i <= 0;
		forever #(CLOCK_PERIOD/2) clk_i <= ~clk_i;
		clk_prev_i <= 0;
		forever #(CLOCK_PERIOD/3) clk_prev_i <= ~clk_prev_i;
	end
	
	// Clock domain module test
	initial begin
		// Reset
		current_test <= "RESET";
		rst_i <= 1; rst_prev_i <= 1; en_i <= 1;
		ctl_i <= 0; new_data_i <= 0; done_shifting_i <= 1; repeat(01) @(posedge clk_i);
		
		// Shift in data
		current_test <= "SHIFT IN";
		rst_i <= 0;														repeat(01) @(posedge clk_prev_i); 
		//`Receive_New_Data;
		done_shifting_i <= 1; new_data_i <= 0; 							repeat(01) @(posedge clk_prev_i); 
		done_shifting_i <= 0; new_data_i <= 1; data_i <= $urandom();	repeat(01) @(posedge clk_prev_i); 
		for (int i = 0; i < 7; i++) 
			data_i <= $urandom(); new_data_i <= 0;						repeat(01) @(posedge clk_prev_i); 
		end 
		done_shifting_i <= 1;											repeat(01) @(posedge clk_prev_i);
		
		// End the simulation.
		$stop;
	end // initial

endmodule // clock_domain_module_testbench
