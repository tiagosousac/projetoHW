module MuxShiftSrc (
input wire[31:0] RegAOut,
input wire[31:0] RegBOut,
input wire ShiftSrc,
output reg[31:0] MuxShiftSrcOut
);

parameter S0 = 0, S1 = 1;
always @(*) begin
	case(ShiftSrc)
		S0:
			MuxShiftSrcOut <= RegBOut;
		S1:
			MuxShiftSrcOut <= RegAOut;
	endcase
end

endmodule