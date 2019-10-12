module MuxIorD (
input wire[31:0] RegPCOut,
input wire[31:0] MuxExcepCtrlOut,
input wire[31:0] AluResult,
input wire[31:0] RegAluOutOut,
input wire[31:0] RegAOut,
input wire[2:0] IorD,
output reg[31:0] MuxIorDOut
);
parameter S0 = 0, S1 = 1, S2 = 2, S3 = 3, S4 = 4;
always @(*) begin
	case(IorD)
		S0:
			MuxIorDOut <= RegPCOut;
		S1:
			MuxIorDOut <= MuxExcepCtrlOut;
		S2:
			MuxIorDOut <= AluResult;
		S3:
			MuxIorDOut <= RegAluOutOut;
		S4:
			MuxIorDOut <= RegAOut;
	endcase
end

endmodule