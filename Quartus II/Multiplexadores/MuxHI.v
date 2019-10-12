module MuxHI (
input wire[31:0] FromDiv,
input wire[31:0] FromMult,
input wire[0:0] HICtrl,
output reg[31:0] toHI
);
parameter S0 = 0, S1 = 1;
always @(*) begin
	case(HICtrl)
		S0:
			toHI <= FromDiv;
		S1:
			toHI <= FromMult;
	endcase
end

endmodule
