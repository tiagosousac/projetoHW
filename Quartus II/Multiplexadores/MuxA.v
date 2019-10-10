module MuxA (
input wire[31:0] PC,
input wire[31:0] MuxF,
input wire[31:0] AluResp,
input wire[31:0] AluOutResp,
input wire[31:0] AContente,
input wire[2:0] IorD,
output reg[31:0] toMem
);

always @(*) begin
	if (IorD == 3'b000) toMem <= PC;
	if (IorD == 3'b001) toMem <= MuxF;
	if (IorD == 3'b010) toMem <= AluResp;
	if (IorD == 3'b011) toMem <= AluOutResp;
	if (IorD == 3'b100) toMem <= AContente;
end

endmodule