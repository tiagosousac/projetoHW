module MuxAluSrcB (
input wire[31:0] RegBOut,
input wire[31:0] OffsetExtendido,
input wire[31:0] RegMDROut,
input wire[31:0] OffsetExtendidoLeft2,
input wire[2:0] AluSrcB,
output reg[31:0] MuxAluSrcBOut
);
parameter S0 = 3'b000, S1 = 3'b001, S2 = 3'b010, S3 = 3'b011, S4 = 3'b100;

always @(*) begin
	case(AluSrcB)
		S0:
			MuxAluSrcBOut <= RegBOut;
		S1:
			MuxAluSrcBOut <= 32'd4;
		S2:
			MuxAluSrcBOut <= OffsetExtendido;
		S3:
			MuxAluSrcBOut <= RegMDROut;
		S4:
			MuxAluSrcBOut <= OffsetExtendidoLeft2;
	endcase
end

endmodule