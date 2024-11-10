module clock_domain_module(
	clk_i, rst_i, en_i, clk_prev_i, rst_prev_i, 
	ctl_i, new_data_i, done_shifting_i, new_data_o, done_shifting_o, current_state_o, 
	data_i, data_o);
	
	// System ports
	input logic clk_i, rst_i, en_i, clk_prev_i, rst_prev_i;
	
	// Control ports
	input logic [2:0] ctl_i;
	input logic new_data_i, done_shifting_i;
	output logic new_data_o, done_shifting_o;
	output logic [1:0] current_state_o;
	
	// Data ports
	input logic data_i;
	output logic data_o;
	
	// Hold data
	localparam DATA_WIDTH = 8;
	wire [DATA_WIDTH - 1:0] A, B, C;
	
	// Input SIPO FIFO and output PISO FIFO
	// Ports: (clk_i, rst_i, en_i, shift_i, load_i, data_valid_o, serial_i, serial_o, parallel_i, parallel_o)
	wire new_data_valid, send_data_out, load_data_to_send;
	fifo #(.WIDTH(DATA_WIDTH * 2)) in_shifter (
		.clk_i(clk_prev_i), .rst_i(rst_prev_i), .en_i(en_i), 
		.shift_i(new_data_i), .load_i(1'b0), .data_valid_o(new_data_valid), 
		.serial_i(data_i), .serial_o(), .parallel_i(0), .parallel_o({A, B}));
	fifo #(.WIDTH(DATA_WIDTH * 2))out_shifter (
		.clk_i(clk_i), .rst_i(rst_i), .en_i(en_i), 
		.shift_i(send_data_out), .load_i(load_data_to_send), .data_valid_o(done_shifting_o),
		.serial_i(), .serial_o(data_o), .parallel_i({B, C}), .parallel_o());
	
	// ALU
	// Ports: (en_i, ctl_i, AB_i, BC_o)
	alu #(.WIDTH(DATA_WIDTH)) main_alu (
		.en_i, .ctl_i, .A_i(A), .B_i(B), .C_o(C));
	
	// FSM
	enum {idle, shift_in, wait_for_uart, shift_out} ps, ns;
	
	always @(posedge clk_i) begin
		if (rst_i) 		ps <= idle;
		else if (~en_i) ps <= ps;
		else			ps <= ns;
	end // always @(posedge clk_i)
	
	always @(*) begin
		if (rst_i) ns = idle;
		else if (~en_i) ns = ns;
		else begin
			case (ps)
				idle: ns = new_data_i ? shift_in : idle;
				shift_in: ns = done_shifting_i ? wait_for_uart : shift_in;
				wait_for_uart: ns = shift_out;
				shift_out: ns = done_shifting_o ? idle : shift_out;
				default: ns = idle;
			endcase
		end
	end // always @(*)
	
	// Internal status
	assign load_data_to_send = (ps == wait_for_uart) & (ns == shift_out);
	assign send_data_out = (ps == shift_out);
	
	// Status outputs
	assign current_state_o = ps;
	assign new_data_o = (ps == shift_out) & (ns == idle);
	
endmodule // clock_domain_module