module dss2_tb();
reg x, clk; 
wire UNLOCK, VG, NG; 
wire [10:1] save;
integer k;   

dss2 p(.x(x), .clk(clk), .UNLOCK(UNLOCK), .VG(VG), .NG(NG), .save(save));

initial begin 
clk <= 0;  
k <= 0;    
end
  
always #5 clk <= ~clk;  //generate clock signal

always @ (posedge clk) begin   // enter input
case(k)
0 : x <= 0; //MSB 
1 : x <= 0;
2 : x <= 0;
3 : x <= 0;
4 : x <= 0;
5 : x <= 0;
6 : x <= 1;
7 : x <= 1;
8 : x <= 0;
9 : x <= 1;
endcase
k = k+1;
end

endmodule