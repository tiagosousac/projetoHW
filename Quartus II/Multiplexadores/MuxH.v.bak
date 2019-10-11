module MuxH (
input wire[31:0] FromB,
input wire[31:0] Imediate,
input wire[0:0] ShiftAmt,
output reg[31:0] toShift
);

always @(*) begin
	if (ShiftAmt == 1'b0) toShift <= FromB;
	if (ShiftAmt == 1'b1) toShift <= Imediate;
end

endmodule