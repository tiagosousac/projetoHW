module LoadSize (
input wire[31:0] RegMDROut,
input wire[1:0] LSControl,
output reg[31:0] LSControlOut
);
parameter S0 = 0, S1 = 1, S2 = 2;
always @(*) begin
	case(LSControl)
		S0:
			LSControlOut <= RegMDROut;//Load Word
		S1:
			LSControlOut <= {16'd0,RegMDROut[15:0]};//Load Half
		S2:
			LSControlOut <= {24'd0,RegMDROut[7:0]};//Load Byte
	endcase
end

endmodule