`timescale 1ns / 1ps

module testCPU;

    // Inputs
  
    reg clock;
    reg reset;
	reg [1:0] dadoCPU;
  
    // Outputs
    wire [1:0] send;
    
    wire [1:0] ack;
    wire [1:0] dadoPeriferico;
    wire [1:0] dadoT; //dado na área de transferência

    // Instantiate the Unit Under Test (UUT)
    fsmCPU uutcpu (
      .send(send),
      .dadoCPU(dadoCPU),
      .dadoT(dadoT),
      .ack(ack),  
      .clock(clock),  
      .reset(reset)
    );
  
    fsmPeriferico uutper (
      .ack(ack),
      .dadoPeriferico(dadoPeriferico),
      .dadoT(dadoT),
      .send(send),  
      .clock(clock),  
      .reset(reset)
    );
  

    initial begin
      $dumpfile("dump.vcd");
      $dumpvars;
        // Initialize Inputs
      	clock          = 0;
        reset          = 1;
        dadoCPU        = 0;
      
        // Wait 100 ns for global reset to finish
        #100;
        reset = 0;
        #100
         
        // Add stimulus here
        dadoCPU = 1;
        #50;
		dadoCPU = 0;
        #10;
        dadoCPU = 1;
        #30;
        dadoCPU = 0; 
      $finish;
    end
   always #5 clock = !clock;
endmodule