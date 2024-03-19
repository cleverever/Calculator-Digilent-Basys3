`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/18/2024 09:27:56 AM
// Design Name: 
// Module Name: calculator
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

module calculator
(
    input logic [13:0] sw,
    input logic btnu,
    input logic btnd,
    input logic btnc,
    input logic btnl,
    input logic btnr,
    
    output logic c [7],
    output logic a [4]
);

logic clk;

logic [13:0] display_value;
logic [13:0] alu_result;
logic [13:0] accumulator;
logic [13:0] user_value;

CalcState state;
ALU_Op op;

state_machine STATE_MACHINE
(
    .btnu(btnu),
    .btnd(btnd),
    .btnc(btnc),
    .btnl(btnl),
    .btnr(btnr),
    .user_value(user_value),
    .alu_value(alu_result),
    
    .state(state),
    .op(op),
    .accumulator(accumulator),
    .display_value(display_value)
);


alu ALU
(
    .op(op),
    .in0(accumulator),
    .in1(user_value),
    .out(alu_result)
);

seven_segment_display_controller #(.N(4)) DISPLAY_CONTROLLER
(
    .clk(clk),
    .in(display_value),
    .c(c),
    .a(a)
);
endmodule
