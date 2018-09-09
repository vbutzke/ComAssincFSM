`timescale 1ns / 1ps
module fsmCPU(send, dadoCPU, dadoT, ack, clock, reset);

output reg [1:0] send;
output reg [1:0] dadoT;
output reg [1:0] ack;
  
input clock;
input reset;
input [1:0] dadoCPU;

reg [1:0] state;
reg [1:0] nextState;
  
    always @ (posedge clock)
        begin
            if(reset == 1)
                state <= 0;
            else
                state <= nextState;
        end

    always @ (*)
        begin
            if (state != ack)
                nextState = state;
            else
              nextState = !(state);
        end
    always @ (*)
        begin
          if(state == 0) begin
                send = 0;
                dadoT = 0;
          end
            else begin
                send = 1;
                dadoT = dadoCPU;
            end
        end

endmodule


`timescale 1ns / 1ps
module fsmPeriferico(ack, dadoPeriferico, dadoT, send, clock, reset);

output reg [1:0] ack;
output reg [1:0] dadoPeriferico;
output reg [1:0] send;

input clock;
input reset;
input [1:0] dadoT;
  
reg [1:0] state;
reg [1:0] nextState;

    always @ (posedge clock)
        begin
            if(reset == 1)
                state <= 0;
            else
                state <= nextState;
        end

    always @ (*)
        begin
            if (state != send)
                nextState = state;
            else
              nextState = !(state);
                
        end

    always @ (*)
        begin
          if(state == 0) begin
                ack = 0;
                dadoPeriferico = 0;
          end
            else begin
                ack = 1;
                dadoPeriferico = dadoT;
            end

        end

endmodule