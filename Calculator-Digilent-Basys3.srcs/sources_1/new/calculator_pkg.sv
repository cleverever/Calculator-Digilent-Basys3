`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/18/2024 06:00:14 PM
// Design Name: 
// Module Name: calculator_pkg
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
