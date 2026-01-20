module dss2(clk, x, UNLOCK, VG, NG, save);          
input x, clk;
output reg UNLOCK, VG, NG; 
reg [10:1] i;
output reg [10:1] save;
parameter [10:1] si = 10'b0000001101;      //025   

initial begin  
i <= 0;
UNLOCK <= 0;
NG <= 0;
VG <= 0;
end
    
 always @ (posedge clk) begin// new x is entered at every changig clk  
	if (save[10:1] == si) begin UNLOCK <= 1; end  // success
	else if (x == si[10-i]) begin save[10-i] <= x; i <= i+1; VG <= 1; NG <= 0; end   // entered correct input
	else if (x != si[10-i]) begin NG <= 1; VG <= 0; end  // different input 	                  
 end 
 
endmodule