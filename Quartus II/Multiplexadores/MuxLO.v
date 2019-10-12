module MuxLO (
input wire[31:0] FromDiv,
input wire[31:0] FromMult,
input wire[0:0] LOCtrl,
output reg[31:0] toLO
);
parameter S0 = 0, S1 = 1;
always @(*) begin
	case(LOCtrl)
		S0:
			toLO <= FromDiv;
		S1:
			toLO <= FromMult;
	endcase
end

endmodule
