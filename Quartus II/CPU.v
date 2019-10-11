module CPU (clock, reset, ALUResult, MuxAOut, SSOut, MemData, MuxIOut, RegWriteOutA, RegWriteOutB, RegAOut, RegBOut, MuxEOut, RegPCOut, RegEPCOut, RegALUOutOut,  RegMDROut, HICtrlOut, RegHIOut, LOCtrlOut, RegLOOut, MuxGOut, RegDeslocOut, MuxCOut, MuxDOut, MuxFOut, Extend16a32Out, OffsetExtendidoLeft2,RS, RT, RD, MuxBOut, Offset, Opcode, MuxHOut,Funct,WriteCond,PCWrite,RegWrite,Wr,IRWrite,WriteRegA,WriteRegB,AluOutControl,EPCWrite,ShiftSrc,ShiftAmt,DivCtrl,MultCtrl,HICtrl,LOCtrl,WriteHI,WriteLO,MDRCtrl,ExceptionCtrl, AluSrcA,AluSrcB,AluOp,PCSource,IorD,ShiftCtrl,RegDst,MemToReg);

input clock;
input reset;

output reg [31:0] ALUResult;
output reg [31:0] MuxAOut, SSOut, MemData, MuxIOut, RegWriteOutA, RegWriteOutB, RegAOut, RegBOut, MuxEOut, RegPCOut, RegEPCOut, RegALUOutOut,  RegMDROut;
output reg [31:0] HICtrlOut, RegHIOut, LOCtrlOut, RegLOOut, MuxGOut, RegDeslocOut, MuxCOut, MuxDOut, MuxFOut, Extend16a32Out, OffsetExtendidoLeft2, MuxHOut;
output reg [4:0] RS, RT, RD, MuxBOut;
output reg [15:0] Offset;
output reg [5:0] Opcode, Funct;

output reg WriteCond;
output reg PCWrite;
output reg RegWrite;
output reg Wr;
output reg IRWrite;
output reg WriteRegA;
output reg WriteRegB;
output reg AluOutControl;
output reg EPCWrite;
output reg ShiftSrc;
output reg ShiftAmt;
output reg DivCtrl;
output reg MultCtrl;
output reg HICtrl;
output reg LOCtrl;
output reg WriteHI;
output reg WriteLO;
output reg MDRCtrl;
output reg [1:0] ExceptionCtrl;
output reg [1:0] AluSrcA;
output reg [2:0] AluSrcB;
output reg [2:0] AluOp;
output reg [2:0] PCSource;
output reg [2:0] IorD;
output reg [2:0] ShiftCtrl;
output reg [2:0] RegDst;
output reg [3:0] MemToReg;

Controle controle(clock, reset, Opcode, Funct, WriteCond,PCWrite,RegWrite,Wr,IRWrite,WriteRegA,WriteRegB,AluOutControl,EPCWrite,ShiftSrc,ShiftAmt,DivCtrl,MultCtrl,HICtrl,LOCtrl,WriteHI,WriteLO,MDRCtrl,ExceptionCtrl, AluSrcA,AluSrcB,AluOp,PCSource,,ShiftCtrl,RegDst,MemToReg);
Memoria memoria(MuxAOut, clock, Wr, SSOut, MemData);
Banco_reg banco_registradores(clock, reset, RegWrite, RS, RT, MuxBOut, MuxIOut, RegWriteOutA, RegWriteOutB);
Instr_Reg InstructionRegisters (clock, reset, IRWrite, MemData, Opcode, RS, RT, Offset);	
Registrador registradorA(clock, reset, WriteRegA, RegWriteOutA, RegAOut);
Registrador registradorB(clock, reset, WriteRegA, RegWriteOutB, RegBOut);
Registrador PC (clock, reset, PCWrite, MuxEOut, RegPCOut);
Registrador EPC (clock, reset, EPCWrite, ALUOut, RegEPCOut);
Registrador ALUOut (clock, reset, ALUOutControl, ALUResult, RegALUOutOut);
Registrador MDR(clock, reset, MDRCtrl, MemData, RegMDROut);
Registrador HI(clock, reset, WriteHI, HICtrlOut, RegHIOut);
Registrador LO(clock, reset, WriteLO, LOCtrlOut, RegLOOut);
RegDesloc regdesloc(clock, reset, ShiftCtrl, MuxHOut, MuxGOut, RegDeslocOut);
ula32 ALU(MuxCOut, MuxDOut, ALUOp, ALUResult, Overflow, Negativo, Zero, EQ, GT, LT);
MuxA MuxA(RegPCOut, MuxFOut, ALUResult, RegALUOutOut, RegAOut, IorD, MuxAOut);
MuxB MuxB(RS, RT, RD, RegDst, MuxBOut);
MuxC MuxC(RegPCOut, RegBOut, RegAOut, MemData, ALUSrcA, MuxCOut);
MuxD MuxD(RegBOut, Extend16a32Out, RegMDROut, OffsetExtendidoLeft2, ALUSrcB, MuxDOut);
MuxE MuxE(RegAOut, ALUResult, 1'd0, RegALUOutOut, RegEPCOut, 1'd0); //depos faço essses
SE1632 SignExtend16a32(Offset, OffsetExtendido);
ShiftLeft2 sl2(OffsetExtendido, OffsetExtendidoLeft2);


always @ (posedge clock) begin
    assign Funct = Offset[5:0];
	assign MuxIOut = 1'd0;
	assign MuxFOut = 1'd0;
	assign MuxGOut = 1'd0;
	assign MuxHOut = 1'd0;
end  

endmodule