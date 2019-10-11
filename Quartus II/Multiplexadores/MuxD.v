module MuxD (
input wire[31:0] FromB,
input wire[31:0] FromImmediate,
input wire[31:0] FromMDR,
input wire[31:0] FromImmediate2,
input wire[2:0] ALUSrcB,
output reg[31:0] toALU
);
parameter S0 = 0, S1 = 1, S2 = 2, S3 = 3, S4 = 4;
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