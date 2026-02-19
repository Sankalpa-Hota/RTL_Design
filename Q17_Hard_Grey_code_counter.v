/*Build a circuit that generates a Gray code sequence starting from 0 on the output (dout).

Gray code is an ordering of binary numbers such that two successive values only have one bit difference between them. For example, a Gray code sequence for a two bit value could be:

b00
b01
b11
b10

The Gray code sequence should use the standard encoding. In the standard encoding the least significant bit follows a repetitive pattern of 2 on, 2 off ( ... 11001100 ... ); the next digit a pattern of 4 on, 4 off ( ... 1111000011110000 ... ); the nth least significant bit a pattern of 2n on 2n off.

When the reset-low signal (resetn) goes to 0, the Gray code sequence should restart from 0.

Input and Output Signals
clk - Clock signal
resetn - Synchronous reset-low signal
out - Gray code counter value
Output signals during reset
out - 0 when resetn is active*/

module model #(parameter
  DATA_WIDTH = 4
) (
  input clk,
  input resetn,
  output logic [DATA_WIDTH-1:0] out
);
integer i;
assign out = temp_1;
reg [DATA_WIDTH-1:0] temp_out;
reg [DATA_WIDTH-1:0] temp_1;

always@(posedge clk)begin
  if(!resetn)begin
    temp_1 <=0;
    temp_out<=1;  //Based on the question we were 1 cycle behin so started the counter from 1 as reset takes care of 0
  end
  else begin
    temp_out <= temp_out + 1'b1;
    
    for(i=0;i<DATA_WIDTH-1;i=i+1)begin
      temp_1[i]<=temp_out[i+1]^temp_out[i];    //This is the XOR logic to convert from binary to grey
    end
    temp_1[DATA_WIDTH-1]<=temp_out[DATA_WIDTH-1]; //we retain the MSB for binary to grey
  end
end
      
endmodule

//Logic is to have a binary counter and convert it to grey.
