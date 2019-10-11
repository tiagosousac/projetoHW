module ShiftLeft2(
input wire [31:0] A,
output reg [31:0] ALeft2
);

always @(*) begin
	ALeft2 <= A << 2;
end

endmodule
