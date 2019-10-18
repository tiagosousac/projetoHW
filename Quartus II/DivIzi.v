module DivIzi (
input wire[31:0] FromA,
input wire[31:0] FromB,
input wire Reset,
input wire Clock,
input wire DivCtrl,
output reg Div0,
output reg DivDone,
output reg[31:0] HIOut,
output reg[31:0] LOOut
);
reg signed[31:0] AuxA;
reg signed[31:0] AuxB;
reg ativado;
reg signA;
reg signB;
reg signed[31:0] Contador;

initial begin//setar variaveis
ativado <= 1'b0;
end

always @(posedge Clock) begin
	if(Reset == 1) begin
			Contador <= 32'b0;
			ativado <= 1'b0;
			HIOut <= 32'b0;
			LOOut <= 32'b0;
			Div0 <= 1'b0;
			AuxA <= 32'b0;
			AuxB <= 32'b0;
			DivDone <= 0;
	end
	else if(DivCtrl == 1 && ativado == 0) begin
			Contador <= 32'b0;
			ativado <= 1'b1;//Reseta, mas muda o valor de ativado para começar
			HIOut <= 32'b0;
			LOOut <= 32'b0;
			Div0 <= 1'b0;
			DivDone <= 0;
			if(FromA[31] == 1) begin//Se for negativo, guarda informação e faz complemento 2
				signA <= 1;
				AuxA <= (!FromA) +1;
			end
			else begin
				AuxA <= FromA;//Se não, pega o valor na tora
			end
			if(FromB[31] == 1)begin//Realiza mesmo processo com B
				signB <= 1;
				AuxB <= (!FromB) +1;
			end
			else begin
				AuxB <= FromB;
			end
	end
	else begin
		if(ativado == 1'b1 && AuxB == 32'd0) begin
			Div0 <= 1'b1;//Coloca o maior valor possível, facilitar debug, e é o mais logico da Div0
			HIOut <= 32'b01111111111111111111111111111111;
			LOOut <= 32'b01111111111111111111111111111111;
		end
		else if (ativado == 1'b1) begin
			if(AuxA < AuxB)begin//Se o resto for menor que o valor a ser dividido, para de dividir
			//7   3| 2  1
			//7  -3|-2  1
			//-7  3|-2 -1
			//-7 -3| 2 -1
			//Estes Ifs seguem este padrão
				if(signA)begin
					//Transforma negativo
					AuxA <= (!AuxA) +1;
				end
				if(signB == 1 && signA == 1)begin
					//Transforma negativo, se A tiver sido negativo
					//vai colocar de volta para positivo
				end
				else if(signA)begin
					Contador <= (!Contador) + 1;//Transforma negativo
				end
				else if(signB)begin
					Contador <= (!Contador) + 1;//Transforma negativo
				end
				ativado = 1'b0;
				HIOut <= Contador;
				LOOut <= AuxA;
				DivDone <= 1'b1;//Informa que o Div foi finalizado
			end
			else begin
				AuxA <= (AuxA - AuxB);//Salva a subtração para poder ver qual o resto
				Contador <= (Contador + 1);//Incrementa resultado
			end
		end
	end
end

endmodule
