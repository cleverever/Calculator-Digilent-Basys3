`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Everett Craw
// 
// Create Date: 03/18/2024 09:58:14 AM
// Design Name: 
// Module Name: state_machine
// Project Name: Calculator-Digilent-Basys3
// Target Devices: Digilent-Basys3
// Tool Versions: 
// Description: A state machine to keep track of the operands, operator, and
// calculation state.
// 
// Dependencies: calculator_pkg.sv
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


import calculator_pkg::*;

module state_machine
(
    input logic clk,
    input logic n_rst,
    
    input logic btnu,
    input logic btnd,
    input logic btnc,
    input logic btnl,
    input logic btnr,
    
    input logic unsigned [13:0] user_value,
    input logic unsigned [13:0] alu_value,
    
    output CalcState state,
    output ALU_Op op,
    
    output logic unsigned [13:0] accumulator,
    output logic unsigned [13:0] display_value
);

logic op_pressed;
assign op_pressed = btnu | btnd | btnl | btnr;

//0 after a state is the waiting state for the button to be release.
//1 after a state is the ready state to respond to the next button press.
//
//CLEAR :   Accumulator is set to 0, user is entering the first
//          operand for the calculation.
//OP :      Operation has been selected and the user is entering the
//          second operand for the calculation. Operation can be switched
//          at this state without clearing accumulator.
//ANSWER:   The ALU's result has been stored to the accumulator and is being
//          displayed. An operation may be selected to continue to use the
//          accumulator as an operand or the clear/answer button may be pressed
//          a second time to reset the accumulator to 0 and the state to CLEAR.

always_comb begin
    unique case(state)
        OP0, OP1 : begin
            display_value = user_value;
        end
        ANSWER0, ANSWER1 : begin
            display_value = accumulator;
        end
        default : begin
            display_value = user_value;
        end
    endcase
end

always_ff @(posedge clk or negedge n_rst) begin
    if(~n_rst) begin
        state <= CLEAR0;
        op <= ADD;
    end
    else begin
        if(btnu) begin
            op <= ADD;
        end
        else if(btnd) begin
            op <= DIV;
        end
        else if(btnl) begin
            op <= SUB;
        end
        else if(btnr) begin
            op <= MULT;
        end
        else begin
            op <= op;
        end
        case(state)
            CLEAR1 : begin
                if(btnc) begin
                    state <= CLEAR0;
                    accumulator <= 0;
                end
                else if(op_pressed) begin
                    state <= OP0;
                    accumulator <= limit_value(user_value);
                end
                else begin
                    state <= CLEAR0;
                    accumulator <= accumulator;
                end
            end
            OP0 : begin
                if(~op_pressed) begin
                    state <= OP1;
                    accumulator <= accumulator;
                end
            end
            OP1 : begin
                if(btnc) begin
                    state <= ANSWER0;
                    accumulator <= limit_value(alu_value);
                end
                else begin
                    state <= OP1;
                    accumulator <= accumulator;
                end
            end
            ANSWER0 : begin
                if(~btnc) begin
                    state <= ANSWER1;
                    accumulator <= accumulator;
                end
                else begin
                    state <= ANSWER0;
                    accumulator <= accumulator;
                end
            end
            ANSWER1 : begin
                if(btnc) begin
                    state <= CLEAR0;
                    accumulator <= 0;
                end
                else if(op_pressed) begin
                    state <= OP0;
                    accumulator <= accumulator;
                end
                else begin
                    state <= state;
                    accumulator <= accumulator;
                end
            end
            default : begin
                if(~btnc) begin
                    state <= CLEAR1;
                    accumulator <= accumulator;
                end
            end
        endcase
    end
end

function logic [13:0] limit_value(input logic [13:0] value);
    return value > 9999? 9999 : value;
endfunction

endmodule
