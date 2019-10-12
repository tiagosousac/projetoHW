module MuxLOCtrl (
input wire[31:0] DivCtrlOut,
input wire[31:0] MultCtrlOut,
input wire LOCtrl,
output reg[31:0] MuxLOCtrlOut
);
parameter S0 = 0, S1 = 1;
always @(*) begin
	case(LOCtrl)
		S0:
			MuxLOCtrlOut <= DivCtrlOut;
		S1:
			MuxLOCtrlOut <= MultCtrlOut;
	endcase
end

endmodule
