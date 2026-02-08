//Async D Flip Flop Design
module DFF ( input clk , rst_n , d ,
        output qb,
        output reg q );
  assign qb = ~q;
  always@ (posedge clk or negedge rst_n)begin   //Use or instead of , for setting conditions in @always
    if ( !rst_n ) begin
      q  <= 0;
    end
    else begin
      q <= d;
    end
  end
endmodule

// Industry standard is using negedge rst as asynchronous so that they reduce power loss. 1->0 has low power loss compared to 0->1
// qb we have kept wire to reduce hardware cost of additonal flop . If we keep qb inside the always then it will be 2 flops.

    
