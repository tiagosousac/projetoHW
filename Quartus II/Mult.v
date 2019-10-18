module Mult (
input wire[31:0] RegAOut,
input wire[31:0] RegBOut,
input wire clock,
input wire reset,
input wire MultCtrl,
input wire Initialize,
output reg MultDone,
output reg [5:0] counter,
output reg[31:0] MultHIOut,
output reg[31:0] MultLOOut
);

//64:33 = A
//32:1 = Multiplier
//0:0 = Comparing Pos

reg [64:0] A_Multiplier_ComparePos;
reg [31:0] toMultiply;

always @ (posedge clock) begin
	if(Initialize == 1) begin
		A_Multiplier_ComparePos <= {32'b0, RegAOut[31:0], 1'b0};
		toMultiply <= RegBOut;
		counter <= 6'b0;
		MultDone <= 1'b0;
	end
	if(MultCtrl == 1'd1) begin
		if (counter < 6'b100000) begin
			if(A_Multiplier_ComparePos[1] == A_Multiplier_ComparePos[0])begin
				A_Multiplier_ComparePos <= A_Multiplier_ComparePos >>> 1;
			end
			else if (A_Multiplier_ComparePos[1] == 1)begin
				A_Multiplier_ComparePos[64:33] <= A_Multiplier_ComparePos[64:33] - toMultiply;
				A_Multiplier_ComparePos <= A_Multiplier_ComparePos >>> 1;
			end
			else begin
				A_Multiplier_ComparePos[64:33] <= A_Multiplier_ComparePos[64:33] + toMultiply;
				A_Multiplier_ComparePos <= A_Multiplier_ComparePos >>> 1;
			end
			counter <= counter + 1;
		end 
		else begin
			MultHIOut <= A_Multiplier_ComparePos[64:33];
			MultLOOut <= A_Multiplier_ComparePos[32:1];
			MultDone <= 1'b1;
		end
	end
	
	if(reset == 1'd1) begin
		A_Multiplier_ComparePos[64:0] <= 65'b0;
		toMultiply[31:0] <= 32'b0;
		counter <= 6'b0;
	end
end

endmodule