`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.05.2026 17:48:52
// Design Name: 
// Module Name: comparator
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


module comparator
(
    input  wire               clk,
    input  wire               rst_n,
    input  wire               valid_in,
    input  wire signed [11:0] data_in,
    output reg  [3:0]         decision,
    output reg                valid_out
);

reg [3:0] buf_idx;
reg signed [11:0] max_score;
reg [3:0] max_idx;

always @(posedge clk) begin
    if (~rst_n) begin
        buf_idx <= 0;
        max_score <= 0;
        max_idx <= 0;
        decision <= 0;
        valid_out <= 0;
    end
    else begin
        valid_out <= 0;

        if (valid_in) begin
            if (buf_idx == 0) begin
                max_score <= data_in;
                max_idx <= 4'd0;
            end
            else begin
                if (data_in > max_score) begin
                    max_score <= data_in;
                    max_idx <= buf_idx;
                end
            end

            if (buf_idx == 9) begin
                if (data_in > max_score)
                    decision <= 4'd9;
                else
                    decision <= max_idx;

                valid_out <= 1'b1;
                buf_idx <= 0;
            end
            else begin
                buf_idx <= buf_idx + 1'b1;
            end
        end
    end
end

endmodule