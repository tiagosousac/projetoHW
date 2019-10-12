module MuxG (
input wire[31:0] FromA,
input wire[31:0] FromB,
input wire[0:0] ShiftSrc,
output reg[31:0] toShift
);

parameter S0 = 0, S1 = 1;
always @(*) begin
	case(ShiftSrc)
		S0:
			toShift <= FromB;
		S1:
			toShift <= FromA;
	endcase
end

endmodule