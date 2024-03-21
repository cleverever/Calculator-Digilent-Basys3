`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Everett Craw
// 
// Create Date: 03/18/2024 09:27:56 AM
// Design Name: 
// Module Name: 7_segment-display_controller
// Project Name: Calculator-Digilent-Basys3
// Target Devices: Digilent-Basys3
// Tool Versions: 
// Description: A module which can display a binary integer as a decimal integer on
// a 7-segment display. Adjust N to change the number of digits that are to be displayed.
// 
// Dependencies: NONE
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module seven_segment_display_controller #(parameter N = 4)
(
    input logic clk,
    input logic n_rst,
    
    input logic unsigned [13:0] in,
    
    output logic c [7],
    output logic a [N]
);

logic [15:0] clk_div;
always_ff @(posedge clk) begin
    clk_div <= clk_div + 1;
end

logic [6:0] encoding [N];
logic [3:0] digit [N];

//Generates encoding logic for each digit and rapidly switches between
//each digit to momentarily display its value.
generate
if(N > 1) begin
    logic unsigned [$clog2(N)-1:0] counter;
    always_ff @(posedge clk_div[15] or negedge n_rst) begin
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
            c = {default : 1'b1};
            a = {default : 1'b1};
        end
        else begin
            c = {>>{encoding[counter]}};
            a = {default : 1'b1};
            a[counter] = 1'b0;
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
                encoding[i] = 7'b0000001;
            end
            1 : begin
                encoding[i] = 7'b1001111;
            end
            2 : begin
                encoding[i] = 7'b0010010;
            end
            3 : begin
                encoding[i] = 7'b0000110;
            end
            4 : begin
                encoding[i] = 7'b1001100;
            end
            5 : begin
                encoding[i] = 7'b0100100;
            end
            6 : begin
                encoding[i] = 7'b0100000;
            end
            7 : begin
                encoding[i] = 7'b0001111;
            end
            8 : begin
                encoding[i] = 7'b0000000;
            end
            9 : begin
                encoding[i] = 7'b0000100;
            end
        endcase
    end
end

endmodule
