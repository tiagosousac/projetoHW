module MuxExceptionsCtrl (
input wire[1:0] ExceptionsCtrl,
output reg[31:0] MuxExceptionsCtrlOut
);

parameter S0 = 0, S1 = 1, S2 = 2;
always @(*) begin
	case(ExceptionsCtrl)
		S0:
			MuxExceptionsCtrlOut <= 32'd253;
		S1:
			MuxExceptionsCtrlOut <= 32'd254;
		S2:
			MuxExceptionsCtrlOut <= 32'd255;
	endcase
end

endmodule