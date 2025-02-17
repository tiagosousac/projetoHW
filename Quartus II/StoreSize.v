module StoreSize (
input wire[31:0] RegBOut,
input wire[31:0] RegMDROut,
input wire[1:0] SSControl,
output reg[31:0] SSControlOut
);
parameter S0 = 0, S1 = 1, S2 = 2;
always @(*) begin
	case(SSControl)
		S0:
			SSControlOut <= RegBOut;//Store Word
		S1:
			SSControlOut <= {RegMDROut[31:16],RegBOut[15:0]};//Store Half
		S2:
			SSControlOut <= {RegMDROut[31:8],RegBOut[7:0]};//Store Byte
	endcase
end

endmodule
