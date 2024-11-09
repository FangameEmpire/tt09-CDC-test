// Testbench  designed for Quartus and ModelSim
`timescale 1ns/10ps
module alu_testbench();
	// Choose a width
	localparam WIDTH = 8;

	// Module ports
	logic en_i;
	logic [02:00] ctl_i;
	
	logic [WIDTH * 2 - 1:00] AB_i;
	logic [WIDTH * 2 - 1:00] BC_o;
	
	// Device under test
	alu dut (en_i, ctl_i, AB_i, BC_o);
	
	//  Simulation parameters
	localparam RUNS = 5;
	localparam DELAY = 1;
	string OPCODES [8] = {"PASS 0", "PASS 1" , "PASS A", "PASS B", "ADD", "SUB", "AND", "OR"};
	string CURRENT_TEST = "RESET";
	
	// ALU tests
	initial begin
		// Reset case
		en_i = 0; ctl_i = 0; AB_i = 0; #DELAY;
		
		// Test pass
		en_i = 1;
		for (int i = 0; i < 4; i++) begin
			ctl_i = i; CURRENT_TEST = OPCODES[ctl_i];
			for (int j = 0; j < RUNS; j++) begin
				AB_i = $urandom(); #DELAY;
			end // for j
		end // for i
		
		// Test arithmetic
		
		// Test logic
		
		// Test random input for random opcodes
		
		// Test disable
		
	end // initial

endmodule // alu_testbench

