/* This example calculates the second largest value from the x2, x6, x0, xe, xc sequence of values. Note that in the beginning, x0 is output first when there are fewer than two values in the sequence.

Once reset goes low again, all previous values in the sequence are discarded and we begin calculating the second largest value of the sequence x0, x1, x2. */

module model #(parameter
  DATA_WIDTH = 32
) (
  input clk,
  input resetn,
  input [DATA_WIDTH-1:0] din,
  output logic [DATA_WIDTH-1:0] dout
);

// Start here -->
reg [DATA_WIDTH-1:0]largest=0;
reg [DATA_WIDTH-1:0] second_largest;
assign dout = second_largest;
always@(posedge clk ) begin // In sync reset always@ doesnt have reset signal
  if(resetn==0)begin.   //Sync reset
    dout <= 0;
    largest <= 0;
    second_largest <= 0;
  end
  else begin
    if (din >= largest)begin. // as question had mentioned each repeated is also a new entry
      second_largest <= largest;
      largest<= din;
    end
    else if (din >= second_largest && din < largest)begin
      second_largest <=din;
    end
    end   
  end
endmodule