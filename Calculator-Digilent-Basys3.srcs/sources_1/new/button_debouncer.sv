`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/19/2024 06:10:36 PM
// Design Name: 
// Module Name: button_debouncer
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

module button_debouncer #(parameter CYCLES = 100)
(
    input logic clk,
    input logic btn,
    output logic btn_d
);

logic unsigned [$clog2(CYCLES+1)-1 : 0] counter;

always_ff @(posedge clk) begin
    if(btn) begin
        if(counter < CYCLES) begin
            counter <= counter + 1;
        end
        else begin
            btn_d <= 1'b1;
        end
    end
    else begin
        if(counter > 0) begin
            counter <= counter - 1;
        end
        else begin
            btn_d <= 1'b0;
        end
    end
end

endmodule
