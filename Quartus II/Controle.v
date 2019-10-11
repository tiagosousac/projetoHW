module Controle(
input clock,
input reset,
input Div0,
input [5:0] Opcode,
input [5:0] Funct,
output reg WriteCond,
output reg PCWrite,
output reg RegWrite,
output reg Wr,
output reg IRWrite,
output reg WriteRegA,
output reg WriteRegB,
output reg AluOutControl,
output reg EPCWrite,
output reg ShiftSrc,
output reg ShiftAmt,
output reg DivCtrl,
output reg MultCtrl,
output reg HICtrl,
output reg LOCtrl,
output reg WriteHI,
output reg WriteLO,
output reg [1:0] ExceptionCtrl, 
output reg [1:0] AluSrcA,
output reg [2:0] AluSrcB,
output reg [2:0] AluOp,
output reg [2:0] PCSource,
output reg [2:0] IorD,
output reg [2:0] ShiftCtrl,
output reg [2:0] RegDst,
output reg [3:0] MemToReg
)

reg [6:0] estado;

parameter FETCH = 7'b0000000;
parameter WAITFETCH = 7'b0000001;
parameter DECODE = 7'b0000010;
parameter OPERAR = 7'b0000011;

initial begin
	estado = FETCH;
end

always @(posedge clk) begin
		if (reset) begin
			WriteCond = 1'b0;
			PCWrite = 1'b0;
			RegWrite = 1'b1;
			Wr = 1'b0;
			IRWrite = 1'b0;
			WriteRegA = 1'b0;
			WriteRegB = 1'b0;
			AluOutControl = 1'b0;
			EPCWrite = 1'b0;
			ShiftSrc = 1'b0;
			ShiftAmt = 1'b0;
			DivCtrl = 1'b0;
			MultCtrl = 1'b0;
			HICtrl = 1'b0;
			LOCtrl = 1'b0;
			WriteHI = 1'b0;
			WriteLO = 1'b0;
			ExceptionCtrl = 2'b00; 
			AluSrcA = 2'b00;
			AluSrcB = 3'b000;
			AluOp = 3'b000;
			PCSource = 3'b000;
			IorD = 3'b000;
			ShiftCtrl = 3'b000;
			RegDst = 3'b101;
			MemToReg = 4'b1011;
			estado = FETCH;
		end
		else begin
			case (estado)
				FETCH: begin
					WriteCond = 1'b0;
					PCWrite = 1'b1;
					RegWrite = 1'b0;
					Wr = 1'b0;
					IRWrite = 1'b0;
					WriteRegA = 1'b0;
					WriteRegB = 1'b0;
					AluOutControl = 1'b0;
					EPCWrite = 1'b0;
					ShiftSrc = 1'b0;
					ShiftAmt = 1'b0;
					DivCtrl = 1'b0;
					MultCtrl = 1'b0;
					HICtrl = 1'b0;
					LOCtrl = 1'b0;
					WriteHI = 1'b0;
					WriteLO = 1'b0;
					ExceptionCtrl = 2'b00; 
					AluSrcA = 2'b00;
					AluSrcB = 3'b001;
					AluOp = 3'b001;
					PCSource = 3'b001;
					IorD = 3'b000;
					ShiftCtrl = 3'b000;
					RegDst = 3'b101;
					MemToReg = 4'b000;
					estado = WAITFETCH;
					end
				WAITFETCH: begin
					WriteCond = 1'b0;
					PCWrite = 1'b0;
					RegWrite = 1'b0;
					Wr = 1'b0;
					IRWrite = 1'b1;
					WriteRegA = 1'b0;
					WriteRegB = 1'b0;
					AluOutControl = 1'b0;
					EPCWrite = 1'b0;
					ShiftSrc = 1'b0;
					ShiftAmt = 1'b0;
					DivCtrl = 1'b0;
					MultCtrl = 1'b0;
					HICtrl = 1'b0;
					LOCtrl = 1'b0;
					WriteHI = 1'b0;
					WriteLO = 1'b0;
					ExceptionCtrl = 2'b00; 
					AluSrcA = 2'b00;
					AluSrcB = 3'b000;
					AluOp = 3'b000;
					PCSource = 3'b000;
					IorD = 3'b000;
					ShiftCtrl = 3'b000;
					RegDst = 3'b000;
					MemToReg = 4'b000;
					estado = DECODE;
					end
				DECODE: begin
					WriteCond = 1'b0;
					PCWrite = 1'b0;
					RegWrite = 1'b0;
					Wr = 1'b0;
					IRWrite = 1'b1;
					WriteRegA = 1'b1;
					WriteRegB = 1'b1;
					AluOutControl = 1'b1;
					EPCWrite = 1'b0;
					ShiftSrc = 1'b0;
					ShiftAmt = 1'b0;
					DivCtrl = 1'b0;
					MultCtrl = 1'b0;
					HICtrl = 1'b0;
					LOCtrl = 1'b0;
					WriteHI = 1'b0;
					WriteLO = 1'b0;
					ExceptionCtrl = 2'b00; 
					AluSrcA = 2'b00;
					AluSrcB = 3'b100;
					AluOp = 3'b001;
					PCSource = 3'b000;
					IorD = 3'b000;
					ShiftCtrl = 3'b001;
					RegDst = 3'b000;
					MemToReg = 4'b000;
					estado = OPERAR;
				OPERAR: begin
					case(Opcode)
						
					
			

