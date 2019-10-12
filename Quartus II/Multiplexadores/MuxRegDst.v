module MuxRegDst (
input wire[4:0] RS,
input wire[4:0] RT,
input wire[4:0] RD, 
input wire[2:0] RegDst,
output reg[4:0] MuxRegDstOut
);
parameter S0 = 0, S1 = 1, S2 = 2, S3 = 3, S4 = 4;
always @(*) begin
	case(RegDst)
		S0:
			MuxRegDstOut <= RS;
		S1:
			MuxRegDstOut <= RT;
		S2:
			MuxRegDstOut <= 5'd29;
		S3:
			MuxRegDstOut <= 5'd31;
		S4:
			MuxRegDstOut <= RD;
	endcase
end

endmodule