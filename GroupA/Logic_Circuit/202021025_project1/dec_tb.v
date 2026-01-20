module dec_tb();
 reg [5:0] IN;
 reg EN;
 wire [63:0] O;
 integer i;

dec A1 (.O(O), .IN(IN), .EN(EN));

initial begin
EN = 0;
IN = 6'b000000;
for (i=0;i<64;i = i+1)
#10 IN = IN + 1;
end

endmodule
 