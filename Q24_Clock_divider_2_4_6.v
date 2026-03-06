/*Given an input clock signal, generate three output clock signals with 2x, 4x, and 6x the period of the input clock.
When resetn is active, then all clocks are reset to 0. When resetn becomes inactive again, all clocks should undergo their posedge transition and start an entirely new clock period. Specifically this means that if resetn became active in the middle of an output clock's period, when resetn becomes inactive the output clock should start an entirely new period instead of continuing from where the interrupted period left off.

Input and Output Signals
clk - Clock signal
resetn - Synchronous reset-low signal
div2 - Output clock with 2x the period of clk
div4 - Output clock with 4x the period of clk
div6 - Output clock with 6x the period of clk
*/

module model (
  input clk,
  input resetn,
  output logic div2,
  output logic div4,
  output logic div6
);
reg counter_2;
reg [1:0] counter_4;
reg [2:0] counter_6;
reg FF_2;
reg D;
assign div2 = (counter_2 == 1'b1 ) ? 1'b1 : 0;
assign div4 = (counter_4 <= 2'b10 && counter_4 >= 2'b01 ) ? 1'b1 : 0;
assign div6 = (counter_6 <= 3'b011 && counter_6 >= 3'b001) ? 1'b1 : 0;
always@(posedge clk)begin
  if(!resetn)begin
    div2 <= 0 ;
    div4 <= 0 ;
    div6 <= 0;
    counter_2 <=0;
    counter_4 <=0;
    counter_6<=0;
  end
  else begin
    counter_2 <= counter_2 + 1'b1;
    counter_4 <= counter_4 + 1'b1;
    counter_6 <= (counter_6 + 1'b1)%3'b110;  //MOD 6 counter

  end
end
endmodule
