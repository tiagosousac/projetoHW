module SL32 (
input wire[31:0] ExOffset,
output reg[31:0] ToMuxD
);

always @(*) begin
	ToMuxD <= {ExOffset[29:0],2'b00};
end

endmodule
