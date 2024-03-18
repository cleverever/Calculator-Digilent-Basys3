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
    typedef enum logic [1 : 0]
    {
        CLEAR,
        OP,
        ANSWER
    }
    CalcState;
    
    typedef enum logic [1 : 0]
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
    input [13:0] sw,
    input btnu,
    input btnd,
    input btnc,
    input btnl,
    input btnr,
    
    output ca,
    output cb,
    output cc,
    output cd,
    output ce,
    output cf,
    output cg,
    output a0,
    output a1,
    output a2,
    output a3
);

state_machine STATE_MACHINE
(
    
);

alu ALU
(
    
);

seven_segment_display_controller DISPLAY_CONTROLLER
(
    
);
endmodule
