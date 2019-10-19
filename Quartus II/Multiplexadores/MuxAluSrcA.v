module MuxAluSrcA (
input wire[31:0] RegPCOut,
input wire[31:0] RegBOut,
input wire[31:0] RegAOut,
input wire[31:0] RegMDROut,
input wire[1:0] AluSrcA,
output reg[31:0] MuxAluSrcAOut
);
parameter S0 = 0, S1 = 1, S2 = 2, S3 = 3;
always @(*) begin
	case(AluSrcA)
		S0:
			MuxAluSrcAOut <= RegPCOut;
		S1:
			MuxAluSrcAOut <= RegBOut;
		S2:
			MuxAluSrcAOut <= RegAOut;
		S3:
			MuxAluSrcAOut <= RegMDROut;
	endcase
end

endmodule