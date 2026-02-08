module TB_D_FF;
   reg clk , d, rst_n, qb, q;
   
   DFF DFF0(.clk(clk) , .d(d) , .rst_n(rst_n) , .qb(qb) , .q(q));

   reg expected_out;
   reg prev_d;
   integer i; // use integer for loops in simulation
   assign expected_out = prev_d;
   function bit check;  //bit is the return type of function //This is a function to check the maths - software
      input expected_out;
      input out;
      if ( expected_out === out) begin
         check = 1'b1;   //We will use this value to Display output
      end
      else begin
         check = 1'b0;
      end
   endfunction 
      
   //This block Sets the test input values
   initial begin
      rst_n = 0;
      #1;
      rst_n = 1;
      d = 0;
      for ( i = 0 ; i < 10 ; i = i+1) begin
         #1 clk  = 1'b0;
         d = $urandom_range(0,1)[0]; //choosing a random bit value
         
         if (check (expected_out , q)) begin 
            $display("PASS @ %0t: q=%0b,d=%0b, expected=%0b", $time, q,d, expected_out);
         end
         else begin
            $display("FAIL @ %0t: q=%0b,d=%0b, expected=%0b", $time, q,d, expected_out);
         end
         #1 clk = 1'b1;
      end
   #10 $finish;
   end
   always @(posedge clk) begin
      prev_d <= d;
   end
endmodule
  
         
