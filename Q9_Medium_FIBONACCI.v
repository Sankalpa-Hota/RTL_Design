/*Design a circuit which generates the Fibonacci sequence starting with 1 and 1 as the first two numbers.
The Fibonacci sequence is a sequence of numbers where each number is the sum of the two previous numbers. More formally this can be expressed as:
F0 = 1
F1 = 1
Fn = Fn-1 + Fn-2 for n > 1.
Following the definition of the Fibonacci sequence above we can see that the sequence is 1, 1, 2, 3, 5, 8, 13, etc.
The sequence should be produced when the active low signal (resetn) becomes active. In other words, the sequence should restart from 1 followed by another 1 (the Fibonacci sequence's initial condition) as soon as resetn becomes active.*/

module model #(parameter
  DATA_WIDTH=32
) (
  input clk,
  input resetn,
  output logic [DATA_WIDTH-1:0] out
);
reg [DATA_WIDTH-1:0] number;
reg [DATA_WIDTH-1:0] number_1;
reg [DATA_WIDTH-1:0] temp;
assign out = number;
always@(posedge clk)begin
  if(!resetn)begin
    number <= {{DATA_WIDTH-1{1'b0}},{1'b1}}; //current
    number_1 <= {DATA_WIDTH{1'b0}};  //prev
  end
  else begin
    number <= number+number_1;
    number_1 <= number;
  end
end

endmodule

//We learn how the unblocking prevents the software implementation of using a temp reg to store and update the number_1 ( prev_number)
Logic is 
/*Prev = 0 , curr = 1 , out = 1 (time 0)
Prev = 1 ( non blocking so it appears as 1 for next cycle) , curr = 1+0 , out =1 ( first cycle) // we take the prev value before the update
*/