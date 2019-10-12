module MuxHICtrl (
input wire[31:0] DivCtrlHIOut,
input wire[31:0] MultCtrlHIOut,
input wire HICtrl,
output reg[31:0] MuxHICtrlOut
);
parameter S0 = 0, S1 = 1;
always @(*) begin
	case(HICtrl)
		S0:
			MuxHICtrlOut <= DivCtrlHIOut;
		S1:
			MuxHICtrlOut <= MultCtrlHIOut;
	endcase
end

endmodule
