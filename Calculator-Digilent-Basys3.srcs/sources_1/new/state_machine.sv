`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/18/2024 09:58:14 AM
// Design Name: 
// Module Name: state_machine
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

import calculator_pkg::*;

module state_machine
(
    input btnu,
    input btnd,
    input btnc,
    input btnl,
    input btnr,
    
    output CalcState state
);

logic btn_pressed;
assign btn_pressed = btnu | btnd | btnc | btnl | btnr;

always_ff @(posedge btn_pressed) begin
    case(state)
        CLEAR : begin
            if(btnc) begin
                state <= CLEAR;
            end
            else begin
                state <= OP;
            end
        end
        OP : begin
            if(btnc) begin
                state <= ANSWER;
            end
            else begin
                state <= OP;
            end
        end
        ANSWER : begin
            if(btnc) begin
                state <= CLEAR;
            end
            else begin
                state <= OP;
            end
        end
    endcase
end

endmodule