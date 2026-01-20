module pr_last(clock_50m, pb, fnd_s, fnd_d);
   
   input clock_50m; 
   input [15:0] pb; 
   output reg [5:0] fnd_s; 
   output reg [7:0] fnd_d; 
   
   reg [15:0] npb;           
   reg [31:0] init_counter; 
   reg sw_clk;              
   reg fnd_clk;             
   reg [2:0] fnd_cnt;       
   

   reg [4:0] set_no1; 		 
   reg [4:0] set_no2; 
   reg [4:0] set_no3; 
   reg [4:0] set_no4; 
   reg [4:0] set_no5; 
   reg [4:0] set_no6; 
   
   reg [6:0] seg_100000; 	 
   reg [6:0] seg_10000; 
   reg [6:0] seg_1000;  
   reg [6:0] seg_100;    
   reg [6:0] seg_10;     
   reg [6:0] seg_1;     
   
   reg [15:0] pb_1st; 
   reg [15:0] pb_2nd; 
   reg sw_toggle;
   
   reg [4:0] sw_status;
   parameter sw_start = 0; 
   parameter sw_s1 = 1;   
   parameter sw_s2 = 2;  
   parameter sw_s3 = 3;  
   parameter sw_s4 = 4;   
   parameter sw_s5 = 5;   
   parameter error = 6;   
	parameter in_over = 8;	
   parameter display = 7;  

   reg special;        
   reg op_flag;        
   reg back_toggle;		
   reg bit_toggle; 		
    
   reg signed [21:0]result;  
   reg signed [21:0]nums;    
   reg signed [21:0]temp;	
   
   reg [15:0] op_p;           재에 입력된 연산자의 종류를 저장 
   parameter op_sqrt   = 3;   
   parameter op_remain   = 4;   	
   
     initial begin
      sw_status <= sw_start;
      sw_toggle <= 0;
     
      op_p <= 'h0000;      
      nums <= 0;
		result <= 0;
      op_flag <= 0;
      special <= 0;
      back_toggle <= 0;
      bit_toggle <= 0;
      temp <= 0;
      
      npb <= 'h0000;
      pb_1st <= 'h0000;
      pb_2nd <= 'h0000;
      
      set_no1 <= 18;
      set_no2 <= 18;
      set_no3 <= 18;
      set_no4 <= 18;
      set_no5 <= 18;
      set_no6 <= 18;
      
   end
   
   always begin
      npb <= ~pb;                    
      sw_clk <= init_counter[20];   
      fnd_clk <= init_counter[16];  
   end
   
   
   always @(posedge clock_50m) begin
      init_counter <= init_counter + 1;
   end
   
   always @(posedge sw_clk) begin
      pb_2nd <= pb_1st;
      pb_1st <= npb; 						버튼이 눌리는동안 중복되서 실행하는 것을 방지 
		
		if (back_toggle == 1) begin    
            back_toggle <= 0 ;
            nums <= nums/ 10 ;
				op_flag <= 0;
            case(sw_status) 
               sw_s1: begin
                  set_no1 <= 20;
                  sw_status <= sw_start;
               end
               sw_s2:begin
                  set_no2 <= 20;
                  sw_status <= sw_s1;
               end
               sw_s3:begin
                  set_no3 <= 20;
                  sw_status <= sw_s2;
               end
               sw_s4:begin
                  set_no4 <= 20;
                  sw_status <= sw_s3;
               end
               sw_s5:begin
                  set_no5 <= 20;
                  sw_status <= sw_s4;
               end
               error: begin               
                  set_no6 <= 20;
                  sw_status <= sw_s5;
               end
            endcase
         end
         
        
    
      if (bit_toggle == 1) begin      
            if(0 < nums && nums <= 2)begin
               result <= 1; 
            end
            
            else if(2 < nums && nums <= 4)begin
               result <= 2;
            end
            
            else if(4 < nums && nums <= 8)begin
               result <= 3;
            end
            
            else if(8 < nums && nums <= 16)begin
               result <= 4;
            end
            
            else if(16 < nums && nums <= 32)begin
               result <= 5;
            end
            
            else if(32 < nums && nums <= 64)begin
               result <= 6;
            end
				 else if(64 < nums && nums <= 128)begin
               result <= 7;
            end
            
            else if(128 < nums && nums <= 256)begin
               result <= 8;
            end
            
            else if(256 < nums && nums <= 512)begin
               result <= 9;
            end
            
            else if(512 < nums && nums <= 1024)begin
               result <= 10;
            end
            
            else if(1024 < nums && nums <= 2048)begin
               result <= 11;
            end
            
            else if(2048 < nums && nums <= 4096)begin
               result <= 12;
            end
            
            else if(4096 < nums && nums <= 8192)begin
               result <= 13;
            end
            
            else if(8192 < nums && nums <= 16384)begin
               result <= 14;
            end
            
            else if(16384 < nums && nums <= 32768)begin
               result <= 15;
            end
            
            else if(32768 < nums && nums <= 65536)begin
               result <= 16;
            end
            
            else if(65536 < nums && nums <= 131072)begin
               result <= 17;
            end
            
            else if(131072 < nums && nums <= 262144)begin
               result <= 18;
            end
            
            else if(262144 < nums && nums <= 524288)begin
               result <= 19;
            end
            
            else if(524288 < nums && nums <=1048576)begin
               result <= 20;
            end
				
            sw_status <= display;
            bit_toggle <= 0;
            
         end

      
      if (sw_status == display) begin       
  
	sw_status <= sw_start;
   op_p <= 'h0000;
   op_flag <= 0;
   result <= 0;
   special <= 0;
   nums <= 0;
	temp <= 0; 
	pb_1st <= 'h0000;
    if(0 <= result && result < 10) begin
    set_no1 <= 20;
    set_no2 <= 20;
    set_no3 <= 20;
    set_no4 <= 20;
    set_no5 <= 20;
    set_no6 <= result;
    end
   
    else if(10 <= result && result < 100) begin
    set_no1 <= 20;
    set_no2 <= 20;
    set_no3 <= 20;
    set_no4 <= 20;
    set_no5 <= result % 100 / 10;
    set_no6 <= result % 10;
    end
    
    else if(100 <= result && result < 1000) begin
    set_no1 <= 20;
    set_no2 <= 20;
    set_no3 <= 20;
    set_no4 <= result % 1000 / 100;
    set_no5 <= result % 100 / 10;
    set_no6 <= result % 10;
    end
    
    else if(1000 <= result && result < 10000) begin
    set_no1 <= 20;
    set_no2 <= 20;
    set_no3 <= result % 10000 / 1000;
    set_no4 <= result % 1000 / 100;
    set_no5 <= result % 100 / 10;
    set_no6 <= result % 10;
    end
    
    else if(10000 <= result && result < 100000) begin
    set_no1 <= 20;
    set_no2 <= result % 100000 / 10000;
    set_no3 <= result % 10000 / 1000;
    set_no4 <= result % 1000/ 100;
    set_no5 <= result % 100/ 10;
    set_no6 <= result % 10;
    end
    
    else if(100000 <= result && result < 1000000) begin
    set_no1 <= result % 1000000 / 100000;
    set_no2 <= result % 100000 / 10000;
    set_no3 <= result % 10000 / 1000;
    set_no4 <= result % 1000 / 100;
    set_no5 <= result % 100 / 10;
    set_no6 <= result % 10;
    end    
    else begin						
	 sw_status <= in_over;
    end
    
    end
   
     
	   if (sw_status == error) begin    
                     sw_status <=sw_start; 
                     set_no1 <= 16;      
                     set_no2 <= 17;      
                     set_no3 <= 17;     
                     set_no4 <= 21;     
                     set_no5 <= 17;      
                     set_no6 <= 20;      
                     
                    
                     nums <= 0;
                     result <= 0;
                     op_flag <= 0;
                     op_p <= 0; 
                     special <= 0;
                     pb_1st <= 'h0000;
                     
         end
	if (pb_2nd == 'h0000 && pb_1st != pb_2nd) begin 
         sw_toggle <= 1;
      end


	if (sw_toggle == 1 && pb_1st == pb_2nd) begin	튼이 눌린경우에 다음 함수를 실행
         sw_toggle <= 0;										 실행 방지
        
	   if (sw_status == in_over) begin  
                     sw_status <=sw_start; 
                     set_no1 <= 16;      
                     set_no2 <= 17;    
                     set_no3 <= 17;      
                     set_no4 <= 21;      
                     set_no5 <= 17;      
                     set_no6 <= 20;      
                     
                     nums <= 0;
                     result <= 0;
                     op_flag <= 0;
                     op_p <= 0; 
                     special <= 0;
                     pb_1st <= 'h0000;
                     
         end
			 
			
         case (pb_1st) 
				버튼이 눌할당될 때 각 경우에 따라 숫자 대입 및 연산을 수행 
			 
				'h0001: begin             
               case (sw_status)
                  sw_start: begin 
                     sw_status <= sw_s1;
                     set_no1 <= 1;
                     set_no2 <= 20; 
                     set_no3 <= 20; 
                     set_no4 <= 20; 
                     set_no5 <= 20; 
                     set_no6 <= 20;
                     op_flag <= 0;
                     nums <= 1; 
							special <= 0;                     
                  end

                  sw_s1: begin 		
                  if(set_no1 == 0) begin
                     set_no1 <= 1;
                     nums <= 1;
                  end
                  
                  else begin
                     sw_status <= sw_s2;  
                     set_no2 <= 1;
                     nums <= 10*set_no1+1;
                     
                  end
                 end
                 
                  sw_s2: begin
                     sw_status <= sw_s3; 
                     set_no3 <= 1; 
                     nums <= 100*set_no1+10*set_no2+1;
                     
                  end
                  sw_s3: begin
                     sw_status <= sw_s4; 
                     set_no4 <= 1;
                     nums <= 1000*set_no1+ 100 *set_no2+10*set_no3+1;
                     
                  end
                  sw_s4: begin
                     sw_status <= sw_s5;  
                     set_no5 <= 1;
                     nums <= 10000*set_no1 + 1000*set_no2+ 100*set_no3 + 10*set_no4 + 1;
                     
                  end
                  sw_s5: begin		
                     sw_status <= in_over; 
                     set_no6 <= 1;
                     nums <= 100000*set_no1 + 10000*set_no2 + 1000*set_no3 + 100*set_no4 + 10*set_no5 + 1;
                     
                  end
               endcase
           end
            
            'h0002: begin             // 2               
               case (sw_status)
                  sw_start: begin 
                     sw_status <= sw_s1;
                     set_no1 <= 2; 
                     set_no2 <= 20; 
                     set_no3 <= 20; 
                     set_no4 <= 20; 
                     set_no5 <= 20; 
                     set_no6 <= 20;
                     op_flag <= 0;
                     special <= 0;
                     nums <= 2;                     
                  end
                  
                  sw_s1: begin       
                  if(set_no1 == 0) begin
                     set_no1 <= 2;
                     nums <= 2;
                  end
                  
                  else begin
                     sw_status <= sw_s2;
                     set_no2 <= 2;
                     nums <= 10*set_no1 + 2;
                     
                  end
                 end
                  
                  sw_s2: begin
                     sw_status <= sw_s3;
                     set_no3 <= 2;
                     nums <= 100*set_no1 + 10*set_no2 + 2;                     
                  end
                  
                  sw_s3: begin
                     sw_status <= sw_s4; 
                     set_no4 <= 2;
                     nums <= 1000*set_no1 + 100*set_no2 + 10*set_no3 + 2;                     
                  end
                  
                  sw_s4: begin
                     sw_status <= sw_s5; 
                     set_no5 <= 2;
                     nums <= 10000*set_no1 + 1000*set_no2 + 100*set_no3 + 10*set_no4+2;
                     
                  end
                  sw_s5: begin
                     sw_status <= in_over; 
                     set_no6 <= 2;
                     nums <= 100000*set_no1 + 10000*set_no2 + 1000*set_no3 + 100*set_no4 + 10*set_no5+2;
                     
                  end
               endcase
           end
            
            'h0004: begin             // 3 
               case (sw_status)
                  sw_start: begin 
                     sw_status <= sw_s1;
                     set_no1 <= 3;  
                     set_no2 <= 20;  
                     set_no3 <= 20; 
                     set_no4 <= 20;  
                     set_no5 <= 20; 
                     set_no6 <= 20;  
                     special <= 0;
                     nums <= 3;
                     op_flag <= 0;                     
                  end 
						
                  sw_s1: begin     
                  if(set_no1 == 0) begin
                     set_no1 <= 3;
                     nums <= 3;
                  end
                  
                  else begin
                     sw_status <= sw_s2; 
                     set_no2 <= 3;
                     nums <= 10*set_no1 + 3;
                  end
                  
                 end                 
                  sw_s2: begin
                     sw_status <= sw_s3; 
                     set_no3 <= 3; 
                     nums <= 100*set_no1 + 10*set_no2 + 3;
                  end
						
                  sw_s3: begin
                     sw_status <= sw_s4; 
                     set_no4 <= 3;
                     nums <= 1000*set_no1 + 100*set_no2 + 10*set_no3 + 3;
                  end
                  
						sw_s4: begin
                     sw_status <= sw_s5; 
                     set_no5 <= 3;
                     nums <= 10000*set_no1 + 1000*set_no2 + 100*set_no3 + 10*set_no4 + 3;
                  end
                  
						sw_s5: begin
                     sw_status <= in_over; 
                     set_no6 <= 3;
                     nums <= 100000*set_no1 + 10000*set_no2 + 1000*set_no3 + 100*set_no4+10*set_no5 + 3;
                  end
               endcase
           end
           
            
            'h0010: begin          
              case (sw_status)
                  sw_start: begin 
                     sw_status <= sw_s1;
                     set_no1 <= 4; 
                     set_no2 <= 20; 
                     set_no3 <= 20; 
                     set_no4 <= 20; 
                     set_no5 <= 20; 
                     set_no6 <= 20;
                     special <= 0;   
                     nums <= 4;
                     op_flag <= 0;                     
                  end
         
                  sw_s1: begin 
                     if(set_no1 == 0) begin
                        set_no1 <= 4;
                        nums <= 4;
                     end
                  
                     else begin
                        sw_status <= sw_s2;
                        set_no2 <= 4;
                        nums <= 10*set_no1 + 4;
                     end
                 end
                  sw_s2: begin
                     sw_status <= sw_s3; 
                     set_no3 <= 4; 
                     nums <= 100*set_no1 + 10*set_no2 + 4;
                  end
                  sw_s3: begin
                     sw_status <= sw_s4; 
                     set_no4 <= 4;
                     nums <= 1000*set_no1 + 100*set_no2 + 10*set_no3 + 4;                     
                  end
                  
                  sw_s4: begin
                     sw_status <= sw_s5; 
                     set_no5 <= 4;
                     nums <= 10000*set_no1 + 1000*set_no2 + 100*set_no3 + 10*set_no4 + 4;
                     
                  end
                  sw_s5: begin
                     sw_status <= in_over; 
                     set_no6 <= 4;
                     nums <= 100000*set_no1 + 10000*set_no2 + 1000*set_no3 + 100*set_no4 + 10*set_no5 + 4;
                     
                  end
               endcase
           end           
           
           
            'h0020: begin         
               case (sw_status)
                  sw_start: begin 
                     sw_status <= sw_s1;
                     set_no1 <= 5; 
                     set_no2 <= 20; 
                     set_no3 <= 20; 
                     set_no4 <= 20; 
                     set_no5 <= 20;
                     set_no6 <= 20;
                     op_flag <= 0;
                     special <= 0;
                     nums <= 5;
                     
                  end

                  sw_s1: begin       
						  if(set_no1 == 0) begin
                     set_no1 <= 5;
                     nums <= 5;
                    end
                  
                    else begin
                     sw_status <= sw_s2; 
                     set_no2 <= 5;
                     nums <= 10*set_no1 + 5;                     
                    end
						
                  end
                  sw_s2: begin
                     sw_status <= sw_s3; 
                     set_no3 <= 5; 
                     nums <= 100*set_no1 + 10*set_no2 + 5;                     
                  end
                  sw_s3: begin
                     sw_status <= sw_s4; 
                     set_no4 <= 5;
                     nums <= 1000*set_no1 + 100*set_no2+10*set_no3 + 5;
                     
                  end
                  sw_s4: begin
                     sw_status <= sw_s5; 
                     set_no5 <= 5;
                     nums <= 10000*set_no1 + 1000*set_no2 + 100*set_no3 + 10*set_no4+5;
                     
                  end
                  sw_s5: begin
                     sw_status <= in_over; 
                     set_no6 <= 5;
                     nums <= 100000*set_no1 + 10000*set_no2 + 1000*set_no3 + 100*set_no4 + 10*set_no5+5;
                     
                  end
               endcase
           end
           
           
           
            'h0040: begin          
               case (sw_status)
                  sw_start: begin 
                     sw_status <= sw_s1;
                     set_no1 <= 6; 
                     set_no2 <= 20; 
                     set_no3 <= 20; 
                     set_no4 <= 20; 
                     set_no5 <= 20; 
                     set_no6 <= 20; 
                     special <= 0;
                     nums <= 6;
                     op_flag <= 0;
                     
                  end

                  sw_s1: begin         
                  if(set_no1 == 0) begin
                     set_no1 <= 6;
                     nums <= 6;
                  end
                  
                  else begin
                     sw_status <= sw_s2; 
                     set_no2 <= 6;
                     nums <= 10*set_no1 + 6;
                     
                  end
                 end
                  sw_s2: begin
                     sw_status <= sw_s3; 
                     set_no3 <= 6; 
                     nums <= 100*set_no1 + 10*set_no2 + 6;
                     
                  end
                  sw_s3: begin
                     sw_status <= sw_s4; 
                     set_no4 <= 6;
                     nums <= 1000*set_no1 + 100*set_no2+10*set_no3 + 6;
                     
                  end
                  sw_s4: begin
                     sw_status <= sw_s5; 
                     set_no5 <= 6;
                     nums <= 10000*set_no1 + 1000*set_no2 + 100*set_no3 + 10*set_no4+6;
                     
                  end
                  sw_s5: begin
                     sw_status <= in_over; 
                     set_no6 <= 6;
                     nums <= 100000*set_no1 + 10000*set_no2 + 1000*set_no3 + 100*set_no4 + 10*set_no5 + 6;
                     
                  end
               endcase
           end
            
            
            'h0100: begin          
               case (sw_status)
                  sw_start: begin 
                     sw_status <= sw_s1;
                     set_no1 <= 7; 
                     set_no2 <= 20;  
                     set_no3 <= 20;  
                     set_no4 <= 20;  
                     set_no5 <= 20;  
                     set_no6 <= 20; 
                     special <= 0; 
                     nums <= 7;
                     op_flag <= 0;                     
                  end
                  
                  sw_s1: begin       
                  if(set_no1 == 0) begin
                     set_no1 <= 7;
                     nums <= 7;
                  end
                  
                  else begin
                     sw_status <= sw_s2; 
                     set_no2 <= 7;
                     nums <= 10*set_no1 + 7;                     
                  end
                  
                 end
                  sw_s2: begin
                     sw_status <= sw_s3; 
                     set_no3 <= 7; 
                     nums <= 100*set_no1 + 10*set_no2 + 7;
                     
                  end
                  sw_s3: begin
                     sw_status <= sw_s4; 
                     set_no4 <= 7;
                     nums <= 1000*set_no1+ 100*set_no2+10*set_no3 + 7;
                     
                  end
                  sw_s4: begin
                     sw_status <= sw_s5; 
                     set_no5 <= 7;
                     nums <= 10000*set_no1 + 1000*set_no2 + 100*set_no3 + 10*set_no4 + 7;
                     
                  end
                  sw_s5: begin
                     sw_status <= in_over; 
                     set_no6 <= 7;
                     nums <= 100000*set_no1 + 10000*set_no2 + 1000*set_no3 + 100*set_no4 + 10*set_no5 + 7;
                     
                  end
               endcase
           end
           
           
            'h0200: begin           
               case (sw_status)
                  sw_start: begin 
                     sw_status <= sw_s1;
                     set_no1 <= 8; 
                     set_no2 <= 20; 
                     set_no3 <= 20; 
                     set_no4 <= 20; 
                     set_no5 <= 20; 
                     set_no6 <= 20;
                     special <= 0;
                     op_flag <= 0;
                     nums <= 8;                     
                  end

                  sw_s1: begin          
                  if(set_no1 == 0) begin
                     set_no1 <= 8;
                     nums <= 8;
                  end
                  
                  else begin
                     sw_status <= sw_s2;  
                     set_no2 <= 8;
                     nums <= 10*set_no1 + 8;
                     
                  end
                 end
                  sw_s2: begin
                     sw_status <= sw_s3; 
                     set_no3 <= 8;
                     nums <= 100*set_no1 + 10*set_no2 + 8;
                     
                  end
                  sw_s3: begin
                     sw_status <= sw_s4;
                     set_no4 <= 8;
                     nums <= 1000*set_no1 + 100*set_no2 + 10*set_no3 + 8;
                     
                  end
                  sw_s4: begin
                     sw_status <= sw_s5; 
                     set_no5 <= 8;
                     nums <= 10000*set_no1 + 1000*set_no2 + 100*set_no3 + 10*set_no4 + 8;                     
                  end
                  
                  sw_s5: begin
                     sw_status <= in_over; 
                     set_no6 <= 8;
                     nums <= 100000*set_no1 + 10000*set_no2 + 1000*set_no3 + 100*set_no4 + 10*set_no5 + 8;
                     
                  end
               endcase
           end
           
            'h0400: begin             
               case (sw_status)
                  sw_start: begin 
                     sw_status <= sw_s1;
                     set_no1 <= 9; 
                     set_no2 <= 20; 
                     set_no3 <= 20; 
                     set_no4 <= 20; 
                     set_no5 <= 20; 
                     set_no6 <= 20; 
                     special <= 0;
                     nums <= 9;
                     op_flag <= 0;
                     
                  end

                  sw_s1: begin    
                  if(set_no6 == 0) begin
                     set_no6 <= 9;
                     nums <= 9;
                  end
                  
                  else begin
                     sw_status <= sw_s2; 
                     set_no2 <= 9;
                     nums <= 10*set_no1 + 9;
                  end
                 end
                  sw_s2: begin
                     sw_status <= sw_s3; 
                     set_no3 <= 9; 
                     nums <= 100*set_no1 + 10*set_no2 + 9;
                  end
                  
                  sw_s3: begin
                     sw_status <= sw_s4; 
                     set_no4 <= 9;
                     nums <= 1000*set_no1 + 100*set_no2 + 10*set_no3 + 9;
                  end
                  
                  sw_s4: begin
                     sw_status <= sw_s5; 
                     set_no5 <= 9;
                     nums <= 10000*set_no1 + 1000*set_no2 + 100*set_no3 + 10*set_no4 + 9;
                     
                  end
                  sw_s5: begin
                     sw_status <= in_over; 
                     set_no6 <= 9;
                     nums <= 100000*set_no1 + 10000*set_no2 + 1000*set_no3 + 100*set_no4 + 10*set_no5 + 9;
                     
                  end
               endcase
           end
          
            'h2000: begin            
              case (sw_status)
                  sw_start: begin 
                     sw_status <= sw_s1;
                     set_no1 <= 0; 
                     set_no2 <= 20; 
                     set_no3 <= 20; 
                     set_no4 <= 20; 
                     set_no5 <= 20; 
                     set_no6 <= 20; 
                     special <= 0;
                     nums <= 0;
                     op_flag <= 0;                     
                  end
                  
                  sw_s1: begin      
                  if(set_no1 == 0) begin
                     set_no1 <= 0;
                     nums <= 0;
                  end
                  
                  else begin
                     sw_status <= sw_s2; 
                     set_no2 <= 0;
                     nums <= 10*set_no1+0;
                     
                  end
                 end
                  sw_s2: begin
                     sw_status <= sw_s3; 
                     set_no3 <= 0; 
                     nums <= 100*set_no1 + 10*set_no2+0;                     
                  end
                  
                  sw_s3: begin
                     sw_status <= sw_s4; 
                     set_no4 <= 0;
                     nums <= 1000*set_no1 + 100*set_no2 + 10*set_no3+0;
                     
                  end
                  sw_s4: begin
                     sw_status <= sw_s5; 
                     set_no5 <= 0;
                     nums <= 10000*set_no1 + 1000*set_no2 + 100*set_no3 + 10*set_no4 + 0;
                     
                  end
                  sw_s5: begin
                     sw_status <= in_over; 
                     set_no6 <= 0;
                     nums <= 100000*set_no1 + 10000*set_no2 + 1000*set_no3 + 100*set_no4 + 10*set_no5 + 0;
                     
                  end
               endcase
           end
           
           

           
           
            'h0008: begin                       
            if(sw_status == sw_start || op_flag == 1) begin 
               sw_status <= error;                  
            end
                  
            if(op_flag == 0) begin			   
                op_flag <= 1;
             
             if(special ==0) begin           
                op_p <= pb_1st;
                sw_status <= sw_start;출력
                set_no1 <= 20;
                set_no2 <= 20;
                set_no3 <= 23;
                set_no4 <= 23;
                set_no5 <= 23;
                set_no6 <= 21;
               case (op_p)         기존 연산자       
                'h0000: begin               
                   result <= nums;
                end
                'h0008: begin                
                   result <= result + nums;
                end
                
                'h0080: begin            
                  result <= result - nums;
                end
                
                'h0800: begin                
                  result <= result * nums;
                end
               
                'h8000: begin          
                  if(nums == 0) begin   으로 나누는 경우 
                     sw_status <= error;  
                     end
                                    
                  else begin            아닌 수로 나누는 경우 
                  result <= result / nums;
                     end
                  end
                  3: begin					 
                     result <= result * result;
                  end
                  4: begin					
                     result <= result % nums;
                  end
               
                endcase
            end
				//
            else if(special ==1) begin
               special <= 0; 
               back_toggle <= 1;
					case (op_p)         기존 연산자       
                'h0000: begin          없는 경우       
                   result <= nums;
                end
                'h0008: begin                
                   result <= result + nums;
                end
                
                'h0080: begin             
                  result <= result - nums;
                end
                
                'h0800: begin                  
                  result <= result * nums;
                end
               
                'h8000: begin            
                  if(nums == 0) begin   로 나누는 경우 
                     sw_status <= error;  
                     end
                                    
                  else begin 아닌 수로 나누는 경우 
                  result <= result / nums;
                     end
							end
                  3: begin					
                     result <= result * result;
                  end
                  4: begin					
                     result <= result % nums;
                  end
               
                endcase
               end
            end
         end
            'h0080: begin           
            if(sw_status == sw_start) begin 숫자 없이 연산자만 입력된 경우 
               sw_status <= error;                  
            end
                  
            if(op_flag == 0) begin
                op_flag <= 1;
             
             if(special ==0) begin           
                op_p <= pb_1st;
                sw_status <= sw_start;
                //SUbS 출력
                set_no1 <= 20;
                set_no2 <= 20;
                set_no3 <= 22;
                set_no4 <= 22;
                set_no5 <= 21;
                set_no6 <= 21;
               case (op_p)          기존 연산자       
                'h0000: begin           는 경우       
                   result <= nums;
                end
                'h0008: begin                  
                   result <= result + nums;
                end
                
                'h0080: begin                
                  result <= result - nums;
                end
                
                'h0800: begin                  
                  result <= result * nums;
                end
               
                'h8000: begin            
                  if(nums == 0) begin   로 나누는 경우 
                     sw_status <= error;  
                     end
                                    
                  else begin            이 아닌 수로 나누는 경우 
                  result <= result / nums;
                     end
                  end
                  3: begin						
                     result <= result * result; 
                  end
                  4: begin						
                     result <= result % nums;
                  end
               
                endcase
             end
             else if(special ==1) begin
               special <= 0; 
               bit_toggle <= 1;
					case (op_p)        기존 연산자       
                'h0000: begin          없는 경우       
                   result <= nums;
                end
                'h0008: begin               
                   result <= result + nums;
                end
                
                'h0080: begin               
                  result <= result - nums;
                end
                
                'h0800: begin                 
                  result <= result * nums;
                end
               
                'h8000: begin            
                  if(nums == 0) begin   로 나누는 경우 
                     sw_status <= error;  
                     end
                                    
                  else begin          아닌 수로 나누는 경우 
                  result <= result / nums;
                     end
                  end
                  3: begin
                     result <= result * result;  
                  end
                  4: begin						
                     result <= result % nums;
                  end
               
                endcase
            end
         end
            end
            'h0800: begin             
             if(sw_status == sw_start) begin 자 없이 연산자만 입력된 경우 
               sw_status <= error;                  
             end
                  
            if(op_flag == 0) begin				
                op_flag <= 1;
             
             if(special ==0) begin           
                op_p <= pb_1st;
                sw_status <= sw_start;
                //mULt 출력
                set_no1 <= 20;
                set_no2 <= 21;
                set_no3 <= 21;
                set_no4 <= 22;
                set_no5 <= 22;
                set_no6 <= 22;
               case (op_p)        기존 연산자       
                'h0000: begin           없는 경우       
                   result <= nums;
                end
                'h0008: begin                 
                   result <= result + nums;
                end
                
                'h0080: begin                
                  result <= result - nums;
                end
                
                'h0800: begin                
                  result <= result * nums;
                end
               
                'h8000: begin           
                  if(nums == 0) begin   로 나누는 경우 
                     sw_status <= error;  
                     end
                                    
                  else begin           이 아닌 수로 나누는 경우 
                  result <= result / nums;
                     end
                  end
                  3: begin						
                     result <= result * result;
                  end
                  4: begin						
                     result <= result % nums;
                  end
               
                endcase
            end
            else if(special == 1) begin	
				op_p <= 3;	
				op_flag <= 0;
				special <= 0;
				case (op_p)      기존 연산자       
                'h0000: begin          없는 경우       
                   result <= nums;
                end
                'h0008: begin                 
                   result <= result + nums;
                end
                
                'h0080: begin                
                  result <= result - nums;
                end
                
                'h0800: begin                 
                  result <= result * nums;
                end
               
                'h8000: begin            
                  if(nums == 0) begin  로 나누는 경우 
                     sw_status <= error;  
                     end
                                    
                  else begin            아닌 수로 나누는 경우 
                  result <= result / nums;
                     end
                  end
                  1: begin               
                     back_toggle <= 1;
                  end
                  2: begin                
                     bit_toggle <= 1;
                  end 
                  3: begin						
                     result <= result * result;
                  end
                  4: begin						
                     result <= result % nums;
                  end
               
                endcase
				
				end
         end 
end			
            'h8000: begin           
                if(sw_status == sw_start) begin숫자 없이 연산자만 입력된 경우 
               sw_status <= error;                  
             end
                  
            if(op_flag == 0) begin			
                op_flag <= 1;
             
             if(special ==0) begin         
                op_p <= pb_1st;
                sw_status <= sw_start; 출력
                set_no1 <= 20;
                set_no2 <= 20;
                set_no3 <= 24;
                set_no4 <= 24;
                set_no5 <= 24;
                set_no6 <= 23;
               case (op_p)        기존 연산자       
                'h0000: begin          없는 경우       
                   result <= nums;
                end
                'h0008: begin              
                   result <= result + nums;
                end
                
                'h0080: begin               
                  result <= result - nums;
                end
                
                'h0800: begin                  
                  result <= result * nums;
                end
               
                'h8000: begin             
                  if(nums == 0) begin   로 나누는 경우 
                     sw_status <= error;  
                     end
                                    
                  else begin             아닌 수로 나누는 경우 
                  result <= result / nums;
                     end
                  end
                  1: begin                
                     back_toggle <= 1;
                  end
                  2: begin               
                     bit_toggle <= 1;
                  end 
                  3: begin
                     result <= result * result;
                  end
                  4: begin
                     result <= result % nums;
                  end
               
                endcase
            end
            else if(special == 1) begin	
                op_p <= 4;
                sw_status <= sw_start;
                special <= 0;
					 case (op_p)           기존 연산자       
                'h0000: begin          는 경우       
                   result <= nums;
                end
                'h0008: begin                 
                   result <= result + nums;
                end
                
                'h0080: begin                
                  result <= result - nums;
                end
                
                'h0800: begin               
                  result <= result * nums;
                end
               
                'h8000: begin            
                  if(nums == 0) begin   로 나누는 경우 
                     sw_status <= error;  
                     end
                                    
                  else begin           아닌 수로 나누는 경우 
                  result <= result / nums;
                     end
                  end
                  3: begin
                    result <= result * result;
                  end
                  4: begin
                     result <= result % nums;
                  end
               
                endcase
               end
            end
         end

            'h1000: begin            
               if(op_flag==1||sw_status == sw_start) begin     
                    op_flag <= 0;
                    sw_status <= error;  
               end
               else begin             
                  special <= 1;
						if(special==1) begin  
                     sw_status <= sw_start; 
                     result <= 0;
                     op_flag <= 0;
                     op_p <= 0; 
                     special <= 0;
                     pb_1st <= 'h0000;
                     set_no1 <= 18;      
                     set_no2 <= 18;      
                     set_no3 <= 18;      
                     set_no4 <= 18;      
                     set_no5 <= 18;      
                     set_no6 <= 18;
                  
                  end
                  
               end
             end      
            'h4000: begin            
               if(sw_status == sw_start || op_flag == 1) begin  눌린 경우
                     sw_status <= error; 
               end
                              
               else begin     눌린 경우             
               sw_status <= display;               
               case (op_p)               
                'h0000: begin      의 경우
                  result <= nums;                  
                  end
                
                'h0008: begin     하기
                  result <= result + nums;
                end
                
                'h0080: begin     
                  result <= result - nums;
                end
                
                'h0800: begin     기
                  result <= result * nums;
                end
                
                'h8000: begin      누기
                                               
                   if(nums == 0) begin         나눴을때 
                     sw_status <= error; 
                    end
                
                   else begin
                     result <= result / nums;
                   end
                  end
                  3: begin
						result <= result * result;
                  end
                  4: begin
                  result <= result%nums;
                  end
               endcase
               end                 
            end
            
			endcase
		end
   end

      
        
   
   always @(set_no1) begin
      case (set_no1)
         0: seg_100000 <= 'b0011_1111;
         1: seg_100000 <= 'b0000_0110;
         2: seg_100000 <= 'b0101_1011;
         3: seg_100000 <= 'b0100_1111;
         4: seg_100000 <= 'b0110_0110;
         5: seg_100000 <= 'b0110_1101;
         6: seg_100000 <= 'b0111_1101;
         7: seg_100000 <= 'b0000_0111;
         8: seg_100000 <= 'b0111_1111;
         9: seg_100000 <= 'b0110_0111; 수
         10: seg_100000 <= 'b0111_1000;
         11: seg_100000 <= 'b0111_0011;
         12: seg_100000 <= 'b0111_0111;
         13: seg_100000 <= 'b0111_1100;
         14: seg_100000 <= 'b0011_1001;
         15: seg_100000 <= 'b0101_1110;
         16: seg_100000 <= 'b0111_1001;
         17: seg_100000 <= 'b0101_0000;
         18: seg_100000 <= 'b0100_0000;
         19: seg_100000 <= 'b0101_0100;
         20: seg_100000 <= 'b0000_0000;
         default: seg_100000 <= 'b0000_0000;
      endcase
   end
   
   always @(set_no2) begin
      case (set_no2)
         0: seg_10000 <= 'b0011_1111;
         1: seg_10000 <= 'b0000_0110;
         2: seg_10000 <= 'b0101_1011;
         3: seg_10000 <= 'b0100_1111;
         4: seg_10000 <= 'b0110_0110;
         5: seg_10000 <= 'b0110_1101;
         6: seg_10000 <= 'b0111_1101;
         7: seg_10000 <= 'b0000_0111;
         8: seg_10000 <= 'b0111_1111;
         9: seg_10000 <= 'b0110_0111;
         10: seg_10000 <= 'b0111_1000;
         11: seg_10000 <= 'b0111_0011;
         12: seg_10000 <= 'b0111_0111;
         13: seg_10000 <= 'b0111_1100;
         14: seg_10000 <= 'b0011_1001;
         15: seg_10000 <= 'b0101_1110;
         16: seg_10000 <= 'b0111_1001;
         17: seg_10000 <= 'b0101_0000;
         18: seg_10000 <= 'b0100_0000;
         19: seg_10000 <= 'b0101_0100;
         20: seg_10000 <= 'b0000_0000;   와 동일하게 한번 더 선언
         21: seg_10000 <= 'b0011_0111; 
         default: seg_10000 <= 'b0000_0000;
      endcase
   end
   always @(set_no3) begin
      case (set_no3)
         0: seg_1000 <= 'b0011_1111;
         1: seg_1000 <= 'b0000_0110;
         2: seg_1000 <= 'b0101_1011;
         3: seg_1000 <= 'b0100_1111;
         4: seg_1000 <= 'b0110_0110;
         5: seg_1000 <= 'b0110_1101;
         6: seg_1000 <= 'b0111_1101;
         7: seg_1000 <= 'b0000_0111;
         8: seg_1000 <= 'b0111_1111;
         9: seg_1000 <= 'b0110_0111;
         10: seg_1000 <= 'b0111_1000;
         11: seg_1000 <= 'b0111_0011;
         12: seg_1000 <= 'b0111_0111;
         13: seg_1000 <= 'b0111_1100;
         14: seg_1000 <= 'b0011_1001;
         15: seg_1000 <= 'b0101_1110;
         16: seg_1000 <= 'b0111_1001;
         17: seg_1000 <= 'b0101_0000;
         18: seg_1000 <= 'b0100_0000;
         19: seg_1000 <= 'b0101_0100;
         20: seg_1000 <= 'b0000_0000;
         21: seg_1000 <= 'b0011_0111; 
         22: seg_1000 <= 'b0110_1101; 
         23: seg_1000 <= 'b0111_0011; 
         24: seg_1000 <= 'b0101_1110;   
         default: seg_1000 <= 'b0000_0000;
      endcase
   end
   
   always @(set_no4) begin
      case (set_no4)
         0: seg_100 <= 'b0011_1111;
         1: seg_100 <= 'b0000_0110;
         2: seg_100 <= 'b0101_1011;
         3: seg_100 <= 'b0100_1111;
         4: seg_100 <= 'b0110_0110;
         5: seg_100 <= 'b0110_1101;
         6: seg_100 <= 'b0111_1101;
         7: seg_100 <= 'b0000_0111;
         8: seg_100 <= 'b0111_1111;
         9: seg_100 <= 'b0110_0111;
         10: seg_100 <= 'b0111_1000;
         11: seg_100 <= 'b0111_0011;
         12: seg_100 <= 'b0111_0111;
         13: seg_100 <= 'b0111_1100;
         14: seg_100 <= 'b0011_1001;
         15: seg_100 <= 'b0101_1110;
         16: seg_100 <= 'b0111_1001;
         17: seg_100 <= 'b0101_0000;
         18: seg_100 <= 'b0100_0000;
         19: seg_100 <= 'b0101_0100; 
         20: seg_100 <= 'b0000_0000;
         21: seg_100 <= 'b0101_1100; 
         22: seg_100 <= 'b0011_1110;
         23: seg_100 <= 'b0011_1000; 
         24: seg_100 <= 'b0000_0110; 
         25: seg_100 <= 'b0111_1100;   
         default: seg_100 <= 'b0000_0000;
      endcase
   end
   
   always @(set_no5) begin
      case (set_no5)
         0: seg_10 <= 'b0011_1111;
         1: seg_10 <= 'b0000_0110;
         2: seg_10 <= 'b0101_1011;
         3: seg_10 <= 'b0100_1111;
         4: seg_10 <= 'b0110_0110;
         5: seg_10 <= 'b0110_1101;
         6: seg_10 <= 'b0111_1101;
         7: seg_10 <= 'b0000_0111;
         8: seg_10 <= 'b0111_1111;
         9: seg_10 <= 'b0110_0111;
         10: seg_10 <= 'b0111_1000;
         11: seg_10 <= 'b0111_0011;
         12: seg_10 <= 'b0111_0111;
         13: seg_10 <= 'b0111_1100;
         14: seg_10 <= 'b0011_1001;
         15: seg_10 <= 'b0101_1110;
         16: seg_10 <= 'b0111_1001;
         17: seg_10 <= 'b0101_0000;
         18: seg_10 <= 'b0100_0000;
         19: seg_10 <= 'b0101_0100;
         20: seg_10 <= 'b0000_0000;
         21: seg_10 <= 'b0111_1100; 
         22: seg_10 <= 'b0011_1000; 
         23: seg_10 <= 'b0011_1110;
         24: seg_10 <= 'b0001_1100;
         25: seg_10 <= 'b0000_0110; 
         default: seg_10 <= 'b0000_0000;
      endcase
   end
   
   always @(set_no6) begin
      case (set_no6)
         0: seg_1 <= 'b0011_1111;
         1: seg_1 <= 'b0000_0110;
         2: seg_1 <= 'b0101_1011;
         3: seg_1 <= 'b0100_1111;
         4: seg_1 <= 'b0110_0110;
         5: seg_1 <= 'b0110_1101;
         6: seg_1 <= 'b0111_1101;
         7: seg_1 <= 'b0000_0111;
         8: seg_1 <= 'b0111_1111;
         9: seg_1 <= 'b0110_0111;
         10: seg_1 <= 'b0111_1000;
         11: seg_1 <= 'b0111_0011;
         12: seg_1 <= 'b0111_0111;
         13: seg_1 <= 'b0111_1100;
         14: seg_1 <= 'b0011_1001;
         15: seg_1 <= 'b0101_1110;
         16: seg_1 <= 'b0111_1001;
         17: seg_1 <= 'b0101_0000;
         18: seg_1 <= 'b0100_0000;
         19: seg_1 <= 'b0101_0100;
         20: seg_1 <= 'b0000_0000;
         21: seg_1 <= 'b0110_1101; 
         22: seg_1 <= 'b0111_1000; 
         23: seg_1 <= 'b0000_0110; 
         default: seg_1 <= 'b0000_0000;
      endcase
   end
   
   always @(posedge fnd_clk) begin
      fnd_cnt <= fnd_cnt + 1;
      case (fnd_cnt)
         5: begin
            fnd_d <= seg_100000;
            fnd_s <= 'b0101_1111;
         end
         
         4: begin
            fnd_d <= seg_10000;
            fnd_s <= 'b0110_1111;
         end
      
         3: begin
            fnd_d <= seg_1000;
            fnd_s <= 'b0111_0111;
         end

         2: begin
            fnd_d <= seg_100;
            fnd_s <= 'b0111_1011;
         end
         
         1: begin
            fnd_d <= seg_10;
            fnd_s <= 'b0111_1101;
         end
         
         0: begin
            fnd_d <= seg_1;
            fnd_s <= 'b0111_1110;
         end
      endcase
   end
   
endmodule
