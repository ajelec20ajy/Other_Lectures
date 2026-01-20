module pj2_tb();
reg start;
reg control;
reg [3:0] ini;
wire [3:0] O;
integer i = 0;


pj2 p(.start(start), .control(control), .ini(ini), .O(O));

initial begin
control = 0;
start = 1;
ini = 4'd4; //set 4 to initial value because pj2 output the increased value of input. (for simulation)
while(1) begin
    i=i+1;
    if(i == 16) start = 0; //i=16(arbitrarily decided) -> it doesn't work from now on
#10 control = ~control;
end    
end

endmodule
