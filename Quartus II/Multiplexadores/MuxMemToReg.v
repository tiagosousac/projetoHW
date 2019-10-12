module MuxMemToReg (
input wire[31:0] FromLT, // se pa mudar o nome depois
input wire[31:0] FromLoad,
input wire[31:0] RegDeslocOut,
input wire[31:0] RegHIOut,
input wire[31:0] RegLOOut,
input wire[31:0] RegBOut,
input wire[31:0] RegAOut,
input wire[31:0] RegAluOutOut,
input wire[31:0] OffsetExtendidoLeft2, // se pa mudar o nome depois
input wire[31:0] OffsetExtendidoLeft16,
input wire[3:0] MemToReg,
output reg[31:0] MuxMemToRegOut
);
parameter S0 = 0, S1 = 1, S2 = 2, S3 = 3, S4 = 4, S5 = 5, S6 = 6, S7 = 7, S8 = 8, S9 = 9, S10 = 10;
always @(*) begin
	case(MemToReg)
		S0:
			MuxMemToRegOut <= FromLT;
		S1:
			MuxMemToRegOut <= FromLoad;
		S2:
			MuxMemToRegOut <= 32'd227;
		S3:
			MuxMemToRegOut <= RegDeslocOut;
		S4:
			MuxMemToRegOut <= RegHIOut;
		S5:
			MuxMemToRegOut <= RegLOOut;
		S6:
			MuxMemToRegOut <= RegBOut;
		S7:
			MuxMemToRegOut <= RegAOut;
		S8:
			MuxMemToRegOut <= RegAluOutOut;
		S9:
			MuxMemToRegOut <= OffsetExtendidoLeft2;
		S10:
			MuxMemToRegOut <= OffsetExtendidoLeft16;
	endcase
end

endmodule