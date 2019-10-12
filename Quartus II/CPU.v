module CPU (clock, reset, AluResult, MuxMemToRegOut, MuxShiftSrcOut, MuxShiftAmtOut, MuxExceptionsCtrlOut, AluOp, RegAOut, RegBOut, RegPCOut, MemData, estado);

input clock;
input reset;

output wire [31:0] AluResult;
output wire [31:0] RegAOut, RegBOut, RegPCOut, MemData, MuxExceptionsCtrlOut, MuxShiftSrcOut, MuxShiftAmtOut, MuxMemToRegOut;
output wire [6:0] estado;
output wire [2:0] AluOp;

wire [31:0] SSControlOut, RegWriteOutA, RegWriteOutB, MuxPCSourceOut, RegEPCOut, RegAluOutOut,  RegMDROut, MuxIorDOut, LSControlOut, DivCtrlHIOut, MultCtrlLOOut, Mux;
wire [31:0] MuxHICtrlOut, RegHIOut, MuxLOCtrlOut, RegLOOut, RegDeslocOut, MuxAluSrcAOut, MuxAluSrcBOut, OffsetExtendidoLeft2, OffsetExtendido, LTExtendido, OffsetExtendidoLeft16;
wire [4:0] RS, RT, RD, MuxRegDstOut, RegBOutCortado, Shamt;
wire [15:0] Offset;
wire [5:0] Opcode, Funct;

wire Overflow, Negativo, Zero, EQ, GT, LT; // 1bit da ALU

// flags de controle
wire WriteCond;
wire PCWrite;
wire RegWrite;
wire Wr;
wire IRWrite;
wire WriteRegA;
wire WriteRegB;
wire AluOutControl;
wire EPCWrite;
wire ShiftSrc;
wire ShiftAmt;
wire DivCtrl;
wire MultCtrl;
wire HICtrl;
wire LOCtrl;
wire WriteHI;
wire WriteLO;
wire MDRCtrl;
wire [1:0] ExceptionsCtrl;
wire [1:0] LSControl;
wire [1:0] SSControl;
wire [1:0] AluSrcA;
wire [2:0] AluSrcB;
wire [2:0] PCSource;
wire [2:0] IorD;
wire [2:0] ShiftCtrl;
wire [2:0] RegDst;
wire [3:0] MemToReg;

assign RegBOutCortado = RegBOut[4:0];
assign OffsetExtendido = Offset;
assign OffsetExtendidoLeft2 = OffsetExtendido << 2;
assign Funct = Offset [5:0];

Registrador A(clock, reset, WriteRegA, RegWriteOutA, RegAOut);
 
Registrador B(clock, reset, WriteRegB, RegWriteOutB, RegBOut);

Registrador PC (clock, reset, PCWrite, MuxPCSourceOut, RegPCOut);

Registrador EPC (clock, reset, EPCWrite, AluResult, RegEPCOut);
 
Registrador AluOut (clock, reset, AluOutControl, AluResult, RegAluOutOut);
 
Registrador MDR(clock, reset, MDRCtrl, MemData, RegMDROut);
 
Registrador HI(clock, reset, WriteHI, MuxHICtrlOut, RegHIOut);
 
Registrador LO(clock, reset, WriteLO, MuxLOCtrlOut, RegLOOut);
 
Banco_reg banco_registradores(clock, reset, RegWrite, RS, RT, MuxRegDstOut, MuxMemToRegOut, RegWriteOutA, RegWriteOutB);
 
RegDesloc regdesloc(clock, reset, ShiftCtrl, MuxShiftAmtOut, MuxShiftSrcOut, RegDeslocOut);
 
Controle controle(clock, reset, Opcode, Funct, WriteCond,PCWrite,RegWrite,Wr,IRWrite,WriteRegA,WriteRegB,AluOutControl,EPCWrite,ShiftSrc,ShiftAmt,DivCtrl,MultCtrl,HICtrl,LOCtrl,WriteHI,WriteLO,MDRCtrl,LSControl, SSControl, ExceptionsCtrl, AluSrcA,AluSrcB,AluOp,PCSource,IorD,ShiftCtrl,RegDst,MemToReg, estado);
 
Memoria memoria(MuxIorDOut, clock, Wr, SSControlOut, MemData);
 
Instr_Reg InstructionRegisters (clock, reset, IRWrite, MemData, Opcode, RS, RT, Offset);	

ula32 Alu(MuxAluSrcAOut, MuxAluSrcBOut, AluOp, AluResult, Overflow, Negativo, Zero, EQ, GT, LT);

MuxIorD MuxIorD(RegPCOut, MuxExceptionsCtrlOut, AluResult, RegAluOutOut, RegAOut, IorD, MuxIorDOut);
 
MuxRegDst MuxRegDst(RS, RT, RD, RegDst, MuxRegDstOut);
 
MuxAluSrcA MuxAluSrcA(RegPCOut, RegBOut, RegAOut, MemData, AluSrcA, MuxAluSrcAOut);

MuxAluSrcB MuxAluSrcB(RegBOut, OffsetExtendido, LSControlOut, OffsetExtendidoLeft2, AluSrcB, MuxAluSrcBOut);

MuxPCSource MuxPCSource(RegAOut, AluResult, 1'd0, RegAluOutOut, RegEPCOut, 1'd0, PCSource, MuxPCSourceOut); //depos faï¿½o essses

MuxExceptionsCtrl MuxExceptionsCtrl(ExceptionsCtrl, MuxExceptionsCtrlOut);

MuxShiftSrc MuxShiftSrc(RegAOut, RegBOut, ShiftSrc, MuxShiftSrcOut);

MuxShiftAmt MuxShiftAmt(RegBOutCortado, Shamt, ShiftAmt, MuxShiftAmtOut);

MuxMemToReg MuxMemToReg(LTExtendido, LSControlOut, RegDeslocOut, RegHIOut, RegLOOut, RegBOut, RegAOut, RegAluOutOut, OffsetExtendidoLeft2, OffsetExtendidoLeft16, MemToReg, MuxMemToRegOut);

MuxHICtrl MuxHICtrl(DivCtrlHIOut, MultCtrlLOOut, HICtrl, MuxHICtrlOut);

MuxLOCtrl MuxLOCtrl(DivCtrlHIOut, MultCtrlLOOut, LOCtrl, MuxLOCtrlOut);

LoadSize LS(RegMDROut, LSControl, LSControlOut);

StoreSize SS(RegBOut, LSControlOut, SSControl, SSControlOut);

endmodule