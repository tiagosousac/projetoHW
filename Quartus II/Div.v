module Div (
input wire[31:0] FromA,
input wire[31:0] FromB,
input wire Reset,
input wire Clock,
input wire DivCtrl,
output reg Div0,
output reg[31:0] HIOut,
output reg[31:0] LOOut
);

parameter S0 = 0, S1 = 1;

reg signed[63:0] Divisor;
reg signed[63:0] Remainder;
reg signed[63:0] Raux;
reg signed[31:0] Quotient;
integer Contador;
reg ativado;

initial begin//setar variaveis
ativado = 1'b0;
Contador = 0;
end

always @(*) begin
	if(Reset)
		begin
			Divisor <= 64'd0;
			Remainder <= 64'd0;
			Contador <= 0;
			ativado <= 1'b0;
			//Zera variaveis internas
		end
	if(DivCtrl == 1)
	begin
		if(ativado == 1'b0)
		begin
			Divisor <= {FromB,32'd0};
			Remainder <= {32'd0,FromA};
			Contador <= 0;
			ativado <= 1'b1;
			//Realiza procedimento inicial do algoritmo
			//Falta situação onde um deles é negativo
		end
		if (ativado == 1'b1 && FromB == 32'd0)
		begin
			Div0 <= 1'b1;
			HIOut <= 32'd0;
			LOOut <= 32'd0;
			//Da a Div0 o bit para dar exception
		end
		else if (ativado == 1'b1 && Div0 == 0)
		begin
			//Lagoritimo
			if(Contador == 33)
			begin
				HIOut<=Quotient;
				LOOut<=Remainder[31:0];
				ativado <= 1'b0;
				if(FromA[31] != FromB[31])begin
					HIOut[31] <= 1;//Como ele vai dando shift left, e mudando o bit mais a direita, não sabemos se é negativo
								  //então temos que mudar ao final.
				end
			end
			else begin //menor que 33
				Remainder = Remainder - Divisor;
				if(Remainder <0)
				begin
				Remainder = Remainder + Divisor;
				Quotient <= (Quotient<<1);
				Quotient[0] = 0;
				Divisor <= Divisor>>1;
				end
				else//Raux >=0
				begin
					Quotient <= Quotient<<1;
					Quotient[0] = 1;
					Divisor <= Divisor>>1;
				end
				Contador <=(Contador+1);
			end
		end
	end
end

endmodule
