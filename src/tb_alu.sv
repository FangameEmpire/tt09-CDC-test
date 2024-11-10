// Testbench  designed for Quartus and ModelSim
`timescale 1ns/10ps
module alu_testbench();
	// Choose a width
	localparam WIDTH = 8;

	// Module ports
	logic en_i;
	logic [02:00] ctl_i;
	
	logic [WIDTH - 1:00] A_i, B_i, C_o;
	
	// Device under test
	alu dut (en_i, ctl_i, A_i, B_i, C_o);
	
	// Simulation parameters
	localparam RUNS_FIXED = 5;
	localparam RUNS_RANDOM = 20;
	localparam DELAY = 1;
	string OPCODES [8] = {"PASS 0", "PASS 1" , "PASS A", "PASS B", "ADD", "SUB", "AND", "OR"};
	string CURRENT_TEST = "RESET";
	
	// ALU tests
	initial begin
		
		// Reset case
		en_i = 0; ctl_i = 0; {A_i, B_i} = 0; #DELAY;
		
		// Test pass
		en_i = 1;
		for (int i = 0; i < 4; i++) begin
			ctl_i = i; CURRENT_TEST = OPCODES[ctl_i];
			for (int j = 0; j < RUNS_FIXED; j++) begin
				{A_i, B_i} = $urandom(); #DELAY;
			end // for j
		end // for i
		
		// Test arithmetic
		for (int i = 4; i < 6; i++) begin
			ctl_i = i; CURRENT_TEST = OPCODES[ctl_i];
			for (int j = 0; j < RUNS_FIXED; j++) begin
				{A_i, B_i} = $urandom(); #DELAY;
			end // for j
		end // for i
		
		// Test logic
		for (int i = 6; i < 8; i++) begin
			ctl_i = i; CURRENT_TEST = OPCODES[ctl_i];
			for (int j = 0; j < RUNS_FIXED; j++) begin
				{A_i, B_i} = $urandom(); #DELAY;
			end // for j
		end // for i
		
		// Test random input for random opcodes
		for (int i = 0; i < RUNS_RANDOM; i++) begin
			ctl_i = $urandom(); CURRENT_TEST = OPCODES[ctl_i];
			{A_i, B_i} = $urandom(); #DELAY;
		end // for i
		
		// Test disable
		en_i = 0;
		for (int i = 0; i < RUNS_RANDOM; i++) begin
			ctl_i = $urandom(); CURRENT_TEST = OPCODES[ctl_i];
			{A_i, B_i} = $urandom(); #DELAY;
		end // for i
		
	end // initial

endmodule // alu_testbench
