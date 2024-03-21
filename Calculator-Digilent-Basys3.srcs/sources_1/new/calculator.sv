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
    output logic a [4],
    
    output logic s [3],
    output logic o [4]
);

localparam rst_time = 300000000;

logic n_rst;
logic [$clog2(rst_time+1)-1:0] rst_counter;
always_ff @(posedge clk) begin
    if(btnc_d) begin
        if(rst_counter < rst_time) begin
            rst_counter <= rst_counter + 1;
        end
        else begin
            n_rst <= 1'b0;
        end
    end
    else begin
        rst_counter <= 0;
        n_rst <= 1'b1;
    end
end

logic unsigned [13:0] display_value;
logic unsigned [13:0] alu_result;
logic unsigned [13:0] accumulator;
logic unsigned [13:0] user_value;

logic unsigned [13:0] sw_value;
assign sw_value = {<<{sw}};
assign user_value = (sw_value > 9999)? 9999 : sw_value;

CalcState state;
ALU_Op op;

always_comb begin
    unique case(state)
        OP0, OP1 : begin
            s = {1'b0, 1'b1, 1'b0};
        end
        ANSWER0, ANSWER1 : begin
            s = {1'b0, 1'b0, 1'b1};
        end
        default : begin
            s = {1'b1, 1'b0, 1'b0};
        end
    endcase
    unique case(op)
        ADD : begin
            o = {1'b1, 1'b0, 1'b0, 1'b0};
        end
        SUB : begin
            o = {1'b0, 1'b1, 1'b0, 1'b0};
        end
        MULT : begin
            o = {1'b0, 1'b0, 1'b1, 1'b0};
        end
        DIV : begin
            o = {1'b0, 1'b0, 1'b0, 1'b1};
        end
    endcase
end

localparam DB_CYCLES = 10000;

logic btnu_d;
logic btnd_d;
logic btnc_d;
logic btnl_d;
logic btnr_d;

button_debouncer #(.CYCLES(DB_CYCLES)) DB0
(
    .clk(clk),
    .btn(btnu),
    .btn_d(btnu_d)
);

button_debouncer #(.CYCLES(DB_CYCLES)) DB1
(
    .clk(clk),
    .btn(btnd),
    .btn_d(btnd_d)
);

button_debouncer #(.CYCLES(DB_CYCLES)) DB2
(
    .clk(clk),
    .btn(btnc),
    .btn_d(btnc_d)
);

button_debouncer #(.CYCLES(DB_CYCLES)) DB3
(
    .clk(clk),
    .btn(btnl),
    .btn_d(btnl_d)
);

button_debouncer #(.CYCLES(DB_CYCLES)) DB4
(
    .clk(clk),
    .btn(btnr),
    .btn_d(btnr_d)
);

state_machine STATE_MACHINE
(
    .clk(clk),
    .n_rst(n_rst),
    .btnu(btnu_d),
    .btnd(btnd_d),
    .btnc(btnc_d),
    .btnl(btnl_d),
    .btnr(btnr_d),
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
    .n_rst(n_rst),
    .in(display_value),
    .c(c),
    .a(a)
);
endmodule
