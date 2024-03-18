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

package calculator_pkg;
    typedef enum logic [1:0]
    {
        CLEAR,
        OP,
        ANSWER
    }
    CalcState;
    
    typedef enum logic [1:0]
    {
        ADD,
        SUB,
        MULT,
        DIV
    }
    ALU_Op;
endpackage

module calculator
(
    input logic [13:0] sw,
    input logic btnu,
    input logic btnd,
    input logic btnc,
    input logic btnl,
    input logic btnr,
    
    output logic ca,
    output logic cb,
    output logic cc,
    output logic cd,
    output logic ce,
    output logic cf,
    output logic cg,
    output logic a0,
    output logic a1,
    output logic a2,
    output logic a3
);

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

seven_segment_display_controller DISPLAY_CONTROLLER
(
    .in(display_value),
    .ca(),
    .cb(),
    .cc(),
    .cd(),
    .ce(),
    .cf(),
    .cg(),
    .a0(),
    .a1(),
    .a2(),
    .a3()
);
endmodule
