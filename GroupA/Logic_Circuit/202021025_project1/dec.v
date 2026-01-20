module dec(IN, EN, O);
input [5:0] IN;
input EN;
output [63:0] O;

dec2 A1 (   O[3:0], IN[1:0], {EN, IN[5], IN[4],  IN[3],  IN[2]});
dec2 A2 (   O[7:4], IN[1:0], {EN, IN[5], IN[4],  IN[3], ~IN[2]});
dec2 A3 (  O[11:8], IN[1:0], {EN, IN[5], IN[4], ~IN[3],  IN[2]});
dec2 A4 ( O[15:12], IN[1:0], {EN, IN[5], IN[4], ~IN[3], ~IN[2]});

dec2 A5 ( O[19:16], IN[1:0], {EN, IN[5], ~IN[4],  IN[3],  IN[2]});
dec2 A6 ( O[23:20], IN[1:0], {EN, IN[5], ~IN[4],  IN[3], ~IN[2]});
dec2 A7 ( O[27:24], IN[1:0], {EN, IN[5], ~IN[4], ~IN[3],  IN[2]});
dec2 A8 ( O[31:28], IN[1:0], {EN, IN[5], ~IN[4], ~IN[3], ~IN[2]});

dec2 A9 ( O[35:32], IN[1:0], {EN, ~IN[5], IN[4],  IN[3],  IN[2]});
dec2 A10 (O[39:36], IN[1:0], {EN, ~IN[5], IN[4],  IN[3], ~IN[2]});
dec2 A11 (O[43:40], IN[1:0], {EN, ~IN[5], IN[4], ~IN[3],  IN[2]});
dec2 A12 (O[47:44], IN[1:0], {EN, ~IN[5], IN[4], ~IN[3], ~IN[2]});

dec2 A13 (O[51:48], IN[1:0], {EN, ~IN[5], ~IN[4],  IN[3],  IN[2]});
dec2 A14 (O[55:52], IN[1:0], {EN, ~IN[5], ~IN[4],  IN[3], ~IN[2]});
dec2 A15 (O[59:56], IN[1:0], {EN, ~IN[5], ~IN[4], ~IN[3],  IN[2]});
dec2 A16 (O[63:60], IN[1:0], {EN, ~IN[5], ~IN[4], ~IN[3], ~IN[2]});

endmodule 

module dec2(O, IN, EN);
 input [1:0] IN; 
 input [4:0] EN;
 output [3:0] O;
 wire [1:0] NOTIN;

 not U1 (NOTIN[0], IN[0]);
 not U2 (NOTIN[1], IN[1]);
 and U3 (O[0], NOTIN[0], NOTIN[1], ~EN);
 and U4 (O[1],    IN[0], NOTIN[1], ~EN);
 and U5 (O[2], NOTIN[0],    IN[1], ~EN);
 and U6 (O[3],    IN[0],    IN[1], ~EN);


endmodule
