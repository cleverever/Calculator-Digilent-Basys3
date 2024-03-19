`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/18/2024 09:27:56 AM
// Design Name: 
// Module Name: 7_segment-display_controller
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

module seven_segment_display_controller #(parameter N = 4)
(
    input logic clk,
    input logic n_rst,
    input logic [13:0] in,
    output logic c [7],
    output logic a [N]
);

logic [6:0] encoding [N];
logic [3:0] digit [N];

generate
if(N > 1) begin
    logic [$clog2(N)-1:0] counter;
    always_ff @(posedge clk or negedge n_rst) begin
        if(~n_rst) begin
            counter <= 0;
        end
        else begin
            if(counter < N - 1) begin
                counter <= counter + 1;
            end
            else begin
                counter <= 0;
            end
        end
    end
    
    always_comb begin
        if(~n_rst) begin
            c = {default : 1'b0};
            a = {default : 1'b0};
        end
        else begin
            c = {>>{encoding[counter]}};
            a = {default : 1'b0};
            a[counter] = 1'b1;
        end
    end
end
else begin
    assign a[0] = 1'b1;
end
endgenerate

for(genvar i = 0; i < N; i++) begin
    always_comb begin
        digit[i] = (in / (10 ** i)) % 10;
        case(digit[i])
            0 : begin
                encoding[i] = 7'b1111110;
            end
            1 : begin
                encoding[i] = 7'b0110000;
            end
            2 : begin
                encoding[i] = 7'b1101101;
            end
            3 : begin
                encoding[i] = 7'b1111001;
            end
            4 : begin
                encoding[i] = 7'b0110011;
            end
            5 : begin
                encoding[i] = 7'b1011011;
            end
            6 : begin
                encoding[i] = 7'b1011111;
            end
            7 : begin
                encoding[i] = 7'b1110000;
            end
            8 : begin
                encoding[i] = 7'b1111111;
            end
            9 : begin
                encoding[i] = 7'b1111011;
            end
        endcase
    end
end

endmodule
