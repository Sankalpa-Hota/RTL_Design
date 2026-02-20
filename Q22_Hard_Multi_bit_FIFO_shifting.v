/* Design a multi-bit First In First Out (FIFO) circuit.  The FIFO includes two entries of size DATA_WIDTH and requires zero output latency. 

Upon assertion of resetn (active-low), the FIFO is reset to zero and the empty signal is set to logic high to indicate the FIFO is empty.  Once resetn is unpressed, the operation starts.  The FIFO has a two-entry bank of flip-flops that can be written to by using inputs din (data in) and wr (write-enable).  If wr is set to logic low, the input din does not get written to the FIFO.
As the FIFO is being written to, its output port dout should imediatelly reflect the first-in data, i.e., there should be no latency between inputs and outputs.  Once all entries are written to, the FIFO should output full = 1 in order to indicate it is full.  Writing to a full FIFO is a valid operation and the output full must be set to one.
Important :There are at least three possible states in this design:  (1) Empty;  (2) Intermediate;  (3) Full.  Whenever the FIFO is reset, it transitions to state (1).  As the entries are updated, the state switches from (1) to (2), and finally from (2) to (3), once completely filled.  Use a mux to direct the intermediate stages of the FIFO to the output port dout to achieve a low latency design.

Input and Output Signals
clk - Clock signal
resetn - Active-low, reset signal
din - FIFO input data
wr - Active-high, write signal
dout - FIFO output data
full - Full FIFO indicator
empty - Empty FIFO indicator
Output signals during reset
dout - 0
full - 0
empty - 1 */

module model #(parameter
    DATA_WIDTH=8
) (
    input clk,
    input resetn,
    input [DATA_WIDTH-1:0] din,
    input wr,
    output logic [DATA_WIDTH-1:0] dout,
    output logic full,
    output logic empty
);
integer i;
integer depth=2;
integer wr_ptr=0;
reg [DATA_WIDTH-1:0] fifo_m [1:0]; //2 entry fifo
  
assign dout = (!empty) ? fifo_m[wr_ptr-1]:'0; //Check empty always while fetching information
assign empty = (wr_ptr == 1'b0);
assign full = (wr_ptr == depth); //FIFO is full when we have reached the FIFO DEPTH
  
always@(posedge clk)begin
    if(!resetn)begin
        for(i=0;i<2;i=i+1)begin
            fifo_m[i]<=0;
        end
        empty<=1'b1;
        wr_ptr<=0;
        full<=0;
    end
    else if(wr)begin
      fifo_m[0]<=din;  //Data always loads to the first 1st Fifo
      for(i=1;i<2;i=i+1)begin  //Simultaneously the first FF data moves to the next
            fifo_m[i]<=fifo_m[i-1];
        end
        wr_ptr = (wr_ptr!= depth) ? wr_ptr +1 : depth;


    end
end
endmodule

//We tried pointer based FIFO as well which is faster compared to shift based FIFO , Shifting shows true FIFO behaviour.
