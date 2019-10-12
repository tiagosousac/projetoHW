module MuxH (
input wire[4:0] FromB,
input wire[4:0] Shamt,
input wire[0:0] ShiftAmt,
output reg[4:0] toShift
);
parameter S0 = 0, S1 = 1;
always @(*) begin
	case(ShiftAmt)
		S0:
			toShift <= FromB;
		S1:
			toShift <= Shamt;
	endcase
end

endmodule