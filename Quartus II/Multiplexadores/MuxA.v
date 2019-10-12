module MuxA (
input wire[31:0] PC,
input wire[31:0] MuxF,
input wire[31:0] AluResp,
input wire[31:0] AluOutResp,
input wire[31:0] AContente,
input wire[2:0] IorD,
output reg[31:0] MuxIorDOut
);
parameter S0 = 0, S1 = 1, S2 = 2, S3 = 3, S4 = 4;
always @(*) begin
	case(IorD)
		S0:
			MuxIorDOut <= PC;
		S1:
			MuxIorDOut <= MuxF;
		S2:
			MuxIorDOut <= AluResp;
		S3:
			MuxIorDOut <= AluOutResp;
		S4:
			MuxIorDOut <= AContente;
	endcase
end

endmodule