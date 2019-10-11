module SE1632 (
input wire[15:0] FromOffset,
output reg[31:0] toMuxD
);

always @(*) begin
	toMuxD <= {{16'd0},FromOffset};
end

endmodulex