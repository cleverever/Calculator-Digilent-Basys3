`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Everett Craw
// 
// Create Date: 03/18/2024 09:27:56 AM
// Design Name: 
// Module Name: alu
// Project Name: Calculator-Digilent-Basys3
// Target Devices: Digilent-Basys3
// Tool Versions: 
// Description: A simple ALU which can perform addition, subtraction, multiplication,
// and division on 2 unsigned integers ranging from 0-9999.
// 
// Dependencies: calculator_pkg.sv
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
