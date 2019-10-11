module SE132 (
input wire[0] oneb,//Nome mais genérico, pois possuem 2 Sign Ext de 1 to 32
output reg[30:0] to32b
);

always @(*) begin
	to32b <= {{31'd0},oneb};
end

endmodulex