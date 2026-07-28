`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.05.2026 16:40:43
// Design Name: 
// Module Name: pe
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
module pe
#(
    parameter DATA_BITS   = 8,
    parameter WEIGHT_BITS = 8,
    parameter SUM_BITS    = 20
)
(
    input  wire clk,
    input  wire rst_n,
    input  wire signed [DATA_BITS-1:0]   data_in,
    input  wire signed [SUM_BITS-1:0]    sum_in,
    input  wire signed [WEIGHT_BITS-1:0] weight,
    output wire signed [DATA_BITS-1:0]   data_out,
    output reg  signed [SUM_BITS-1:0]    sum_out
);

    assign data_out = data_in;

    always @(posedge clk) begin
        if (!rst_n) begin
            sum_out <= 20'b0;
        end
        else begin
            sum_out <= sum_in + (data_in * weight);
        end
    end

endmodule
