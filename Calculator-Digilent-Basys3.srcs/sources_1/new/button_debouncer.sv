`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Everett Craw
// 
// Create Date: 03/19/2024 06:10:36 PM
// Design Name: 
// Module Name: button_debouncer
// Project Name: Calculator-Digilent-Basys3
// Target Devices: Digilent-Basys3
// Tool Versions: 
// Description: A module which prevents rapid oscillation of a signal caused by a button press.
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


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