module Vrcntr4u_tb();
reg CLK, CLR, LD, ENP, ENT;
wire [3:0] Q;
wire RCO;          

Vrcntr4u p(.CLK(CLK), .CLR(CLR), .LD(LD), .ENP(ENP), .ENT(ENT), .Q(Q), .RCO(RCO));

initial begin
	CLR <= 1;
	CLK <= 0;
	LD <= 0;
	ENP <= 1;
	ENT <= 1;    
	#10
	CLR = 0;
end        

always #5 CLK <= ~CLK;
endmodule
