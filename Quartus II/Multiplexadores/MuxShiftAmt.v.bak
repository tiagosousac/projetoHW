module MuxShiftAmt (
input wire[4:0] RegBOutCortado,
input wire[4:0] Shamt,
input wire ShiftAmt,
output reg[31:0] MuxShiftAmtOut
);
parameter S0 = 0, S1 = 1;
always @(*) begin
	case(ShiftAmt)
		S0:
			MuxShiftAmtOut <= RegBOutCortado;
		S1:
			MuxShiftAmtOut <= Shamt;
	endcase
end

endmodule