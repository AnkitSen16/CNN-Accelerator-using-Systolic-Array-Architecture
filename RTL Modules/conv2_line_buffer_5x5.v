`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.05.2026 21:22:14
// Design Name: 
// Module Name: conv2_line_buffer_5x5
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

module conv2_line_buffer_5x5
#(
    parameter WIDTH     = 12,
    parameter DATA_BITS = 12
)
(
    input  wire                         clk,
    input  wire                         rst_n,
    input  wire                         valid_in,
    input  wire signed [DATA_BITS-1:0]  data_in,

    output reg                          valid_out,

    output reg signed [DATA_BITS-1:0] w00,w01,w02,w03,w04,
    output reg signed [DATA_BITS-1:0] w10,w11,w12,w13,w14,
    output reg signed [DATA_BITS-1:0] w20,w21,w22,w23,w24,
    output reg signed [DATA_BITS-1:0] w30,w31,w32,w33,w34,
    output reg signed [DATA_BITS-1:0] w40,w41,w42,w43,w44
);

reg signed [DATA_BITS-1:0] line0 [0:WIDTH-1];
reg signed [DATA_BITS-1:0] line1 [0:WIDTH-1];
reg signed [DATA_BITS-1:0] line2 [0:WIDTH-1];
reg signed [DATA_BITS-1:0] line3 [0:WIDTH-1];

reg [4:0] col;
reg [4:0] row;

integer i;

always @(posedge clk) begin
    if (!rst_n) begin
        col       <= 0;
        row       <= 0;
        valid_out <= 1'b0;

        for (i = 0; i < WIDTH; i = i + 1) begin
            line0[i] <= 0;
            line1[i] <= 0;
            line2[i] <= 0;
            line3[i] <= 0;
        end

        w00 <= 0; w01 <= 0; w02 <= 0; w03 <= 0; w04 <= 0;
        w10 <= 0; w11 <= 0; w12 <= 0; w13 <= 0; w14 <= 0;
        w20 <= 0; w21 <= 0; w22 <= 0; w23 <= 0; w24 <= 0;
        w30 <= 0; w31 <= 0; w32 <= 0; w33 <= 0; w34 <= 0;
        w40 <= 0; w41 <= 0; w42 <= 0; w43 <= 0; w44 <= 0;
    end
    else begin
        valid_out <= 1'b0;

        if (valid_in) begin
            // Horizontal shift
            w00 <= w01; w01 <= w02; w02 <= w03; w03 <= w04; w04 <= line3[col];
            w10 <= w11; w11 <= w12; w12 <= w13; w13 <= w14; w14 <= line2[col];
            w20 <= w21; w21 <= w22; w22 <= w23; w23 <= w24; w24 <= line1[col];
            w30 <= w31; w31 <= w32; w32 <= w33; w33 <= w34; w34 <= line0[col];
            w40 <= w41; w41 <= w42; w42 <= w43; w43 <= w44; w44 <= data_in;

            // Vertical update
            line3[col] <= line2[col];
            line2[col] <= line1[col];
            line1[col] <= line0[col];
            line0[col] <= data_in;

            if ((row >= 4) && (col >= 4))
                valid_out <= 1'b1;

            if (col == WIDTH-1) begin
                col <= 0;
                row <= row + 1'b1;
            end
            else begin
                col <= col + 1'b1;
            end
        end
    end
end

endmodule

