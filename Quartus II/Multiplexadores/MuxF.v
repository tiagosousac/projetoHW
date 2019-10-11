module MuxF (
input wire[1:0] ExceptionCtrl,
output reg[31:0] toMuxA
);

parameter S0 = 0, S1 = 1, S2 = 2;
always @(*) begin
	case(ExceptionCtrl)
		S0:
			toMuxA <= 32'd253;
		S1:
			toMuxA <= 32'd254;
		S2:
			toMuxA <= 32'd255;
	endcase
end

endmodule