// VGA RTB Pong generator. Assumes a 1-cycle VSYNC is used for enable.
module alu #(parameter WIDTH = 8) (en_i, ctl_i, A_i, B_i, C_o);
	// Ports
	input  wire en_i;
	input  wire [02:00] ctl_i;
	
	input  wire [WIDTH - 1:00] A_i, B_i;
	output reg  [WIDTH - 1:00] C_o;
	
	// Actual ALU
	always @(*) begin
		if (~en_i) begin
			C_o = 0;
		end else begin
			case (ctl_i)
				3'b000:  C_o = 0;
				3'b001:  C_o = 1;
				3'b010:  C_o = A_i;
				3'b011:  C_o = B_i;
				3'b100:  C_o = A_i + B_i;
				3'b101:  C_o = A_i - B_i;
				3'b110:  C_o = A_i & B_i;
				3'b111:  C_o = A_i | B_i;
				default: C_o = A_i + B_i;
			endcase // ctl
		end // if (en_i)
	end // always @(*)

endmodule // alu
