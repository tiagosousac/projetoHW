module CPU (clock, reset, RegAOut, RegBOut, RegPCOut, MuxMemToRegOut, AluResult, estado, AluOp, Opcode, Funct, RegDst, EQ);

input clock;
input reset;

// aqui ficam as variaveis que desejam ser printadas, tambem precisa especificar elas no parenteses apos CPU
output wire [31:0] RegAOut, RegBOut, RegPCOut, MuxMemToRegOut, RegDeslocOut, MuxShiftSrcOut;
output wire [6:0] estado;
output wire [2:0] AluOp;
output wire [5:0] Opcode, Funct;
wire [4:0] Shamt;

// declaracao das variaveis do programa
wire [31:0] SSControlOut, RegWriteOutA, MemData, MuxPCSourceOut, RegAluOutOut, RegEPCOut,  RegMDROut, MuxIorDOut, LSControlOut, DivCtrlHIOut, MultCtrlLOOut, MuxExceptionsCtrlOut, MuxShiftSrcOut, MuxShiftAmtOut, RegDeslocOut;
wire [31:0] MuxHICtrlOut, RegHIOut, MuxLOCtrlOut, RegLOOut, MuxAluSrcAOut, MuxAluSrcBOut, OffsetExtendidoLeft2, OffsetExtendido, LTExtendido, OffsetExtendidoLeft16, JumpAddress, RegWriteOutB, ExceptionBitExtendido;
wire [4:0] RS, RT, RD, MuxRegDstOut, RegBOutCortado;
wire [15:0] Offset;
wire [5:0] Opcode, Funct;

wire Overflow, Negativo, Zero, GT, LT; // 1bit da ALU
output wire EQ;

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
wire [2:0] AluOp;
wire [2:0] PCSource;
wire [2:0] IorD;
wire [2:0] ShiftCtrl;
output wire [2:0] RegDst;
wire [3:0] MemToReg;

assign RegBOutCortado = RegBOut[4:0];
assign OffsetExtendido = Offset;
assign OffsetExtendidoLeft2 = OffsetExtendido << 2;
assign Funct = Offset[5:0];
assign Shamt = Offset[10:6];
assign RD = Offset[15:11];
assign JumpAddress = {RegPCOut[31:28], RS[4:0], RT[4:0], Offset[15:0] ,2'b0};
assign LTExtendido = {31'b0, LT};
assign ExceptionBitExtendido = {31'b0, MemData[0]};

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
 
Controle controle(clock, reset, Opcode, Funct, WriteCond, PCWrite, RegWrite, Wr, IRWrite, WriteRegA, WriteRegB,
				  AluOutControl, EPCWrite, ShiftSrc, ShiftAmt, DivCtrl, MultCtrl, HICtrl, LOCtrl, WriteHI,
				  WriteLO, MDRCtrl, Overflow, Negativo, Zero, EQ, GT, LT, LSControl, SSControl, ExceptionsCtrl,
				  AluSrcA, AluSrcB, AluOp, PCSource, IorD, ShiftCtrl, RegDst, MemToReg, estado);
 
Memoria memoria(MuxIorDOut, clock, Wr, SSControlOut, MemData);
 
Instr_Reg InstructionRegisters (clock, reset, IRWrite, MemData, Opcode, RS, RT, Offset);	

ula32 Alu(MuxAluSrcAOut, MuxAluSrcBOut, AluOp, AluResult, Overflow, Negativo, Zero, EQ, GT, LT);

MuxIorD MuxIorD(RegPCOut, MuxExceptionsCtrlOut, AluResult, RegAluOutOut, RegAOut, IorD, MuxIorDOut);
 
MuxRegDst MuxRegDst(RS, RT, RD, RegDst, MuxRegDstOut);
 
MuxAluSrcA MuxAluSrcA(RegPCOut, RegBOut, RegAOut, MemData, AluSrcA, MuxAluSrcAOut);

MuxAluSrcB MuxAluSrcB(RegBOut, OffsetExtendido, LSControlOut, OffsetExtendidoLeft2, AluSrcB, MuxAluSrcBOut);

MuxPCSource MuxPCSource(RegAOut, AluResult, JumpAddress, RegAluOutOut, RegEPCOut, ExceptionBitExtendido, PCSource, MuxPCSourceOut); //depos faï¿½o essses

MuxExceptionsCtrl MuxExceptionsCtrl(ExceptionsCtrl, MuxExceptionsCtrlOut);

MuxShiftSrc MuxShiftSrc(RegAOut, RegBOut, ShiftSrc, MuxShiftSrcOut);

MuxShiftAmt MuxShiftAmt(RegBOutCortado, Shamt, ShiftAmt, MuxShiftAmtOut);

MuxMemToReg MuxMemToReg(LTExtendido, LSControlOut, RegDeslocOut, RegHIOut, RegLOOut, RegBOut, RegAOut, RegAluOutOut, OffsetExtendidoLeft2, OffsetExtendidoLeft16, MemToReg, MuxMemToRegOut);

MuxHICtrl MuxHICtrl(DivCtrlHIOut, MultCtrlHIOut, HICtrl, MuxHICtrlOut);

MuxLOCtrl MuxLOCtrl(DivCtrlLOOut, MultCtrlLOOut, LOCtrl, MuxLOCtrlOut);

LoadSize LS(RegMDROut, LSControl, LSControlOut);

StoreSize SS(RegBOut, LSControlOut, SSControl, SSControlOut);

endmodule