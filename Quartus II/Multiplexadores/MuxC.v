module MuxC (
input wire[31:0] FromPC,
input wire[31:0] FromB,
input wire[31:0] FromA,
input wire[31:0] FromMem,
input wire[1:0] ALUSrcA,
output reg[31:0] toALU
);
parameter S0 = 0, S1 = 1, S2 = 2, S3 = 3;
always @(*) begin
	case(ALUSrcA)
		S0:
			toALU <= FromPC;
		S1:
			toALU <= FromB;
		S2:
			toALU <= FromA;
		S3:
			toALU <= FromMem;
	endcase
end

endmodule