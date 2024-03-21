`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/18/2024 09:27:56 AM
// Design Name: 
// Module Name: alu
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

module alu
(
    input ALU_Op op,
    input logic unsigned [13:0] in0,
    input logic unsigned [13:0] in1,
    output logic unsigned [13:0] out
);

always_comb begin
    unique case(op)
        ADD : begin
            out = (in0 + in1) > 9999? 9999 : (in0 + in1);
        end
        SUB : begin
            out = (in0 - in1) < 0? 0 : (in0 - in1);
        end
        MULT : begin
            out = (in0 * in1) > 9999? 9999 : (in0 * in1);
        end
        DIV : begin
            out = in0 / in1;
        end
    endcase
end
endmodule
