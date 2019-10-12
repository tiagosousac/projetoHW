module MuxLOCtrl (
input wire[31:0] DivCtrlLOOut,
input wire[31:0] MultCtrlLOOut,
input wire LOCtrl,
output reg[31:0] MuxLOCtrlOut
);
parameter S0 = 0, S1 = 1;
always @(*) begin
	case(LOCtrl)
		S0:
			MuxLOCtrlOut <= DivCtrlLOOut;
		S1:
			MuxLOCtrlOut <= MultCtrlLOOut;
	endcase
end

endmodule
