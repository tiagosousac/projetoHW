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
parameter AfterADDIU = 7'b0000101;
parameter AfterADDI = 7'b0000110;
parameter AfterADD_SUB_AND = 7'b0000111;
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
                RegDst = 3'b101;
                MemToReg = 4'b1011;
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
                    IorD = 3'b000;
                    Wr = 1'b0;
                    AluSrcA = 2'b00;
					AluSrcB = 3'b001;
                    PCWrite = 1'b0;
				//Inalteradas
					PCSource = 3'b000;
					WriteCond = 1'b0;
					IRWrite = 1'b0;
					WriteRegA = 1'b0;
					WriteRegB = 1'b0;
					AluOp = 3'b000;
					AluOutControl = 1'b0;
					RegDst = 4'b0000;
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
                        ShiftSrc = 1'b1;
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
							//alterados
							AluSrcA = 2'b10;
							AluSrcB = 3'b010;
							AluOutControl = 1'b1;
							AluOp = 3'b001;		
							//inalterados
							 PCSource = 3'b000;
                                PCWrite = 1'b0;
                                WriteCond = 1'b0;
                                IorD = 3'b000;
                                Wr = 1'b0;
                                IRWrite = 1'b0;
                                WriteRegA = 1'b0;
                                WriteRegB = 1'b0;                                RegDst = 3'b000;
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
								estado = AfterADDI;
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
					            estado = ADDIxClk2;


							
							end
						BEQ: begin
							end
						BNE: begin
							end
						BLE: begin
							end
						BGT: begin
							end
						BLM: begin
							end
						LB: begin
							end
						LH: begin
							end
						LW: begin
							end
						SB: begin
							end
						SH: begin
							end
						SW: begin
							end
						LUI: begin
							end
						SLTI: begin
							end
						J: begin
							end
						JAL: begin
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
									estado =AfterADD_SUB_AND;
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
									RegDst = 4'b0000;
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
									estado = AfterADD_SUB_AND;
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
									RegDst = 4'b0000;
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
									estado = AfterADD_SUB_AND;
									end
								DIV: begin
									end
								MULT: begin
									end
								MFHI: begin
									end
								MFLO: begin
									end
								SLL: begin
									end
								SLLV: begin
									end
								SRL: begin
									end
								SRA: begin
									end
								SRAV: begin
									end
								SLT: begin
									end
								JR: begin
									end
								RTE: begin
									end
								XCHG: begin
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
                        RegDst = 3'b010;
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
				AfterADD_SUB_AND: begin //pode copiar para sub e and
				//Alteradas
					RegDst = 4'b0101; 
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
					
				WAIT: begin
					estado = FETCH;
					end
					
			endcase
		end
	end
endmodule