module MuxHICtrl (
input wire[31:0] DivCtrlOut,
input wire[31:0] MultCtrlOut,
input wire HICtrl,
output reg[31:0] MuxHICtrlOut
);
parameter S0 = 0, S1 = 1;
always @(*) begin
	case(HICtrl)
		S0:
			MuxHICtrlOut <= DivCtrlOut;
		S1:
			MuxHICtrlOut <= MultCtrlOut;
	endcase
end

endmodule
