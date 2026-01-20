module comp_tb;
reg [63:0] P;
reg [63:0] Q;
wire OPGTQ, OPEQQ, OPLTQ;

comp x(P, Q, OPGTQ, OPEQQ, OPLTQ);

initial begin
#20;
P = 64'b1;
Q = 64'b0; //PGTQ
#20;
P = 64'b0; //PEQQ
#20;
Q = 64'b1; //PLTQ

end

endmodule

