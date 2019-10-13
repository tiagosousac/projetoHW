module MuxPCSource (
input wire[31:0] RegAOut,
input wire[31:0] AluResult,
input wire[31:0] JumpAddress, // valido mudar o nome depois
input wire[31:0] RegAluOutOut,
input wire[31:0] RegEPCOut,
input wire[31:0] ExceptionBit, // valido mudar o nome depois
input wire[2:0] PCSource,
output reg[31:0] MuxPCSourceOut
);
parameter S0 = 0, S1 = 1, S2 = 2, S3 = 3, S4 = 4, S5 = 5;
always @(*) begin
	case(PCSource)
		S0:
			MuxPCSourceOut <= RegAOut;
		S1:
			MuxPCSourceOut <= AluResult;
		S2:
			MuxPCSourceOut <= JumpAddress;
		S3:
			MuxPCSourceOut <= RegAluOutOut;
		S4:
			MuxPCSourceOut <= RegEPCOut;
		S5:
			MuxPCSourceOut <= ExceptionBit;
	endcase
end

endmodule