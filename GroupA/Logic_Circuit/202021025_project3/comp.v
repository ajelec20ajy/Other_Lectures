module comp(P, Q, OPGTQ, OPEQQ, OPLTQ);
input [63:0] P;
input [63:0] Q;
wire [8:0] PGTQ, PEQQ, PLTQ;
output reg OPGTQ, OPEQQ, OPLTQ;

Vr8bitcmp a1 (.P(P[7:0]), .Q(Q[7:0]), .PGTQ(PGTQ[0]), .PEQQ(PEQQ[0]), .PLTQ(PLTQ[0]));
Vr8bitcmp a2 (.P({PGTQ[0],P[14:8]}), .Q({PLTQ[0],Q[14:8]}), .PGTQ(PGTQ[1]), .PEQQ(PEQQ[1]), .PLTQ(PLTQ[1]));
Vr8bitcmp a3 (.P({PGTQ[1],P[21:15]}), .Q({PLTQ[1],Q[21:15]}), .PGTQ(PGTQ[2]), .PEQQ(PEQQ[2]), .PLTQ(PLTQ[2]));
Vr8bitcmp a4 (.P({PGTQ[2],P[28:22]}), .Q({PLTQ[2],Q[28:22]}), .PGTQ(PGTQ[3]), .PEQQ(PEQQ[3]), .PLTQ(PLTQ[3]));
Vr8bitcmp a5 (.P({PGTQ[3],P[35:29]}), .Q({PLTQ[3],Q[35:29]}), .PGTQ(PGTQ[4]), .PEQQ(PEQQ[4]), .PLTQ(PLTQ[4]));
Vr8bitcmp a6 (.P({PGTQ[4],P[42:36]}), .Q({PLTQ[4],Q[42:36]}), .PGTQ(PGTQ[5]), .PEQQ(PEQQ[5]), .PLTQ(PLTQ[5]));
Vr8bitcmp a7 (.P({PGTQ[5],P[49:43]}), .Q({PLTQ[5],Q[49:43]}), .PGTQ(PGTQ[6]), .PEQQ(PEQQ[6]), .PLTQ(PLTQ[6]));
Vr8bitcmp a8 (.P({PGTQ[6],P[56:50]}), .Q({PLTQ[6],Q[56:50]}), .PGTQ(PGTQ[7]), .PEQQ(PEQQ[7]), .PLTQ(PLTQ[7]));
Vr8bitcmp a9 (.P({PGTQ[7],P[63:57]}), .Q({PLTQ[7],Q[63:57]}), .PGTQ(PGTQ[8]), .PEQQ(PEQQ[8]), .PLTQ(PLTQ[8]));


assign OPGTQ = PGTQ[8];
assign OPEQQ = PEQQ[8];
assign OPLTQ = PLTQ[8];

endmodule



module Vr8bitcmp(P, Q, PGTQ, PEQQ, PLTQ);
 input[7:0] P, Q;
 output reg PGTQ, PEQQ, PLTQ;

 always @ (P or Q) 
  if(P == Q)
 begin PGTQ = 1'b0; PEQQ = 1'b1; PLTQ = 1'b0; end
 else if(P > Q)
 begin PGTQ = 1'b1; PEQQ = 1'b0; PLTQ = 1'b0; end
 else if(P < Q)
 begin PGTQ = 1'b0; PEQQ = 1'b0; PLTQ = 1'b1; end
 
endmodule
