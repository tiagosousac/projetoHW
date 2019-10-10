module MuxG (
input wire[31:0] FromA,
input wire[31:0] FromB,
input wire[0:0] ShiftSrc,
output reg[31:0] toShift
);

always @(*) begin
	if (ShiftSrc == 1'b0) toShift <= FromB;
	if (ShiftSrc == 1'b1) toShift <= FromA;
end

endmodule