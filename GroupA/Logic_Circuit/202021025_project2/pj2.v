module pj2(start, control, ini, O);
input start;
input control;
input [3:0] ini;
output[3:0] O;

reg [3:0] X;

assign X = ini;
always @(control) begin
if(X == 9 && start == 1)
 X <= 4'd0;
else if(X != 9 && start == 1)
 X <= X + 4'd1;
end 
assign O = X;

endmodule
