module MuxD (
input wire[31:0] FromB,
input wire[31:0] FromImmediate,
input wire[31:0] FromMDR,
input wire[31:0] FromImmediate2,
input wire[2:0] ALUSrcB,
output reg[31:0] toALU
);
parameter S0 = 3'b000, S1 = 3'b001, S2 = 3'b010, S3 = 3'b011, S4 = 3'b100;

always @(*) begin
	case(ALUSrcB)
		S0:
			toALU <= FromB;
		S1:
			toALU <= 32'd4;
		S2:
			toALU <= FromImmediate;
		S3:
			toALU <= FromMDR;
		S4:
			toALU <= FromImmediate2;
	endcase
end

endmodule