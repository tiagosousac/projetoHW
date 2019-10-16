module Controle(
input clock,
input reset,
input wire [5:0] Opcode,
input wire [5:0] Funct,
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
output reg MDRCtrl,
output reg Overflow,
output reg Negativo,
output reg Zero,
output reg EQ,
output reg GT,
output reg LT, 
output reg [1:0] LSControl,
output reg [1:0] SSControl,
output reg [1:0] ExceptionCtrl, 
output reg [1:0] AluSrcA,
output reg [2:0] AluSrcB,
output reg [2:0] AluOp,
output reg [2:0] PCSource,
output reg [2:0] IorD,
output reg [2:0] ShiftCtrl,
output reg [2:0] RegDst,
output reg [3:0] MemToReg,
output reg [6:0] estado
);


// parameters dos estados
parameter FETCH = 7'b0000000;
parameter WAITFETCH = 7'b0000001;
parameter WAITFETCH2 = 7'b0000010;
parameter DECODE = 7'b0000011;
parameter OPERAR = 7'b0000100;
parameter ADDIxClk2 = 7'b0000101;
parameter ADD_SUB_ANDClk2 = 7'b0000110;
parameter SHIFTOperationClk2 = 7'b0000111;
parameter XCHGClk2 = 7'b0001000;
parameter BLMClk2 = 7'b0001001;
parameter BLMClk3 = 7'b0001010;
parameter SLTIClk2 = 7'b0001011;
parameter JALClk2 = 7'b0001100;
parameter SLTClk2 = 7'b0001101;
parameter LBClk2 = 7'b0001110;
parameter LBClk3 = 7'b0001111;
parameter LHClk2 = 7'b0010000;
parameter LHClk3 = 7'b0010001;
parameter LWClk2 = 7'b0010010;
parameter LWClk3 = 7'b0010011;
parameter SBClk2 = 7'b0010100;
parameter SBClk3 = 7'b0010101;
parameter SHClk2 = 7'b0010110;
parameter SHClk3 = 7'b0010111;
parameter SWClk2 = 7'b0011000;
parameter SWClk3 = 7'b0011001;
parameter WAIT = 7'b1111111;

// parameters do Opcode
parameter RINSTRUCTION = 6'b000000;
parameter ADDI = 6'b001000;
parameter ADDIU = 6'b001001;
parameter BEQ = 6'b000100;
parameter BNE = 6'b000101;
parameter BLE = 6'b000110;
parameter BGT = 6'b000111;
parameter BLM = 6'b000001;
parameter LB = 6'b100000;
parameter LH = 6'b100001;
parameter LUI = 6'b001111;
parameter LW = 6'b100011;
parameter SB = 6'b101000;
parameter SH = 6'b101001;
parameter SLTI = 6'b001010;
parameter SW = 6'b101011;
parameter J = 6'b000010;
parameter JAL = 6'b000011;

// parameters do Funct
parameter ADD = 6'b100000;
parameter AND = 6'b100100;
parameter DIV = 6'b011010;
parameter MULT = 6'b011000;
parameter JR = 6'b001000;
parameter MFHI = 6'b010000;
parameter MFLO = 6'b010010;
parameter SLL = 6'b000000;
parameter SLLV = 6'b000100;
parameter SLT = 6'b101010;
parameter SRA = 6'b000011;
parameter SRAV = 6'b000111;
parameter SRL = 6'b000010;
parameter SUB = 6'b100010;
parameter BREAK = 6'b001101;
parameter RTE = 6'b010011;
parameter XCHG = 6'b000101;


initial begin
	estado = FETCH;
end

