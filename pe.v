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
// my code
module pe
#(
    parameter DATA_BITS   = 8,
    parameter WEIGHT_BITS = 8,
    parameter SUM_BITS    = 20
)
(
    input  wire                         clk,
    input  wire                         rst_n,

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
//sir's code
//module pe
//#(
//    parameter DATA_BITS   = 8,
//    parameter WEIGHT_BITS = 8,
//    parameter SUM_BITS    = 20
//)
//(
//    input  wire                         clk,
//    input  wire                         rst_n,

//    input  wire signed [DATA_BITS-1:0]   data_in,
//    input  wire signed [SUM_BITS-1:0]    sum_in,
//    input  wire signed [WEIGHT_BITS-1:0] weight,

//    output reg  signed [DATA_BITS-1:0]   data_out,
//    output reg  signed [SUM_BITS-1:0]    sum_out
//);

//////////////////////////////////////////////////////////////
//// PIPELINE REGISTERS
//////////////////////////////////////////////////////////////

//(* use_dsp = "yes" *)
//reg signed [SUM_BITS-1:0] mult_result;

//reg signed [SUM_BITS-1:0] sum_in_r;

//////////////////////////////////////////////////////////////
//// PIPELINED PE
//////////////////////////////////////////////////////////////

//always @(posedge clk) begin

//    if (!rst_n) begin

//        data_out    <= 0;

//        mult_result <= 0;
//        sum_in_r    <= 0;

//        sum_out     <= 0;

//    end
//    else begin

//        //--------------------------------------------------
//        // STAGE 1 : MULTIPLY
//        //--------------------------------------------------

//        data_out <= data_in;

//        mult_result <=
//            $signed(data_in) *
//            $signed(weight);

//        sum_in_r <= sum_in;

//        //--------------------------------------------------
//        // STAGE 2 : ADD
//        //--------------------------------------------------

//        sum_out <= sum_in_r + mult_result;

//    end
//end

//endmodule

