module CPU (clock, reset, AluResult, MuxMemToRegOut, MuxShiftSrcOut, MuxShiftAmtOut, MuxExceptionsCtrlOut, AluOp, RegAOut, RegBOut, RegPCOut, MemData, estado);

input clock;
input reset;

output reg [31:0] AluResult;
output wire [31:0] RegAOut, RegBOut, RegPCOut, MemData, MuxExceptionsCtrlOut, MuxShiftSrcOut, MuxShiftAmtOut, MuxMemToRegOut;
output wire [6:0] estado;
output wire [2:0] AluOp;

wire [31:0] SSOut, RegWriteOutA, RegWriteOutB, MuxPCSourceOut, RegEPCOut, RegAluOutOut,  RegMDROut, MuxIorDOut, LSControlOut;
wire [31:0] HICtrlOut, RegHIOut, LOCtrlOut, RegLOOut, RegDeslocOut, MuxAluSrcAOut, MuxAluSrcBOut, Extend16a32Out, OffsetExtendidoLeft2, OffsetExtendido, LTExtendido, OffsetExtendidoLeft16;
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
wire [1:0] AluSrcA;
wire [2:0] AluSrcB;
wire [2:0] PCSource;
wire [2:0] IorD;
wire [2:0] ShiftCtrl;
wire [2:0] RegDst;
wire [3:0] MemToReg;

assign RegBOutCortado = RegBOut[4:0];

Registrador A(clock, reset, WriteRegA, RegWriteOutA, RegAOut);
 
Registrador B(clock, reset, WriteRegB, RegWriteOutB, RegBOut);

Registrador PC (clock, reset, PCWrite, MuxPCSourceOut, RegPCOut);

Registrador EPC (clock, reset, EPCWrite, AluResult, RegEPCOut);
 
Registrador AluOut (clock, reset, AluOutControl, AluResult, RegAluOutOut);
 
Registrador MDR(clock, reset, MDRCtrl, MemData, RegMDROut);
 
Registrador HI(clock, reset, WriteHI, HICtrlOut, RegHIOut);
 
Registrador LO(clock, reset, WriteLO, LOCtrlOut, RegLOOut);
 
Banco_reg banco_registradores(clock, reset, RegWrite, RS, RT, MuxRegDstOut, MuxMemToRegOut, RegWriteOutA, RegWriteOutB);
 
RegDesloc regdesloc(clock, reset, ShiftCtrl, MuxShiftAmtOut, MuxShiftSrcOut, RegDeslocOut);
 
Controle controle(clock, reset, Opcode, Funct, WriteCond,PCWrite,RegWrite,Wr,IRWrite,WriteRegA,WriteRegB,AluOutControl,EPCWrite,ShiftSrc,ShiftAmt,DivCtrl,MultCtrl,HICtrl,LOCtrl,WriteHI,WriteLO,MDRCtrl,ExceptionCtrl, AluSrcA,AluSrcB,AluOp,PCSource,IorD,ShiftCtrl,RegDst,MemToReg, estado);
 
Memoria memoria(MuxIorDOut, clock, Wr, SSOut, MemData); // acho valido mudar o nome do SSOut
 
Instr_Reg InstructionRegisters (clock, reset, IRWrite, MemData, Opcode, RS, RT, Offset);	

ula32 Alu(MuxAluSrcAOut, MuxAluSrcBOut, AluOp, AluResult, Overflow, Negativo, Zero, EQ, GT, LT);

MuxIorD MuxIorD(RegPCOut, MuxExceptionsCtrlOut, AluResult, RegAluOutOut, RegAOut, IorD, MuxIorDOut);
 
MuxRegDst MuxRegDst(RS, RT, RD, RegDst, MuxRegDstOut);
 
MuxAluSrcA MuxAluSrcA(RegPCOut, RegBOut, RegAOut, MemData, AluSrcA, MuxAluSrcAOut);

MuxAluSrcB MuxAluSrcB(RegBOut, OffsetExtendido, RegMDROut, OffsetExtendidoLeft2, AluSrcB, MuxAluSrcBOut);

MuxPCSource MuxPCSource(RegAOut, AluResult, 1'd0, RegAluOutOut, RegEPCOut, 1'd0, PCSource, MuxPCSourceOut); //depos fa�o essses

MuxExceptionsCtrl MuxExceptionsCtrl(ExceptionsCtrl, MuxExceptionsCtrlOut);

MuxShiftSrc MuxShiftSrc(RegAOut, RegBOut, ShiftSrc, MuxShiftSrcOut);

MuxShiftAmt MuxShiftAmt(RegBOutCortado, Shamt, ShiftAmt, MuxShiftAmtOut);

MuxMemToReg MuxMemToReg(LTExtendido, LSControlOut, RegDeslocOut, RegHIOut, RegLOOut, RegBOut, RegAOut, RegAluOutOut, OffsetExtendidoLeft2, OffsetExtendidoLeft16, MemToReg, MuxMemToRegOut);

SE1632 SignExtend16a32(Offset, OffsetExtendido); // tentar tirar isso

ShiftLeft2 sl2(OffsetExtendido, OffsetExtendidoLeft2); // tentar tirar isso

FunctExtract functextract(Offset, Funct); // tentar tirar isso



endmodule