module MuxI (
input wire[31:0] FromLT,
input wire[31:0] FromLoad,
input wire[31:0] FromMDR,
input wire[31:0] FromShift,
input wire[31:0] FromHI,
input wire[31:0] FromLO,
input wire[31:0] FromB,
input wire[31:0] FromA,
input wire[31:0] FromALUOut,
input wire[31:0] FromAdress2,
input wire[31:0] FromSL16,
input wire[3:0] MemToReg,
output reg[31:0] toWriteD
);
parameter S0 = 0, S1 = 1, S2 = 2, S3 = 3, S4 = 4, S5 = 5, S6 = 6, S7 = 7, S8 = 8, S9 = 9, S10 = 10, S11 = 11;
always @(*) begin
	case(MemToReg)
		S0:
			toWriteD <= FromLT;
		S1:
			toWriteD <= FromLoad;
		S2:
			toWriteD <= FromMDR;
		S3:
			toWriteD <= FromShift;
		S4:
			toWriteD <= FromHI;
		S5:
			toWriteD <= FromLO;
		S6:
			toWriteD <= FromB;
		S7:
			toWriteD <= FromA;
		S8:
			toWriteD <= FromALUOut;
		S9:
			toWriteD <= FromAdress2;
		S10:
			toWriteD <= FromSL16;
		S11:
			toWriteD <= 32'd227;
	endcase
end

endmodule