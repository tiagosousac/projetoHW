module MuxF (
input wire[1:0] ExceptionCtrl,
output reg[31:0] toMuxA
);

always @(*) begin
	if (ShiftAmt == 2'b00) toShift <= 32'b11111101;//253
	if (ShiftAmt == 2'b01) toShift <= 32'b11111110;//254
	if (ShiftAmt == 2'b10) toShift <= 32'b11111111;//255
end

endmodule