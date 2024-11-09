// VGA RTB Pong generator. Assumes a 1-cycle VSYNC is used for enable.
module alu #(parameter WIDTH = 8) (en_i, ctl_i, AB_i, BC_o);
	// Ports
	input  wire en_i;
	input  wire [02:00] ctl_i;
	
	input  wire [WIDTH * 2 - 1:00] AB_i;
	output wire [WIDTH * 2 - 1:00] BC_o;
	
	// Split inputs
	wire [WIDTH - 1:00] A, B, C;
	assign A = AB_i[WIDTH * 2 - 1:WIDTH];
	assign B = AB_i[WIDTH - 1:00];
	
	// Actual ALU
	always @(*) begin
		if (~en_i) begin
			C = 0;
		end else begin
			case (ctl) begin
				3'b000:  C = 0;
				3'b001:  C = 1;
				3'b010:  C = A;
				3'b011:  C = B;
				3'b100:  C = A + B;
				3'b101:  C = A - B;
				3'b110:  C = A & B;
				3'b111:  C = A | B;
				default: C = A + B;
			endcase // ctl
		end // if (en_i)
	end // always @(*)
	
	// Combine outputs
	assign BC_o = {B, C};

endmodule // alu
