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
    input logic clk,
    
    input logic sw [14],
    input logic btnu,
    input logic btnd,
    input logic btnc,
    input logic btnl,
    input logic btnr,
    
    output logic c [7],
    output logic a [4]
);

localparam rst_time = 5000;

logic n_rst;
logic [$clog2(rst_time)-1:0] rst_counter;
always_ff @(posedge clk) begin
    if(btnc) begin
        if(rst_counter < rst_time) begin
            rst_counter <= rst_counter + 1;
        end
        else begin
            n_rst <= 0;
        end
    end
    else begin
        rst_counter <= 0;
        n_rst <= 1;
    end
end

logic [13:0] display_value;
logic [13:0] alu_result;
logic [13:0] accumulator;
logic [13:0] user_value;

assign user_value = {>>{sw}};

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
    .n_rst(n_rst),
    .op(op),
    .in0(accumulator),
    .in1(user_value),
    .out(alu_result)
);

seven_segment_display_controller #(.N(4)) DISPLAY_CONTROLLER
(
    .clk(clk),
    .n_rst(n_rst),
    .in(display_value),
    .c(c),
    .a(a)
);
endmodule