always @(posedge clock) begin
		if (reset) begin
			//Alteradas
                RegDst = 3'b011;
                MemToReg = 4'b0010;
                RegWrite = 1'b1;
            //Inalteradas                
                PCSource = 3'b000;
                PCWrite = 1'b0;
                WriteCond = 1'b0;
                IorD = 3'b000;
                Wr = 1'b0;
                IRWrite = 1'b0;
                WriteRegA = 1'b0;
                WriteRegB = 1'b0;
                AluSrcA = 2'b00;
                AluSrcB = 3'b000;
                AluOp = 3'b000;
                AluOutControl = 1'b0;
                MDRCtrl = 1'b0;
                LSControl = 2'b00;
                SSControl = 2'b00;
                ExceptionCtrl = 2'b00;
                WriteHI = 1'b0;
                WriteLO = 1'b0;
                HICtrl = 1'b0;
                LOCtrl = 1'b0;
                DivCtrl = 1'b0;
                MultCtrl = 1'b0;
                ShiftSrc = 1'b0;
                ShiftAmt = 1'b0;
                ShiftCtrl = 3'b000;
                EPCWrite = 1'b0;
                estado = FETCH;
		end			
		else begin
			case (estado)
				FETCH: begin
				//Alteradas
					PCSource = 3'b001;
                    PCWrite = 1'b1;
                    IorD = 3'b000;
                    Wr = 1'b0;
                    AluSrcA = 2'b00;
					AluSrcB = 3'b001;
                    AluOp = 3'b001;
				//Inalteradas
					WriteCond = 1'b0;
					IRWrite = 1'b0;
					WriteRegA = 1'b0;
					WriteRegB = 1'b0;
					AluOutControl = 1'b0;
					RegDst = 3'b000;
					MemToReg = 4'b0000;
					RegWrite = 1'b0;
					MDRCtrl = 1'b0;
					LSControl = 2'b00;
					SSControl = 2'b00;
					ExceptionCtrl = 2'b00;
					WriteHI = 1'b0;
					WriteLO = 1'b0;
					HICtrl = 1'b0;
					LOCtrl = 1'b0;
					DivCtrl = 1'b0;
					MultCtrl = 1'b0;
					ShiftSrc = 1'b0;
					ShiftAmt = 1'b0;
					ShiftCtrl = 3'b000;
					EPCWrite = 1'b0;
					estado = WAITFETCH;
					end
				WAITFETCH: begin
					//Alteradas
                        //Nada, rs
					//Inalteradas        
					    PCSource = 3'b000;
					    PCWrite = 1'b0;
					    WriteCond = 1'b0;
					    IorD = 3'b000;
					    Wr = 1'b0;
					    IRWrite = 1'b0;
					    WriteRegA = 1'b0;
					    WriteRegB = 1'b0;
					    AluSrcA = 2'b00;
					    AluSrcB = 3'b000;
					    AluOp = 3'b000;
					    AluOutControl = 1'b0;
					    RegDst = 3'b000;
					    MemToReg = 4'b0000;
					    RegWrite = 1'b0;
					    MDRCtrl = 1'b0;
					    LSControl = 2'b00;
					    SSControl = 2'b00;
					    ExceptionCtrl = 2'b00;
					    WriteHI = 1'b0;
					    WriteLO = 1'b0;
					    HICtrl = 1'b0;
					    LOCtrl = 1'b0;
					    DivCtrl = 1'b0;
					    MultCtrl = 1'b0;
					    ShiftSrc = 1'b0;
					    ShiftAmt = 1'b0;
					    ShiftCtrl = 3'b000;
					    EPCWrite = 1'b0;
					    estado = WAITFETCH2;
					end
					
					WAITFETCH2: begin
					//Alteradas
                        IRWrite = 1'b1;
					//Inalteradas           
					    PCSource = 3'b000;
					    PCWrite = 1'b0;
					    WriteCond = 1'b0;
					    IorD = 3'b000;
					    Wr = 1'b0;
					    WriteRegA = 1'b0;
					    WriteRegB = 1'b0;
					    AluSrcA = 2'b00;
					    AluSrcB = 3'b000;
					    AluOp = 3'b000;
					    AluOutControl = 1'b0;
					    RegDst = 3'b000;
					    MemToReg = 4'b0000;
					    RegWrite = 1'b0;
					    MDRCtrl = 1'b0;
					    LSControl = 2'b00;
					    SSControl = 2'b00;
					    ExceptionCtrl = 2'b00;
					    WriteHI = 1'b0;
					    WriteLO = 1'b0;
					    HICtrl = 1'b0;
					    LOCtrl = 1'b0;
					    DivCtrl = 1'b0;
					    MultCtrl = 1'b0;
					    ShiftSrc = 1'b0;
					    ShiftAmt = 1'b0;
					    ShiftCtrl = 3'b000;
					    EPCWrite = 1'b0;
					    estado = DECODE;
					end
				DECODE: begin
					//Alteradas
                        WriteRegA = 1'b1;
					    WriteRegB = 1'b1;
					    AluSrcA = 2'b00;
					    AluSrcB = 3'b100;
                        AluOp = 3'b001;
                        AluOutControl = 1'b1;	
                        ShiftCtrl = 3'b001;
                        ShiftSrc = 1'b0;
					//Inalteradas
					    PCSource = 3'b000;
					    PCWrite = 1'b0;
					    WriteCond = 1'b0;
					    IorD = 3'b000;
					    Wr = 1'b0;
					    IRWrite = 1'b0;
					    RegDst = 3'b000;
					    MemToReg = 4'b0000;
					    RegWrite = 1'b0;
					    MDRCtrl = 1'b0;
					    LSControl = 2'b00;
					    SSControl = 2'b00;
					    ExceptionCtrl = 2'b00;
					    WriteHI = 1'b0;
					    WriteLO = 1'b0;
					    HICtrl = 1'b0;
					    LOCtrl = 1'b0;
					    DivCtrl = 1'b0;
					    MultCtrl = 1'b0;
					    ShiftAmt = 1'b0;
					    EPCWrite = 1'b0;
					    estado = OPERAR;
					end
				OPERAR: begin
					case(Opcode)
						ADDI: begin
							//Alteradas
								AluSrcA = 2'b10;
								AluSrcB = 3'b010;
								AluOutControl = 1'b1;
								AluOp = 3'b001;	
							//Inalteradas
								PCSource = 3'b000;
                                PCWrite = 1'b0;
                                WriteCond = 1'b0;
                                IorD = 3'b000;
                                Wr = 1'b0;
                                IRWrite = 1'b0;
                                WriteRegA = 1'b0;
                                WriteRegB = 1'b0;
								RegDst = 3'b000;
                                MemToReg = 4'b0000;
                                RegWrite = 1'b0;
                                MDRCtrl = 1'b0;
                                LSControl = 2'b00;
                                SSControl = 2'b00;
                                ExceptionCtrl = 2'b00;
                                WriteHI = 1'b0;
                                WriteLO = 1'b0;
                                HICtrl = 1'b0;
                                LOCtrl = 1'b0;
                                DivCtrl = 1'b0;
                                MultCtrl = 1'b0;
                                ShiftSrc = 1'b0;
                                ShiftAmt = 1'b0;
                                ShiftCtrl = 3'b000;
                                EPCWrite = 1'b0;
								estado = ADDIxClk2;
							end

						ADDIU: begin
                            //Alteradas
                                AluSrcA = 2'b10;
					        	AluSrcB = 3'b010;
                                AluOutControl = 1'b1;
                                AluOp = 3'b001;
					        //Inalteradas
					            PCSource = 3'b000;
					            PCWrite = 1'b0;
					            WriteCond = 1'b0;
					            IorD = 3'b000;
					            Wr = 1'b0;
					            IRWrite = 1'b0;
					            WriteRegA = 1'b0;
					            WriteRegB = 1'b0;
					            RegDst = 3'b000;
					            MemToReg = 4'b0000;
					            RegWrite = 1'b0;
					            MDRCtrl = 1'b0;
					            LSControl = 2'b00;
					            SSControl = 2'b00;
					            ExceptionCtrl = 2'b00;
					            WriteHI = 1'b0;
					            WriteLO = 1'b0;
					            HICtrl = 1'b0;
					            LOCtrl = 1'b0;
					            DivCtrl = 1'b0;
					            MultCtrl = 1'b0;
					            ShiftSrc = 1'b0;
					            ShiftAmt = 1'b0;
					            ShiftCtrl = 3'b000;
					            EPCWrite = 1'b0;
					            estado = ADDIxClk2;
							end
						BEQ: begin
							//Alteradas
								PCSource = 3'b011;
								AluSrcA = 2'b10;
								AluSrcB = 3'b000;
								AluOp = 3'b111;
								if(EQ == 1) begin
									PCWrite = 1'b1;
								end
							//Inalteradas 
								WriteCond = 1'b0;
								IorD = 3'b000;
								Wr = 1'b0;
								IRWrite = 1'b0;
								WriteRegA = 1'b0;
								WriteRegB = 1'b0;
								AluOutControl = 1'b0;
								RegDst = 3'b000;
								MemToReg = 4'b0000;
								RegWrite = 1'b0;
								MDRCtrl = 1'b0;
								LSControl = 2'b00;
								SSControl = 2'b00;
								ExceptionCtrl = 2'b00;
								WriteHI = 1'b0;
								WriteLO = 1'b0;
								HICtrl = 1'b0;
								LOCtrl = 1'b0;
								DivCtrl = 1'b0;
								MultCtrl = 1'b0;
								ShiftSrc = 1'b0;
								ShiftAmt = 1'b0;
								ShiftCtrl = 3'b000;
								EPCWrite = 1'b0;
								estado = WAIT;
							end
						BNE: begin
							//Alteradas
								PCSource = 3'b011;
								AluSrcA = 2'b10;
								AluSrcB = 3'b000;
								AluOp = 3'b111;
								if(EQ == 0) begin
									PCWrite = 1'b1;
								end
							//Inalteradas 
								WriteCond = 1'b0;
								IorD = 3'b000;
								Wr = 1'b0;
								IRWrite = 1'b0;
								WriteRegA = 1'b0;
								WriteRegB = 1'b0;
								AluOutControl = 1'b0;
								RegDst = 3'b000;
								MemToReg = 4'b0000;
								RegWrite = 1'b0;
								MDRCtrl = 1'b0;
								LSControl = 2'b00;
								SSControl = 2'b00;
								ExceptionCtrl = 2'b00;
								WriteHI = 1'b0;
								WriteLO = 1'b0;
								HICtrl = 1'b0;
								LOCtrl = 1'b0;
								DivCtrl = 1'b0;
								MultCtrl = 1'b0;
								ShiftSrc = 1'b0;
								ShiftAmt = 1'b0;
								ShiftCtrl = 3'b000;
								EPCWrite = 1'b0;
								estado = WAIT;
							end
						BLE: begin
							//Alteradas
								PCSource = 3'b011;
								AluSrcA = 2'b10;
								AluSrcB = 3'b000;
								AluOp = 3'b111;
								if(GT == 0) begin
									PCWrite = 1'b1;
								end
							//Inalteradas 
								WriteCond = 1'b0;
								IorD = 3'b000;
								Wr = 1'b0;
								IRWrite = 1'b0;
								WriteRegA = 1'b0;
								WriteRegB = 1'b0;
								AluOutControl = 1'b0;
								RegDst = 3'b000;
								MemToReg = 4'b0000;
								RegWrite = 1'b0;
								MDRCtrl = 1'b0;
								LSControl = 2'b00;
								SSControl = 2'b00;
								ExceptionCtrl = 2'b00;
								WriteHI = 1'b0;
								WriteLO = 1'b0;
								HICtrl = 1'b0;
								LOCtrl = 1'b0;
								DivCtrl = 1'b0;
								MultCtrl = 1'b0;
								ShiftSrc = 1'b0;
								ShiftAmt = 1'b0;
								ShiftCtrl = 3'b000;
								EPCWrite = 1'b0;
								estado = WAIT;
							end
						BGT: begin
							//Alteradas
								PCSource = 3'b011;
								AluSrcA = 2'b10;
								AluSrcB = 3'b000;
								AluOp = 3'b111;
								if(GT == 1) begin
									PCWrite = 1'b1;
								end
							//Inalteradas 
								WriteCond = 1'b0;
								IorD = 3'b000;
								Wr = 1'b0;
								IRWrite = 1'b0;
								WriteRegA = 1'b0;
								WriteRegB = 1'b0;
								AluOutControl = 1'b0;
								RegDst = 3'b000;
								MemToReg = 4'b0000;
								RegWrite = 1'b0;
								MDRCtrl = 1'b0;
								LSControl = 2'b00;
								SSControl = 2'b00;
								ExceptionCtrl = 2'b00;
								WriteHI = 1'b0;
								WriteLO = 1'b0;
								HICtrl = 1'b0;
								LOCtrl = 1'b0;
								DivCtrl = 1'b0;
								MultCtrl = 1'b0;
								ShiftSrc = 1'b0;
								ShiftAmt = 1'b0;
								ShiftCtrl = 3'b000;
								EPCWrite = 1'b0;
								estado = WAIT;
							end
						BLM: begin
								//Alteradas
								IorD = 3'b100;
								Wr = 1'b0;
								//Inalteradas        
								PCSource = 3'b000;
								PCWrite = 1'b0;
								WriteCond = 1'b0;
								IRWrite = 1'b0;
								WriteRegA = 1'b0;
								WriteRegB = 1'b0;
								AluSrcA = 2'b00;
								AluSrcB = 3'b000;
								AluOp = 3'b000;
								AluOutControl = 1'b0;
								RegDst = 3'b000;
								MemToReg = 4'b0000;
								RegWrite = 1'b0;
								MDRCtrl = 1'b0;
								LSControl = 2'b00;
								SSControl = 2'b00;
								ExceptionCtrl = 2'b00;
								WriteHI = 1'b0;
								WriteLO = 1'b0;
								HICtrl = 1'b0;
								LOCtrl = 1'b0;
								DivCtrl = 1'b0;
								MultCtrl = 1'b0;
								ShiftSrc = 1'b0;
								ShiftAmt = 1'b0;
								ShiftCtrl = 3'b000;
								EPCWrite = 1'b0;
								estado = BLMClk2;
							end
						LW: begin
							//Alteradas
								AluOutControl = 1'b1;
								AluSrcA = 2'b10;
								AluSrcB = 3'b010;
								AluOp = 3'b001;
								IorD = 3'b011;
								Wr = 1'b0;
							//Inalteradas        
								PCSource = 3'b000;
								PCWrite = 1'b0;
								WriteCond = 1'b0;
								IRWrite = 1'b0;
								WriteRegA = 1'b0;
								WriteRegB = 1'b0;
								RegDst = 3'b000;
								MemToReg = 4'b0000;
								RegWrite = 1'b0;
								MDRCtrl = 1'b0;
								LSControl = 2'b00;
								SSControl = 2'b00;
								ExceptionCtrl = 2'b00;
								WriteHI = 1'b0;
								WriteLO = 1'b0;
								HICtrl = 1'b0;
								LOCtrl = 1'b0;
								DivCtrl = 1'b0;
								MultCtrl = 1'b0;
								ShiftSrc = 1'b0;
								ShiftAmt = 1'b0;
								ShiftCtrl = 3'b000;
								EPCWrite = 1'b0;
								estado = LWClk2;
							end
						LH: begin
							//Alteradas
								AluOutControl = 1'b1;
								AluSrcA = 2'b10;
								AluSrcB = 3'b010;
								AluOp = 3'b001;
								IorD = 3'b011;
								Wr = 1'b0;
							//Inalteradas        
								PCSource = 3'b000;
								PCWrite = 1'b0;
								WriteCond = 1'b0;
								IRWrite = 1'b0;
								WriteRegA = 1'b0;
								WriteRegB = 1'b0;
								RegDst = 3'b000;
								MemToReg = 4'b0000;
								RegWrite = 1'b0;
								MDRCtrl = 1'b0;
								LSControl = 2'b00;
								SSControl = 2'b00;
								ExceptionCtrl = 2'b00;
								WriteHI = 1'b0;
								WriteLO = 1'b0;
								HICtrl = 1'b0;
								LOCtrl = 1'b0;
								DivCtrl = 1'b0;
								MultCtrl = 1'b0;
								ShiftSrc = 1'b0;
								ShiftAmt = 1'b0;
								ShiftCtrl = 3'b000;
								EPCWrite = 1'b0;
								estado = LHClk2;
							end
						LB: begin
							//Alteradas
								AluOutControl = 1'b1;
								AluSrcA = 2'b10;
								AluSrcB = 3'b010;
								AluOp = 3'b001;
								IorD = 3'b011;
								Wr = 1'b0;
							//Inalteradas        
								PCSource = 3'b000;
								PCWrite = 1'b0;
								WriteCond = 1'b0;
								IRWrite = 1'b0;
								WriteRegA = 1'b0;
								WriteRegB = 1'b0;
								RegDst = 3'b000;
								MemToReg = 4'b0000;
								RegWrite = 1'b0;
								MDRCtrl = 1'b0;
								LSControl = 2'b00;
								SSControl = 2'b00;
								ExceptionCtrl = 2'b00;
								WriteHI = 1'b0;
								WriteLO = 1'b0;
								HICtrl = 1'b0;
								LOCtrl = 1'b0;
								DivCtrl = 1'b0;
								MultCtrl = 1'b0;
								ShiftSrc = 1'b0;
								ShiftAmt = 1'b0;
								ShiftCtrl = 3'b000;
								EPCWrite = 1'b0;
								estado = LBClk2;
							end
						SW: begin
							//Alteradas
								AluOutControl = 1'b1;
								AluSrcA = 2'b10;
								AluSrcB = 3'b010;
								AluOp = 3'b001;
								IorD = 3'b011;
								Wr = 1'b0;
							//Inalteradas        
								PCSource = 3'b000;
								PCWrite = 1'b0;
								WriteCond = 1'b0;
								IRWrite = 1'b0;
								WriteRegA = 1'b0;
								WriteRegB = 1'b0;
								RegDst = 3'b000;
								MemToReg = 4'b0000;
								RegWrite = 1'b0;
								MDRCtrl = 1'b0;
								LSControl = 2'b00;
								SSControl = 2'b00;
								ExceptionCtrl = 2'b00;
								WriteHI = 1'b0;
								WriteLO = 1'b0;
								HICtrl = 1'b0;
								LOCtrl = 1'b0;
								DivCtrl = 1'b0;
								MultCtrl = 1'b0;
								ShiftSrc = 1'b0;
								ShiftAmt = 1'b0;
								ShiftCtrl = 3'b000;
								EPCWrite = 1'b0;
								estado = SWClk2;
							end
						SH: begin
							//Alteradas
								AluSrcA = 2'b10;
								AluSrcB = 3'b010;
								AluOp = 3'b001;
								AluOutControl = 1'b1;
								IorD = 3'b011;
								Wr = 1'b0;
							//Inalteradas        
								PCSource = 3'b000;
								PCWrite = 1'b0;
								WriteCond = 1'b0;
								IRWrite = 1'b0;
								WriteRegA = 1'b0;
								WriteRegB = 1'b0;
								RegDst = 3'b000;
								MemToReg = 4'b0000;
								RegWrite = 1'b0;
								MDRCtrl = 1'b0;
								LSControl = 2'b00;
								SSControl = 2'b00;
								ExceptionCtrl = 2'b00;
								WriteHI = 1'b0;
								WriteLO = 1'b0;
								HICtrl = 1'b0;
								LOCtrl = 1'b0;
								DivCtrl = 1'b0;
								MultCtrl = 1'b0;
								ShiftSrc = 1'b0;
								ShiftAmt = 1'b0;
								ShiftCtrl = 3'b000;
								EPCWrite = 1'b0;
								estado = SHClk2;
							end
						SB: begin
							//Alteradas
								AluSrcA = 2'b10;
								AluSrcB = 3'b010;
								AluOp = 3'b001;
								AluOutControl = 1'b1;
								IorD = 3'b011;
								Wr = 1'b0;
							//Inalteradas        
								PCSource = 3'b000;
								PCWrite = 1'b0;
								WriteCond = 1'b0;
								IRWrite = 1'b0;
								WriteRegA = 1'b0;
								WriteRegB = 1'b0;
								RegDst = 3'b000;
								MemToReg = 4'b0000;
								RegWrite = 1'b0;
								MDRCtrl = 1'b0;
								LSControl = 2'b00;
								SSControl = 2'b00;
								ExceptionCtrl = 2'b00;
								WriteHI = 1'b0;
								WriteLO = 1'b0;
								HICtrl = 1'b0;
								LOCtrl = 1'b0;
								DivCtrl = 1'b0;
								MultCtrl = 1'b0;
								ShiftSrc = 1'b0;
								ShiftAmt = 1'b0;
								ShiftCtrl = 3'b000;
								EPCWrite = 1'b0;
								estado = SBClk2;
							end
						LUI: begin
							//Alteradas
								RegDst = 3'b001;
								MemToReg = 4'b1010;
								RegWrite = 1'b1;
							//Inalteradas
								PCSource = 3'b000;
								PCWrite = 1'b0;
								WriteCond = 1'b0;
								IorD = 3'b000;
								Wr = 1'b0;
								IRWrite = 1'b0;
								WriteRegA = 1'b0;
								WriteRegB = 1'b0;
								AluSrcA = 2'b00;
								AluSrcB = 3'b000;
								AluOp = 3'b000;
								AluOutControl = 1'b0;
								MDRCtrl = 1'b0;
								LSControl = 2'b00;
								SSControl = 2'b00;
								ExceptionCtrl = 2'b00;
								WriteHI = 1'b0;
								WriteLO = 1'b0;
								HICtrl = 1'b0;
								LOCtrl = 1'b0;
								DivCtrl = 1'b0;
								MultCtrl = 1'b0;
								ShiftSrc = 1'b0;
								ShiftAmt = 1'b0;
								ShiftCtrl = 3'b000;
								EPCWrite = 1'b0;
								estado = WAIT;
							end
						SLTI: begin
							//Alteradas
								AluSrcA = 2'b10;
								AluSrcB = 3'b010;
								AluOp = 3'b111;
							//Inalteradas        
								PCSource = 3'b000;
								PCWrite = 1'b0;
								WriteCond = 1'b0;
								IorD = 3'b000;
								Wr = 1'b0;
								IRWrite = 1'b0;
								WriteRegA = 1'b0;
								WriteRegB = 1'b0;
								AluOutControl = 1'b0;
								RegDst = 3'b000;
								MemToReg = 4'b0000;
								RegWrite = 1'b0;
								MDRCtrl = 1'b0;
								LSControl = 2'b00;
								SSControl = 2'b00;
								ExceptionCtrl = 2'b00;
								WriteHI = 1'b0;
								WriteLO = 1'b0;
								HICtrl = 1'b0;
								LOCtrl = 1'b0;
								DivCtrl = 1'b0;
								MultCtrl = 1'b0;
								ShiftSrc = 1'b0;
								ShiftAmt = 1'b0;
								ShiftCtrl = 3'b000;
								EPCWrite = 1'b0;
								estado = SLTIClk2;
							end
						J: begin
							//Alteradas
								PCSource = 3'b010;
								PCWrite = 1'b1;
							//Inalteradas
								WriteCond = 1'b0;
								IorD = 3'b000;
								Wr = 1'b0;
								IRWrite = 1'b0;
								WriteRegA = 1'b0;
								WriteRegB = 1'b0;
								AluSrcA = 2'b00;
								AluSrcB = 3'b000;
								AluOp = 3'b000;
								AluOutControl = 1'b0;
								RegDst = 3'b000;
								MemToReg = 4'b0000;
								RegWrite = 1'b0;
								MDRCtrl = 1'b0;
								LSControl = 2'b00;
								SSControl = 2'b00;
								ExceptionCtrl = 2'b00;
								WriteHI = 1'b0;
								WriteLO = 1'b0;
								HICtrl = 1'b0;
								LOCtrl = 1'b0;
								DivCtrl = 1'b0;
								MultCtrl = 1'b0;
								ShiftSrc = 1'b0;
								ShiftAmt = 1'b0;
								ShiftCtrl = 3'b000;
								EPCWrite = 1'b0;
								estado = WAIT;
							end
						JAL: begin
							//Alteradas
				                AluSrcA = 2'b00;
				                AluOp = 3'b000;
				                AluOutControl = 1'b1;      
								PCSource = 3'b010;
								PCWrite = 1'b1;
							//Inalteradas
								WriteCond = 1'b0;
								IorD = 3'b000;
								Wr = 1'b0;
								IRWrite = 1'b0;
								WriteRegA = 1'b0;
								WriteRegB = 1'b0;
								AluSrcB = 3'b000;
								RegDst = 3'b000;
								MemToReg = 4'b0000;
								RegWrite = 1'b0;
								MDRCtrl = 1'b0;
								LSControl = 2'b00;
								SSControl = 2'b00;
								ExceptionCtrl = 2'b00;
								WriteHI = 1'b0;
								WriteLO = 1'b0;
								HICtrl = 1'b0;
								LOCtrl = 1'b0;
								DivCtrl = 1'b0;
								MultCtrl = 1'b0;
								ShiftSrc = 1'b0;
								ShiftAmt = 1'b0;
								ShiftCtrl = 3'b000;
								EPCWrite = 1'b0;
								estado = JALClk2;
							end
						RINSTRUCTION: begin
							case(Funct)
								ADD: begin
									//Alteradas
										AluSrcA = 2'b10;
										AluSrcB = 3'b000;
										AluOp = 3'b001;
										AluOutControl = 1'b1;
									//Inalteradas
										PCSource = 3'b000;
										PCWrite = 1'b0;
										WriteCond = 1'b0;
										IorD = 3'b000;
										Wr = 1'b0;
										IRWrite = 1'b0;
										WriteRegA = 1'b0;
										WriteRegB = 1'b0;                               
										RegDst = 3'b000;
										MemToReg = 4'b0000;
										RegWrite = 1'b0;
										MDRCtrl = 1'b0;
										LSControl = 2'b00;
										SSControl = 2'b00;
										ExceptionCtrl = 2'b00;
										WriteHI = 1'b0;
										WriteLO = 1'b0;
										HICtrl = 1'b0;
										LOCtrl = 1'b0;
										DivCtrl = 1'b0;
										MultCtrl = 1'b0;
										ShiftSrc = 1'b0;
										ShiftAmt = 1'b0;
										ShiftCtrl = 3'b000;
										EPCWrite = 1'b0;
										estado = ADD_SUB_ANDClk2;
									end
								AND: begin
									//Alteradas
										AluSrcA = 2'b10;
										AluSrcB = 3'b000;
										AluOp = 3'b011;
										AluOutControl = 1'b1;
									//Inalteradas		
										PCSource = 3'b000;
										PCWrite = 1'b0;
										WriteCond = 1'b0;
										IorD = 3'b000;
										Wr = 1'b0;
										IRWrite = 1'b0;
										WriteRegA = 1'b0;
										WriteRegB = 1'b0;
										RegDst = 3'b000;
										MemToReg = 4'b0000;
										RegWrite = 1'b0;
										MDRCtrl = 1'b0;
										LSControl = 2'b00;
										SSControl = 2'b00;
										ExceptionCtrl = 2'b00;
										WriteHI = 1'b0;
										WriteLO = 1'b0;
										HICtrl = 1'b0;
										LOCtrl = 1'b0;
										DivCtrl = 1'b0;
										MultCtrl = 1'b0;
										ShiftSrc = 1'b0;
										ShiftAmt = 1'b0;
										ShiftCtrl = 3'b000;
										EPCWrite = 1'b0;
										estado = ADD_SUB_ANDClk2;
									end
								SUB: begin
									//Alteradas
										AluSrcA = 2'b10;
										AluSrcB = 3'b000;
										AluOp = 3'b010;
										AluOutControl = 1'b1;
									//Inalteradas		
										PCSource = 3'b000;
										PCWrite = 1'b0;
										WriteCond = 1'b0;
										IorD = 3'b000;
										Wr = 1'b0;
										IRWrite = 1'b0;
										WriteRegA = 1'b0;
										WriteRegB = 1'b0;
										RegDst = 3'b000;
										MemToReg = 4'b0000;
										RegWrite = 1'b0;
										MDRCtrl = 1'b0;
										LSControl = 2'b00;
										SSControl = 2'b00;
										ExceptionCtrl = 2'b00;
										WriteHI = 1'b0;
										WriteLO = 1'b0;
										HICtrl = 1'b0;
										LOCtrl = 1'b0;
										DivCtrl = 1'b0;
										MultCtrl = 1'b0;
										ShiftSrc = 1'b0;
										ShiftAmt = 1'b0;
										ShiftCtrl = 3'b000;
										EPCWrite = 1'b0;
										estado = ADD_SUB_ANDClk2;
									end
								DIV: begin
									end
								MULT: begin
									end
								MFHI: begin
									//Alteradas
										RegDst = 3'b010;
										MemToReg = 4'b0100;
										RegWrite = 1'b1;
									//Inalteradas        
										PCSource = 3'b000;
										PCWrite = 1'b0;
										WriteCond = 1'b0;
										IorD = 3'b000;
										Wr = 1'b0;
										IRWrite = 1'b0;
										WriteRegA = 1'b0;
										WriteRegB = 1'b0;
										AluSrcA = 2'b00;
										AluSrcB = 3'b000;
										AluOp = 3'b000;
										AluOutControl = 1'b0;
										MDRCtrl = 1'b0;
										LSControl = 2'b00;
										SSControl = 2'b00;
										ExceptionCtrl = 2'b00;
										WriteHI = 1'b0;
										WriteLO = 1'b0;
										HICtrl = 1'b0;
										LOCtrl = 1'b0;
										DivCtrl = 1'b0;
										MultCtrl = 1'b0;
										ShiftSrc = 1'b0;
										ShiftAmt = 1'b0;
										ShiftCtrl = 3'b000;
										EPCWrite = 1'b0;
										estado = WAIT;
									end
								MFLO: begin
									//Alteradas
										RegDst = 3'b010;
										MemToReg = 4'b0101;
										RegWrite = 1'b1;
									//Inalteradas        
										PCSource = 3'b000;
										PCWrite = 1'b0;
										WriteCond = 1'b0;
										IorD = 3'b000;
										Wr = 1'b0;
										IRWrite = 1'b0;
										WriteRegA = 1'b0;
										WriteRegB = 1'b0;
										AluSrcA = 2'b00;
										AluSrcB = 3'b000;
										AluOp = 3'b000;
										AluOutControl = 1'b0;
										MDRCtrl = 1'b0;
										LSControl = 2'b00;
										SSControl = 2'b00;
										ExceptionCtrl = 2'b00;
										WriteHI = 1'b0;
										WriteLO = 1'b0;
										HICtrl = 1'b0;
										LOCtrl = 1'b0;
										DivCtrl = 1'b0;
										MultCtrl = 1'b0;
										ShiftSrc = 1'b0;
										ShiftAmt = 1'b0;
										ShiftCtrl = 3'b000;
										EPCWrite = 1'b0;
										estado = WAIT;
									end
								SLL: begin
									//Alteradas
										ShiftSrc = 1'b0;
										ShiftAmt = 1'b1;
										ShiftCtrl = 3'b010;
									//Inalteradas        
										PCSource = 3'b000;
										PCWrite = 1'b0;
										WriteCond = 1'b0;
										IorD = 3'b000;
										Wr = 1'b0;
										IRWrite = 1'b0;
										WriteRegA = 1'b0;
										WriteRegB = 1'b0;
										AluSrcA = 2'b00;
										AluSrcB = 3'b000;
										AluOp = 3'b000;
										AluOutControl = 1'b0;
										RegDst = 3'b000;
										MemToReg = 4'b0000;
										RegWrite = 1'b0;
										MDRCtrl = 1'b0;
										LSControl = 2'b00;
										SSControl = 2'b00;
										ExceptionCtrl = 2'b00;
										WriteHI = 1'b0;
										WriteLO = 1'b0;
										HICtrl = 1'b0;
										LOCtrl = 1'b0;
										DivCtrl = 1'b0;
										MultCtrl = 1'b0;
										EPCWrite = 1'b0;
										estado = SHIFTOperationClk2;
									end
								SLLV: begin
									//Alteradas
										ShiftSrc = 1'b1;
										ShiftAmt = 1'b0;
										ShiftCtrl = 3'b010;
									//Inalteradas        
										PCSource = 3'b000;
										PCWrite = 1'b0;
										WriteCond = 1'b0;
										IorD = 3'b000;
										Wr = 1'b0;
										IRWrite = 1'b0;
										WriteRegA = 1'b0;
										WriteRegB = 1'b0;
										AluSrcA = 2'b00;
										AluSrcB = 3'b000;
										AluOp = 3'b000;
										AluOutControl = 1'b0;
										RegDst = 3'b000;
										MemToReg = 4'b0000;
										RegWrite = 1'b0;
										MDRCtrl = 1'b0;
										LSControl = 2'b00;
										SSControl = 2'b00;
										ExceptionCtrl = 2'b00;
										WriteHI = 1'b0;
										WriteLO = 1'b0;
										HICtrl = 1'b0;
										LOCtrl = 1'b0;
										DivCtrl = 1'b0;
										MultCtrl = 1'b0;
										EPCWrite = 1'b0;
										estado = SHIFTOperationClk2;
									end
								SRL: begin
									//Alteradas
										ShiftSrc = 1'b0;
										ShiftAmt = 1'b1;
										ShiftCtrl = 3'b011;
									//Inalteradas
										PCSource = 3'b000;
										PCWrite = 1'b0;
										WriteCond = 1'b0;
										IorD = 3'b000;
										Wr = 1'b0;
										IRWrite = 1'b0;
										WriteRegA = 1'b0;
										WriteRegB = 1'b0;
										AluSrcA = 2'b00;
										AluSrcB = 3'b000;
										AluOp = 3'b000;
										AluOutControl = 1'b0;
										RegDst = 3'b000;
										MemToReg = 4'b0000;
										RegWrite = 1'b0;
										MDRCtrl = 1'b0;
										LSControl = 2'b00;
										SSControl = 2'b00;
										ExceptionCtrl = 2'b00;
										WriteHI = 1'b0;
										WriteLO = 1'b0;
										HICtrl = 1'b0;
										LOCtrl = 1'b0;
										DivCtrl = 1'b0;
										MultCtrl = 1'b0;
										EPCWrite = 1'b0;
										estado = SHIFTOperationClk2;
									end
								SRA: begin
									//Alteradas
										ShiftSrc = 1'b0;
										ShiftAmt = 1'b1;
										ShiftCtrl = 3'b100;
									//Inalteradas
										PCSource = 3'b000;
										PCWrite = 1'b0;
										WriteCond = 1'b0;
										IorD = 3'b000;
										Wr = 1'b0;
										IRWrite = 1'b0;
										WriteRegA = 1'b0;
										WriteRegB = 1'b0;
										AluSrcA = 2'b00;
										AluSrcB = 3'b000;
										AluOp = 3'b000;
										AluOutControl = 1'b0;
										RegDst = 3'b000;
										MemToReg = 4'b0000;
										RegWrite = 1'b0;
										MDRCtrl = 1'b0;
										LSControl = 2'b00;
										SSControl = 2'b00;
										ExceptionCtrl = 2'b00;
										WriteHI = 1'b0;
										WriteLO = 1'b0;
										HICtrl = 1'b0;
										LOCtrl = 1'b0;
										DivCtrl = 1'b0;
										MultCtrl = 1'b0;
										EPCWrite = 1'b0;
										estado = SHIFTOperationClk2;
									end
								SRAV: begin
									//Alteradas
										ShiftSrc = 1'b1;
										ShiftAmt = 1'b0;
										ShiftCtrl = 3'b100;
									//Inalteradas
										PCSource = 3'b000;
										PCWrite = 1'b0;
										WriteCond = 1'b0;
										IorD = 3'b000;
										Wr = 1'b0;
										IRWrite = 1'b0;
										WriteRegA = 1'b0;
										WriteRegB = 1'b0;
										AluSrcA = 2'b00;
										AluSrcB = 3'b000;
										AluOp = 3'b000;
										AluOutControl = 1'b0;
										RegDst = 3'b000;
										MemToReg = 4'b0000;
										RegWrite = 1'b0;
										MDRCtrl = 1'b0;
										LSControl = 2'b00;
										SSControl = 2'b00;
										ExceptionCtrl = 2'b00;
										WriteHI = 1'b0;
										WriteLO = 1'b0;
										HICtrl = 1'b0;
										LOCtrl = 1'b0;
										DivCtrl = 1'b0;
										MultCtrl = 1'b0;
										EPCWrite = 1'b0;
										estado = SHIFTOperationClk2;
									end
								SLT: begin
									//Alteradas
				                        AluSrcA = 2'b10;
										AluSrcB = 3'b000;
										AluOp = 3'b111;
									//Inalteradas        
										PCSource = 3'b000;
										PCWrite = 1'b0;
										WriteCond = 1'b0;
										IorD = 3'b000;
										Wr = 1'b0;
										IRWrite = 1'b0;
										WriteRegA = 1'b0;
										WriteRegB = 1'b0;
										AluOutControl = 1'b0;
										RegDst = 3'b000;
										MemToReg = 4'b0000;
										RegWrite = 1'b0;
										MDRCtrl = 1'b0;
										LSControl = 2'b00;
										SSControl = 2'b00;
										ExceptionCtrl = 2'b00;
										WriteHI = 1'b0;
										WriteLO = 1'b0;
										HICtrl = 1'b0;
										LOCtrl = 1'b0;
										DivCtrl = 1'b0;
										MultCtrl = 1'b0;
										ShiftSrc = 1'b0;
										ShiftAmt = 1'b0;
										ShiftCtrl = 3'b000;
										EPCWrite = 1'b0;
										estado = SLTClk2;
									end
								JR: begin
									//Alteradas
										PCSource = 3'b001;
										PCWrite = 1'b1;
										AluSrcA = 2'b10;
										AluSrcB = 3'b000;
										AluOp = 3'b000;
									//Inalteradas
										WriteCond = 1'b0;
										IorD = 3'b000;
										Wr = 1'b0;
										IRWrite = 1'b0;
										WriteRegA = 1'b0;
										WriteRegB = 1'b0;
										AluOutControl = 1'b0;
										RegDst = 3'b000;
										MemToReg = 4'b0000;
										RegWrite = 1'b0;
										MDRCtrl = 1'b0;
										LSControl = 2'b00;
										SSControl = 2'b00;
										ExceptionCtrl = 2'b00;
										WriteHI = 1'b0;
										WriteLO = 1'b0;
										HICtrl = 1'b0;
										LOCtrl = 1'b0;
										DivCtrl = 1'b0;
										MultCtrl = 1'b0;
										ShiftSrc = 1'b0;
										ShiftAmt = 1'b0;
										ShiftCtrl = 3'b000;
										EPCWrite = 1'b0;
										estado = WAIT;
									end
								RTE: begin
									//Alteradas
										PCSource = 3'b100;
										PCWrite = 1'b1;
									//Inalteradas
										WriteCond = 1'b0;
										IorD = 3'b000;
										Wr = 1'b0;
										IRWrite = 1'b0;
										WriteRegA = 1'b0;
										WriteRegB = 1'b0;
										AluSrcA = 2'b00;
										AluSrcB = 3'b000;
										AluOp = 3'b000;
										AluOutControl = 1'b0;
										RegDst = 3'b000;
										MemToReg = 4'b0000;
										RegWrite = 1'b0;
										MDRCtrl = 1'b0;
										LSControl = 2'b00;
										SSControl = 2'b00;
										ExceptionCtrl = 2'b00;
										WriteHI = 1'b0;
										WriteLO = 1'b0;
										HICtrl = 1'b0;
										LOCtrl = 1'b0;
										DivCtrl = 1'b0;
										MultCtrl = 1'b0;
										ShiftSrc = 1'b0;
										ShiftAmt = 1'b0;
										ShiftCtrl = 3'b000;
										EPCWrite = 1'b0;
										estado = WAIT;
									end
								XCHG: begin
									//Alteradas
										WriteRegA = 1'b0;
										WriteRegB = 1'b0;
										RegDst = 3'b000;
										MemToReg = 4'b0110;
										RegWrite = 1'b1;
									//Inalteradas
										PCSource = 3'b000;
										PCWrite = 1'b0;
										WriteCond = 1'b0;
										IorD = 3'b000;
										Wr = 1'b0;
										IRWrite = 1'b0;
										AluSrcA = 2'b00;
										AluSrcB = 3'b000;
										AluOp = 3'b000;
										AluOutControl = 1'b0;
										MDRCtrl = 1'b0;
										LSControl = 2'b00;
										SSControl = 2'b00;
										ExceptionCtrl = 2'b00;
										WriteHI = 1'b0;
										WriteLO = 1'b0;
										HICtrl = 1'b0;
										LOCtrl = 1'b0;
										DivCtrl = 1'b0;
										MultCtrl = 1'b0;
										ShiftSrc = 1'b0;
										ShiftAmt = 1'b0;
										ShiftCtrl = 3'b000;
										EPCWrite = 1'b0;
										estado = XCHGClk2;
									end
								BREAK: begin
                                    //Alteradas
                                        PCWrite = 1'b1;
                                        AluSrcB = 3'b0001;
                                        AluOp = 3'b010;
									    PCSource = 3'b001;
					                //Inalteradas
					                    WriteCond = 1'b0;
					                    IorD = 3'b000;
					                    Wr = 1'b0;
					                    IRWrite = 1'b0;
					                    WriteRegA = 1'b0;
					                    WriteRegB = 1'b0;
					                    AluSrcA = 2'b00;
					                    AluOutControl = 1'b0;
					                    RegDst = 3'b000;
					                    MemToReg = 4'b0000;
					                    RegWrite = 1'b0;
					                    MDRCtrl = 1'b0;
					                    LSControl = 2'b00;
					                    SSControl = 2'b00;
					                    ExceptionCtrl = 2'b00;
					                    WriteHI = 1'b0;
					                    WriteLO = 1'b0;
					                    HICtrl = 1'b0;
					                    LOCtrl = 1'b0;
					                    DivCtrl = 1'b0;
					                    MultCtrl = 1'b0;
					                    ShiftSrc = 1'b0;
					                    ShiftAmt = 1'b0;
					                    ShiftCtrl = 3'b000;
					                    EPCWrite = 1'b0;
					                    estado = FETCH;
									end
							endcase
						end
					endcase
				end

				ADDIxClk2: begin
                    //Alteradas
                        RegDst = 3'b001;
                        RegWrite = 1'b1;
                        MemToReg = 4'b1000;
					//Inalteradas
					    PCSource = 3'b000;
					    PCWrite = 1'b0;
					    WriteCond = 1'b0;
					    IorD = 3'b000;
					    Wr = 1'b0;
					    IRWrite = 1'b0;
					    WriteRegA = 1'b0;
					    WriteRegB = 1'b0;
					    AluSrcA = 2'b00;
					    AluSrcB = 3'b000;
					    AluOp = 3'b000;
					    AluOutControl = 1'b0;
					    MDRCtrl = 1'b0;
					    LSControl = 2'b00;
					    SSControl = 2'b00;
					    ExceptionCtrl = 2'b00;
					    WriteHI = 1'b0;
					    WriteLO = 1'b0;
					    HICtrl = 1'b0;
					    LOCtrl = 1'b0;
					    DivCtrl = 1'b0;
					    MultCtrl = 1'b0;
					    ShiftSrc = 1'b0;
					    ShiftAmt = 1'b0;
					    ShiftCtrl = 3'b000;
					    EPCWrite = 1'b0;
					    estado = WAIT;
					end
				ADD_SUB_ANDClk2: begin //pode copiar para sub e and
					//Alteradas
						RegDst = 3'b010; 
						MemToReg = 4'b1000;
						RegWrite = 1'b1;
					//Inalteradas
						PCSource = 3'b000;
						PCWrite = 1'b0;
						WriteCond = 1'b0;
						IorD = 3'b000;
						Wr = 1'b0;
						IRWrite = 1'b0;
						WriteRegA = 1'b0;
						WriteRegB = 1'b0;
						AluSrcA = 2'b00;
						AluSrcB = 3'b000;
						AluOp = 3'b000;
						AluOutControl = 1'b0;
						MDRCtrl = 1'b0;
						LSControl = 2'b00;
						SSControl = 2'b00;
						ExceptionCtrl = 2'b00;
						WriteHI = 1'b0;
						WriteLO = 1'b0;
						HICtrl = 1'b0;
						LOCtrl = 1'b0;
						DivCtrl = 1'b0;
						MultCtrl = 1'b0;
						ShiftSrc = 1'b0;
						ShiftAmt = 1'b0;
						ShiftCtrl = 3'b000;
						EPCWrite = 1'b0;
						estado = WAIT;
					end
					
				SHIFTOperationClk2:begin
					//Alteradas
						RegDst = 3'b010;
						MemToReg = 4'b0011;
						RegWrite = 1'b1;
					//Inalteradas
						PCSource = 3'b000;
						PCWrite = 1'b0;
						WriteCond = 1'b0;
						IorD = 3'b000;
						Wr = 1'b0;
						IRWrite = 1'b0;
						WriteRegA = 1'b0;
						WriteRegB = 1'b0;
						AluSrcA = 2'b00;
						AluSrcB = 3'b000;
						AluOp = 3'b000;
						AluOutControl = 1'b0;
						MDRCtrl = 1'b0;
						LSControl = 2'b00;
						SSControl = 2'b00;
						ExceptionCtrl = 2'b00;
						WriteHI = 1'b0;
						WriteLO = 1'b0;
						HICtrl = 1'b0;
						LOCtrl = 1'b0;
						DivCtrl = 1'b0;
						MultCtrl = 1'b0;
						ShiftSrc = 1'b0;
						ShiftAmt = 1'b0;
						ShiftCtrl = 3'b000;
						EPCWrite = 1'b0;
						estado = WAIT;
					end
				
				XCHGClk2: begin
					//Alteradas
						RegDst = 3'b001;
						MemToReg = 4'b0111;
						RegWrite = 1'b1;
					//Inalteradas
						PCSource = 3'b000;
						PCWrite = 1'b0;
						WriteCond = 1'b0;
						IorD = 3'b000;
						Wr = 1'b0;
						IRWrite = 1'b0;
						WriteRegA = 1'b0;
						WriteRegB = 1'b0;
						AluSrcA = 2'b00;
						AluSrcB = 3'b000;
						AluOp = 3'b000;
						AluOutControl = 1'b0;
						MDRCtrl = 1'b0;
						LSControl = 2'b00;
						SSControl = 2'b00;
						ExceptionCtrl = 2'b00;
						WriteHI = 1'b0;
						WriteLO = 1'b0;
						HICtrl = 1'b0;
						LOCtrl = 1'b0;
						DivCtrl = 1'b0;
						MultCtrl = 1'b0;
						ShiftSrc = 1'b0;
						ShiftAmt = 1'b0;
						ShiftCtrl = 3'b000;
						EPCWrite = 1'b0;
						estado = WAIT;
					end
				BLMClk2: begin
					//Alteradas
                        //Wait Clock
					//Inalteradas        
					    PCSource = 3'b000;
					    PCWrite = 1'b0;
					    WriteCond = 1'b0;
					    IorD = 3'b000;
					    Wr = 1'b0;
					    IRWrite = 1'b0;
					    WriteRegA = 1'b0;
					    WriteRegB = 1'b0;
					    AluSrcA = 2'b00;
					    AluSrcB = 3'b000;
					    AluOp = 3'b000;
					    AluOutControl = 1'b0;
					    RegDst = 3'b000;
					    MemToReg = 4'b0000;
					    RegWrite = 1'b0;
					    MDRCtrl = 1'b0;
					    LSControl = 2'b00;
					    SSControl = 2'b00;
					    ExceptionCtrl = 2'b00;
					    WriteHI = 1'b0;
					    WriteLO = 1'b0;
					    HICtrl = 1'b0;
					    LOCtrl = 1'b0;
					    DivCtrl = 1'b0;
					    MultCtrl = 1'b0;
					    ShiftSrc = 1'b0;
					    ShiftAmt = 1'b0;
					    ShiftCtrl = 3'b000;
					    EPCWrite = 1'b0;
					    estado = BLMClk3;
					end
				BLMClk3: begin
					//Alteradas
						PCSource = 3'b011;
						AluSrcA = 2'b11;
					    AluSrcB = 3'b000;
					    AluOp = 3'b111;
					    if(LT == 1) begin
							PCWrite = 1'b1;
						end
					//Inalteradas
					    WriteCond = 1'b0;
					    IorD = 3'b000;
					    Wr = 1'b0;
					    IRWrite = 1'b0;
					    WriteRegA = 1'b0;
					    WriteRegB = 1'b0;
					    AluOutControl = 1'b0;
					    RegDst = 3'b000;
					    MemToReg = 4'b0000;
					    RegWrite = 1'b0;
					    MDRCtrl = 1'b0;
					    LSControl = 2'b00;
					    SSControl = 2'b00;
					    ExceptionCtrl = 2'b00;
					    WriteHI = 1'b0;
					    WriteLO = 1'b0;
					    HICtrl = 1'b0;
					    LOCtrl = 1'b0;
					    DivCtrl = 1'b0;
					    MultCtrl = 1'b0;
					    ShiftSrc = 1'b0;
					    ShiftAmt = 1'b0;
					    ShiftCtrl = 3'b000;
					    EPCWrite = 1'b0;
					    estado = WAIT;
					end
				SLTIClk2: begin
					//Alteradas
						RegDst = 3'b001;
						MemToReg = 4'b0000;
						RegWrite = 1'b1;
					//Inalteradas        
						PCSource = 3'b000;
						PCWrite = 1'b0;
						WriteCond = 1'b0;
						IorD = 3'b000;
						Wr = 1'b0;
						IRWrite = 1'b0;
						WriteRegA = 1'b0;
						WriteRegB = 1'b0;
						AluSrcA = 2'b00;
						AluSrcB = 3'b000;
						AluOp = 3'b000;
						AluOutControl = 1'b0;
						MDRCtrl = 1'b0;
						LSControl = 2'b00;
						SSControl = 2'b00;
						ExceptionCtrl = 2'b00;
						WriteHI = 1'b0;
						WriteLO = 1'b0;
						HICtrl = 1'b0;
						LOCtrl = 1'b0;
						DivCtrl = 1'b0;
						MultCtrl = 1'b0;
						ShiftSrc = 1'b0;
						ShiftAmt = 1'b0;
						ShiftCtrl = 3'b000;
						EPCWrite = 1'b0;
						estado = WAIT;
					end
				JALClk2: begin
					//Alteradas
						RegDst = 3'b100;
						MemToReg = 4'b1000;
						RegWrite = 1'b1;
					//Inalteradas        
						PCSource = 3'b000;
						PCWrite = 1'b0;
						WriteCond = 1'b0;
						IorD = 3'b000;
						Wr = 1'b0;
						IRWrite = 1'b0;
						WriteRegA = 1'b0;
						WriteRegB = 1'b0;
						AluSrcA = 2'b00;
						AluSrcB = 3'b000;
						AluOp = 3'b000;
						AluOutControl = 1'b0;
						MDRCtrl = 1'b0;
						LSControl = 2'b00;
						SSControl = 2'b00;
						ExceptionCtrl = 2'b00;
						WriteHI = 1'b0;
						WriteLO = 1'b0;
						HICtrl = 1'b0;
						LOCtrl = 1'b0;
						DivCtrl = 1'b0;
						MultCtrl = 1'b0;
						ShiftSrc = 1'b0;
						ShiftAmt = 1'b0;
						ShiftCtrl = 3'b000;
						EPCWrite = 1'b0;
						estado = WAIT;
					end
				SLTClk2: begin
					//Alteradas
						RegDst = 3'b010;
						MemToReg = 4'b0000;
						RegWrite = 1'b1;
					//Inalteradas        
						PCSource = 3'b000;
						PCWrite = 1'b0;
						WriteCond = 1'b0;
						IorD = 3'b000;
						Wr = 1'b0;
						IRWrite = 1'b0;
						WriteRegA = 1'b0;
						WriteRegB = 1'b0;
						AluSrcA = 2'b00;
						AluSrcB = 3'b000;
						AluOp = 3'b000;
						AluOutControl = 1'b0;
						MDRCtrl = 1'b0;
						LSControl = 2'b00;
						SSControl = 2'b00;
						ExceptionCtrl = 2'b00;
						WriteHI = 1'b0;
						WriteLO = 1'b0;
						HICtrl = 1'b0;
						LOCtrl = 1'b0;
						DivCtrl = 1'b0;
						MultCtrl = 1'b0;
						ShiftSrc = 1'b0;
						ShiftAmt = 1'b0;
						ShiftCtrl = 3'b000;
						EPCWrite = 1'b0;
						estado = WAIT;
					end
				LWClk2: begin
					//Alteradas
						//Wait clock
						MDRCtrl = 1'b1;
					//Inalteradas        
						PCSource = 3'b000;
						PCWrite = 1'b0;
						WriteCond = 1'b0;
						IorD = 3'b000;
						Wr = 1'b0;
						IRWrite = 1'b0;
						WriteRegA = 1'b0;
						WriteRegB = 1'b0;
						AluSrcA = 2'b00;
						AluSrcB = 3'b000;
						AluOp = 3'b000;
						AluOutControl = 1'b0;
						RegDst = 3'b000;
						MemToReg = 4'b0000;
						RegWrite = 1'b0;
						LSControl = 2'b00;
						SSControl = 2'b00;
						ExceptionCtrl = 2'b00;
						WriteHI = 1'b0;
						WriteLO = 1'b0;
						HICtrl = 1'b0;
						LOCtrl = 1'b0;
						DivCtrl = 1'b0;
						MultCtrl = 1'b0;
						ShiftSrc = 1'b0;
						ShiftAmt = 1'b0;
						ShiftCtrl = 3'b000;
						EPCWrite = 1'b0;
						estado = LWClk3;
					end
				LWClk3: begin
					//Alteradas
	                    RegDst = 3'b001;
						MemToReg = 4'b0001;
						RegWrite = 1'b1;
						LSControl = 2'b00;
					//Inalteradas        
						PCSource = 3'b000;
						PCWrite = 1'b0;
						WriteCond = 1'b0;
						IorD = 3'b000;
						Wr = 1'b0;
						IRWrite = 1'b0;
						WriteRegA = 1'b0;
						WriteRegB = 1'b0;
						AluSrcA = 2'b00;
						AluSrcB = 3'b000;
						AluOp = 3'b000;
						AluOutControl = 1'b0;
						MDRCtrl = 1'b0;
						SSControl = 2'b00;
						ExceptionCtrl = 2'b00;
						WriteHI = 1'b0;
						WriteLO = 1'b0;
						HICtrl = 1'b0;
						LOCtrl = 1'b0;
						DivCtrl = 1'b0;
						MultCtrl = 1'b0;
						ShiftSrc = 1'b0;
						ShiftAmt = 1'b0;
						ShiftCtrl = 3'b000;
						EPCWrite = 1'b0;
						estado = WAIT;
					end
				LHClk2: begin
					//Alteradas
						//Wait clock
						MDRCtrl = 1'b1;
					//Inalteradas        
						PCSource = 3'b000;
						PCWrite = 1'b0;
						WriteCond = 1'b0;
						IorD = 3'b000;
						Wr = 1'b0;
						IRWrite = 1'b0;
						WriteRegA = 1'b0;
						WriteRegB = 1'b0;
						AluSrcA = 2'b00;
						AluSrcB = 3'b000;
						AluOp = 3'b000;
						AluOutControl = 1'b0;
						RegDst = 3'b000;
						MemToReg = 4'b0000;
						RegWrite = 1'b0;
						LSControl = 2'b00;
						SSControl = 2'b00;
						ExceptionCtrl = 2'b00;
						WriteHI = 1'b0;
						WriteLO = 1'b0;
						HICtrl = 1'b0;
						LOCtrl = 1'b0;
						DivCtrl = 1'b0;
						MultCtrl = 1'b0;
						ShiftSrc = 1'b0;
						ShiftAmt = 1'b0;
						ShiftCtrl = 3'b000;
						EPCWrite = 1'b0;
						estado = LHClk3;
					end
				LHClk3: begin
					//Alteradas
	                    RegDst = 3'b001;
						MemToReg = 4'b0001;
						RegWrite = 1'b1;
						LSControl = 2'b01;
					//Inalteradas        
						PCSource = 3'b000;
						PCWrite = 1'b0;
						WriteCond = 1'b0;
						IorD = 3'b000;
						Wr = 1'b0;
						IRWrite = 1'b0;
						WriteRegA = 1'b0;
						WriteRegB = 1'b0;
						AluSrcA = 2'b00;
						AluSrcB = 3'b000;
						AluOp = 3'b000;
						AluOutControl = 1'b0;
						MDRCtrl = 1'b0;
						SSControl = 2'b00;
						ExceptionCtrl = 2'b00;
						WriteHI = 1'b0;
						WriteLO = 1'b0;
						HICtrl = 1'b0;
						LOCtrl = 1'b0;
						DivCtrl = 1'b0;
						MultCtrl = 1'b0;
						ShiftSrc = 1'b0;
						ShiftAmt = 1'b0;
						ShiftCtrl = 3'b000;
						EPCWrite = 1'b0;
						estado = WAIT;
					end
				LBClk2: begin
					//Alteradas
						//Wait clock
						MDRCtrl = 1'b1;
					//Inalteradas        
						PCSource = 3'b000;
						PCWrite = 1'b0;
						WriteCond = 1'b0;
						IorD = 3'b000;
						Wr = 1'b0;
						IRWrite = 1'b0;
						WriteRegA = 1'b0;
						WriteRegB = 1'b0;
						AluSrcA = 2'b00;
						AluSrcB = 3'b000;
						AluOp = 3'b000;
						AluOutControl = 1'b0;
						RegDst = 3'b000;
						MemToReg = 4'b0000;
						RegWrite = 1'b0;
						LSControl = 2'b00;
						SSControl = 2'b00;
						ExceptionCtrl = 2'b00;
						WriteHI = 1'b0;
						WriteLO = 1'b0;
						HICtrl = 1'b0;
						LOCtrl = 1'b0;
						DivCtrl = 1'b0;
						MultCtrl = 1'b0;
						ShiftSrc = 1'b0;
						ShiftAmt = 1'b0;
						ShiftCtrl = 3'b000;
						EPCWrite = 1'b0;
						estado = LBClk3;
					end
				LBClk3: begin
					//Alteradas
	                    RegDst = 3'b001;
						MemToReg = 4'b0001;
						RegWrite = 1'b1;
						LSControl = 2'b10;
					//Inalteradas        
						PCSource = 3'b000;
						PCWrite = 1'b0;
						WriteCond = 1'b0;
						IorD = 3'b000;
						Wr = 1'b0;
						IRWrite = 1'b0;
						WriteRegA = 1'b0;
						WriteRegB = 1'b0;
						AluSrcA = 2'b00;
						AluSrcB = 3'b000;
						AluOp = 3'b000;
						AluOutControl = 1'b0;
						MDRCtrl = 1'b0;
						SSControl = 2'b00;
						ExceptionCtrl = 2'b00;
						WriteHI = 1'b0;
						WriteLO = 1'b0;
						HICtrl = 1'b0;
						LOCtrl = 1'b0;
						DivCtrl = 1'b0;
						MultCtrl = 1'b0;
						ShiftSrc = 1'b0;
						ShiftAmt = 1'b0;
						ShiftCtrl = 3'b000;
						EPCWrite = 1'b0;
						estado = WAIT;
					end
					
				SWClk2: begin
					//Alteradas
                        MDRCtrl = 1;
					//Inalteradas        
					    PCSource = 3'b000;
					    PCWrite = 1'b0;
					    WriteCond = 1'b0;
					    IorD = 3'b000;
					    Wr = 1'b0;
					    IRWrite = 1'b0;
					    WriteRegA = 1'b0;
					    WriteRegB = 1'b0;
					    AluSrcA = 2'b00;
					    AluSrcB = 3'b000;
					    AluOp = 3'b000;
					    AluOutControl = 1'b0;
					    RegDst = 3'b000;
					    MemToReg = 4'b0000;
					    RegWrite = 1'b0;
					    LSControl = 2'b00;
					    SSControl = 2'b00;
					    ExceptionCtrl = 2'b00;
					    WriteHI = 1'b0;
					    WriteLO = 1'b0;
					    HICtrl = 1'b0;
					    LOCtrl = 1'b0;
					    DivCtrl = 1'b0;
					    MultCtrl = 1'b0;
					    ShiftSrc = 1'b0;
					    ShiftAmt = 1'b0;
					    ShiftCtrl = 3'b000;
					    EPCWrite = 1'b0;
					    estado = SWClk3;
					end
					
				SHClk2: begin
					//Alteradas
                        MDRCtrl = 1;
					//Inalteradas        
					    PCSource = 3'b000;
					    PCWrite = 1'b0;
					    WriteCond = 1'b0;
					    IorD = 3'b000;
					    Wr = 1'b0;
					    IRWrite = 1'b0;
					    WriteRegA = 1'b0;
					    WriteRegB = 1'b0;
					    AluSrcA = 2'b00;
					    AluSrcB = 3'b000;
					    AluOp = 3'b000;
					    AluOutControl = 1'b0;
					    RegDst = 3'b000;
					    MemToReg = 4'b0000;
					    RegWrite = 1'b0;
					    LSControl = 2'b00;
					    SSControl = 2'b00;
					    ExceptionCtrl = 2'b00;
					    WriteHI = 1'b0;
					    WriteLO = 1'b0;
					    HICtrl = 1'b0;
					    LOCtrl = 1'b0;
					    DivCtrl = 1'b0;
					    MultCtrl = 1'b0;
					    ShiftSrc = 1'b0;
					    ShiftAmt = 1'b0;
					    ShiftCtrl = 3'b000;
					    EPCWrite = 1'b0;
					    estado = SHClk3;
					end
					
				SBClk2: begin
					//Alteradas
                        MDRCtrl = 1;
					//Inalteradas        
					    PCSource = 3'b000;
					    PCWrite = 1'b0;
					    WriteCond = 1'b0;
					    IorD = 3'b000;
					    Wr = 1'b0;
					    IRWrite = 1'b0;
					    WriteRegA = 1'b0;
					    WriteRegB = 1'b0;
					    AluSrcA = 2'b00;
					    AluSrcB = 3'b000;
					    AluOp = 3'b000;
					    AluOutControl = 1'b0;
					    RegDst = 3'b000;
					    MemToReg = 4'b0000;
					    RegWrite = 1'b0;
					    LSControl = 2'b00;
					    SSControl = 2'b00;
					    ExceptionCtrl = 2'b00;
					    WriteHI = 1'b0;
					    WriteLO = 1'b0;
					    HICtrl = 1'b0;
					    LOCtrl = 1'b0;
					    DivCtrl = 1'b0;
					    MultCtrl = 1'b0;
					    ShiftSrc = 1'b0;
					    ShiftAmt = 1'b0;
					    ShiftCtrl = 3'b000;
					    EPCWrite = 1'b0;
					    estado = SBClk3;
					end
					
				SWClk3: begin
					//Alteradas
                        Wr = 1;
                        SSControl = 2'b00;
					//Inalteradas        
					    PCSource = 3'b000;
					    PCWrite = 1'b0;
					    WriteCond = 1'b0;
					    IorD = 3'b000;
					    IRWrite = 1'b0;
					    WriteRegA = 1'b0;
					    WriteRegB = 1'b0;
					    AluSrcA = 2'b00;
					    AluSrcB = 3'b000;
					    AluOp = 3'b000;
					    AluOutControl = 1'b0;
					    RegDst = 3'b000;
					    MemToReg = 4'b0000;
					    RegWrite = 1'b0;
					    MDRCtrl = 1'b0;
					    LSControl = 2'b00;
					    ExceptionCtrl = 2'b00;
					    WriteHI = 1'b0;
					    WriteLO = 1'b0;
					    HICtrl = 1'b0;
					    LOCtrl = 1'b0;
					    DivCtrl = 1'b0;
					    MultCtrl = 1'b0;
					    ShiftSrc = 1'b0;
					    ShiftAmt = 1'b0;
					    ShiftCtrl = 3'b000;
					    EPCWrite = 1'b0;
					    estado = WAIT;
					end
					
				SHClk3: begin
					//Alteradas
                        Wr = 1;
                        SSControl = 2'b01;
					//Inalteradas        
					    PCSource = 3'b000;
					    PCWrite = 1'b0;
					    WriteCond = 1'b0;
					    IorD = 3'b000;
					    IRWrite = 1'b0;
					    WriteRegA = 1'b0;
					    WriteRegB = 1'b0;
					    AluSrcA = 2'b00;
					    AluSrcB = 3'b000;
					    AluOp = 3'b000;
					    AluOutControl = 1'b0;
					    RegDst = 3'b000;
					    MemToReg = 4'b0000;
					    RegWrite = 1'b0;
					    MDRCtrl = 1'b0;
					    LSControl = 2'b00;
					    ExceptionCtrl = 2'b00;
					    WriteHI = 1'b0;
					    WriteLO = 1'b0;
					    HICtrl = 1'b0;
					    LOCtrl = 1'b0;
					    DivCtrl = 1'b0;
					    MultCtrl = 1'b0;
					    ShiftSrc = 1'b0;
					    ShiftAmt = 1'b0;
					    ShiftCtrl = 3'b000;
					    EPCWrite = 1'b0;
					    estado = WAIT;
					end
					
				SBClk3: begin
					//Alteradas
                        Wr = 1;
                        SSControl = 2'b10;
					//Inalteradas        
					    PCSource = 3'b000;
					    PCWrite = 1'b0;
					    WriteCond = 1'b0;
					    IorD = 3'b000;
					    IRWrite = 1'b0;
					    WriteRegA = 1'b0;
					    WriteRegB = 1'b0;
					    AluSrcA = 2'b00;
					    AluSrcB = 3'b000;
					    AluOp = 3'b000;
					    AluOutControl = 1'b0;
					    RegDst = 3'b000;
					    MemToReg = 4'b0000;
					    RegWrite = 1'b0;
					    MDRCtrl = 1'b0;
					    LSControl = 2'b00;
					    ExceptionCtrl = 2'b00;
					    WriteHI = 1'b0;
					    WriteLO = 1'b0;
					    HICtrl = 1'b0;
					    LOCtrl = 1'b0;
					    DivCtrl = 1'b0;
					    MultCtrl = 1'b0;
					    ShiftSrc = 1'b0;
					    ShiftAmt = 1'b0;
					    ShiftCtrl = 3'b000;
					    EPCWrite = 1'b0;
					    estado = WAIT;
					end
					
					
					
					
				WAIT: begin
					estado = FETCH;
					end
					
			endcase
		end
	end
endmodule