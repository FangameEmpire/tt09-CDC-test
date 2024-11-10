module fifo #(parameter WIDTH = 8) (clk_i, rst_i, en_i, shift_i, load_i, data_valid_o, serial_i, serial_o, parallel_i, parallel_o);
	// Ports
	input  wire clk_i, rst_i, en_i;
	input  wire shift_i, load_i;
	output wire data_valid_o;
	
	input  wire serial_i;
	output wire serial_o;
	input  wire [WIDTH - 1:0] parallel_i;
	output wire [WIDTH - 1:0] parallel_o;
	
	// Shift register and hold register
	reg [WIDTH - 1:0] sr, hr;
	
	// Count bits shifted in this shift operation
	reg [$clog2(WIDTH) - 1:0] bits_shifted;
	
	// Control registers
	always @(posedge clk_i) begin
		if (rst_i) begin
			sr <= 0;
			hr <= 0;
			bits_shifted <= 0;
		end else if (~en_i) begin
			sr <= sr;
			hr <= hr;
			bits_shifted <= bits_shifted;
		end else begin
			if (bits_shifted != 0) begin
				sr <= {serial_i, sr[WIDTH - 1:1]};
				if (bits_shifted == WIDTH - 1) hr <= {serial_i, sr[WIDTH - 1:1]};
				else hr <= hr;
				bits_shifted <= bits_shifted + 1;
			end else if (shift_i) begin
				sr <= {serial_i, sr[WIDTH - 1:1]};
				hr <= sr;
				bits_shifted <= bits_shifted + 1;
			end else if (load_i) begin
				sr <= parallel_i;
				hr <= parallel_i;
				bits_shifted <= 0;
			end else begin
				sr <= sr;
				hr <= sr;
				bits_shifted <= 0;
			end
		end
	end // always @(posedge clk)
	
	// Outputs
	assign data_valid_o = (bits_shifted == 0);
	assign parallel_o = hr;
	assign serial_o = sr[0];

endmodule // fifo