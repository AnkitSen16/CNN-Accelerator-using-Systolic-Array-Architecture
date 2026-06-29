`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.05.2026 21:23:48
// Design Name: 
// Module Name: conv2_systolic_array_5x5
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


module conv2_systolic_array_5x5
#(
    parameter DATA_BITS   = 12,
    parameter WEIGHT_BITS = 8,
    parameter ACC_BITS    = 20,
    parameter WEIGHT_FILE = "conv2_weight_11.mem"
)
(
    input  wire                         clk,
    input  wire                         rst_n,
    input  wire                         valid_in,

    input  wire signed [DATA_BITS-1:0] a00,a01,a02,a03,a04,
    input  wire signed [DATA_BITS-1:0] a10,a11,a12,a13,a14,
    input  wire signed [DATA_BITS-1:0] a20,a21,a22,a23,a24,
    input  wire signed [DATA_BITS-1:0] a30,a31,a32,a33,a34,
    input  wire signed [DATA_BITS-1:0] a40,a41,a42,a43,a44,

    output wire signed [ACC_BITS-1:0]  conv_raw,
    output wire                        valid_out
);

reg signed [WEIGHT_BITS-1:0] weight [0:24];

initial begin
    $readmemh(WEIGHT_FILE, weight);
end

wire signed [DATA_BITS-1:0] data [0:24];

assign data[0]  = a00;
assign data[1]  = a01;
assign data[2]  = a02;
assign data[3]  = a03;
assign data[4]  = a04;

assign data[5]  = a10;
assign data[6]  = a11;
assign data[7]  = a12;
assign data[8]  = a13;
assign data[9]  = a14;

assign data[10] = a20;
assign data[11] = a21;
assign data[12] = a22;
assign data[13] = a23;
assign data[14] = a24;

assign data[15] = a30;
assign data[16] = a31;
assign data[17] = a32;
assign data[18] = a33;
assign data[19] = a34;

assign data[20] = a40;
assign data[21] = a41;
assign data[22] = a42;
assign data[23] = a43;
assign data[24] = a44;


wire signed [DATA_BITS-1:0] pe_data_out [0:24];
(* use_dsp = "no" *)
wire signed [ACC_BITS-1:0]  pe_sum      [0:24];

pe #(.DATA_BITS(DATA_BITS), .WEIGHT_BITS(WEIGHT_BITS), .SUM_BITS(ACC_BITS))
pe_inst1 (
    .clk(clk),
    .rst_n(rst_n),
    .data_in(data[0]),
    .sum_in({ACC_BITS{1'b0}}),
    .weight(weight[0]),
    .data_out(pe_data_out[0]),
    .sum_out(pe_sum[0])
);

pe #(.DATA_BITS(DATA_BITS), .WEIGHT_BITS(WEIGHT_BITS), .SUM_BITS(ACC_BITS))
pe_inst2 (
    .clk(clk),
    .rst_n(rst_n),
    .data_in(data[1]),
    .sum_in({ACC_BITS{1'b0}}),
    .weight(weight[1]),
    .data_out(pe_data_out[1]),
    .sum_out(pe_sum[1])
);

pe #(.DATA_BITS(DATA_BITS), .WEIGHT_BITS(WEIGHT_BITS), .SUM_BITS(ACC_BITS))
pe_inst3 (
    .clk(clk),
    .rst_n(rst_n),
    .data_in(data[2]),
    .sum_in({ACC_BITS{1'b0}}),
    .weight(weight[2]),
    .data_out(pe_data_out[2]),
    .sum_out(pe_sum[2])
);

pe #(.DATA_BITS(DATA_BITS), .WEIGHT_BITS(WEIGHT_BITS), .SUM_BITS(ACC_BITS))
pe_inst4 (
    .clk(clk),
    .rst_n(rst_n),
    .data_in(data[3]),
    .sum_in({ACC_BITS{1'b0}}),
    .weight(weight[3]),
    .data_out(pe_data_out[3]),
    .sum_out(pe_sum[3])
);

pe #(.DATA_BITS(DATA_BITS), .WEIGHT_BITS(WEIGHT_BITS), .SUM_BITS(ACC_BITS))
pe_inst5 (
    .clk(clk),
    .rst_n(rst_n),
    .data_in(data[4]),
    .sum_in({ACC_BITS{1'b0}}),
    .weight(weight[4]),
    .data_out(pe_data_out[4]),
    .sum_out(pe_sum[4])
);

pe #(.DATA_BITS(DATA_BITS), .WEIGHT_BITS(WEIGHT_BITS), .SUM_BITS(ACC_BITS))
pe_inst6 (
    .clk(clk),
    .rst_n(rst_n),
    .data_in(data[5]),
    .sum_in({ACC_BITS{1'b0}}),
    .weight(weight[5]),
    .data_out(pe_data_out[5]),
    .sum_out(pe_sum[5])
);

pe #(.DATA_BITS(DATA_BITS), .WEIGHT_BITS(WEIGHT_BITS), .SUM_BITS(ACC_BITS))
pe_inst7 (
    .clk(clk),
    .rst_n(rst_n),
    .data_in(data[6]),
    .sum_in({ACC_BITS{1'b0}}),
    .weight(weight[6]),
    .data_out(pe_data_out[6]),
    .sum_out(pe_sum[6])
);

pe #(.DATA_BITS(DATA_BITS), .WEIGHT_BITS(WEIGHT_BITS), .SUM_BITS(ACC_BITS))
pe_inst8 (
    .clk(clk),
    .rst_n(rst_n),
    .data_in(data[7]),
    .sum_in({ACC_BITS{1'b0}}),
    .weight(weight[7]),
    .data_out(pe_data_out[7]),
    .sum_out(pe_sum[7])
);

pe #(.DATA_BITS(DATA_BITS), .WEIGHT_BITS(WEIGHT_BITS), .SUM_BITS(ACC_BITS))
pe_inst9 (
    .clk(clk),
    .rst_n(rst_n),
    .data_in(data[8]),
    .sum_in({ACC_BITS{1'b0}}),
    .weight(weight[8]),
    .data_out(pe_data_out[8]),
    .sum_out(pe_sum[8])
);

pe #(.DATA_BITS(DATA_BITS), .WEIGHT_BITS(WEIGHT_BITS), .SUM_BITS(ACC_BITS))
pe_inst10 (
    .clk(clk),
    .rst_n(rst_n),
    .data_in(data[9]),
    .sum_in({ACC_BITS{1'b0}}),
    .weight(weight[9]),
    .data_out(pe_data_out[9]),
    .sum_out(pe_sum[9])
);

pe #(.DATA_BITS(DATA_BITS), .WEIGHT_BITS(WEIGHT_BITS), .SUM_BITS(ACC_BITS))
pe_inst11 (
    .clk(clk),
    .rst_n(rst_n),
    .data_in(data[10]),
    .sum_in({ACC_BITS{1'b0}}),
    .weight(weight[10]),
    .data_out(pe_data_out[10]),
    .sum_out(pe_sum[10])
);

pe #(.DATA_BITS(DATA_BITS), .WEIGHT_BITS(WEIGHT_BITS), .SUM_BITS(ACC_BITS))
pe_inst12 (
    .clk(clk),
    .rst_n(rst_n),
    .data_in(data[11]),
    .sum_in({ACC_BITS{1'b0}}),
    .weight(weight[11]),
    .data_out(pe_data_out[11]),
    .sum_out(pe_sum[11])
);

pe #(.DATA_BITS(DATA_BITS), .WEIGHT_BITS(WEIGHT_BITS), .SUM_BITS(ACC_BITS))
pe_inst13 (
    .clk(clk),
    .rst_n(rst_n),
    .data_in(data[12]),
    .sum_in({ACC_BITS{1'b0}}),
    .weight(weight[12]),
    .data_out(pe_data_out[12]),
    .sum_out(pe_sum[12])
);

pe #(.DATA_BITS(DATA_BITS), .WEIGHT_BITS(WEIGHT_BITS), .SUM_BITS(ACC_BITS))
pe_inst14 (
    .clk(clk),
    .rst_n(rst_n),
    .data_in(data[13]),
    .sum_in({ACC_BITS{1'b0}}),
    .weight(weight[13]),
    .data_out(pe_data_out[13]),
    .sum_out(pe_sum[13])
);

pe #(.DATA_BITS(DATA_BITS), .WEIGHT_BITS(WEIGHT_BITS), .SUM_BITS(ACC_BITS))
pe_inst15 (
    .clk(clk),
    .rst_n(rst_n),
    .data_in(data[14]),
    .sum_in({ACC_BITS{1'b0}}),
    .weight(weight[14]),
    .data_out(pe_data_out[14]),
    .sum_out(pe_sum[14])
);

pe #(.DATA_BITS(DATA_BITS), .WEIGHT_BITS(WEIGHT_BITS), .SUM_BITS(ACC_BITS))
pe_inst16 (
    .clk(clk),
    .rst_n(rst_n),
    .data_in(data[15]),
    .sum_in({ACC_BITS{1'b0}}),
    .weight(weight[15]),
    .data_out(pe_data_out[15]),
    .sum_out(pe_sum[15])
);

pe #(.DATA_BITS(DATA_BITS), .WEIGHT_BITS(WEIGHT_BITS), .SUM_BITS(ACC_BITS))
pe_inst17 (
    .clk(clk),
    .rst_n(rst_n),
    .data_in(data[16]),
    .sum_in({ACC_BITS{1'b0}}),
    .weight(weight[16]),
    .data_out(pe_data_out[16]),
    .sum_out(pe_sum[16])
);

pe #(.DATA_BITS(DATA_BITS), .WEIGHT_BITS(WEIGHT_BITS), .SUM_BITS(ACC_BITS))
pe_inst18 (
    .clk(clk),
    .rst_n(rst_n),
    .data_in(data[17]),
    .sum_in({ACC_BITS{1'b0}}),
    .weight(weight[17]),
    .data_out(pe_data_out[17]),
    .sum_out(pe_sum[17])
);

pe #(.DATA_BITS(DATA_BITS), .WEIGHT_BITS(WEIGHT_BITS), .SUM_BITS(ACC_BITS))
pe_inst19 (
    .clk(clk),
    .rst_n(rst_n),
    .data_in(data[18]),
    .sum_in({ACC_BITS{1'b0}}),
    .weight(weight[18]),
    .data_out(pe_data_out[18]),
    .sum_out(pe_sum[18])
);

pe #(.DATA_BITS(DATA_BITS), .WEIGHT_BITS(WEIGHT_BITS), .SUM_BITS(ACC_BITS))
pe_inst20 (
    .clk(clk),
    .rst_n(rst_n),
    .data_in(data[19]),
    .sum_in({ACC_BITS{1'b0}}),
    .weight(weight[19]),
    .data_out(pe_data_out[19]),
    .sum_out(pe_sum[19])
);

pe #(.DATA_BITS(DATA_BITS), .WEIGHT_BITS(WEIGHT_BITS), .SUM_BITS(ACC_BITS))
pe_inst21 (
    .clk(clk),
    .rst_n(rst_n),
    .data_in(data[20]),
    .sum_in({ACC_BITS{1'b0}}),
    .weight(weight[20]),
    .data_out(pe_data_out[20]),
    .sum_out(pe_sum[20])
);

pe #(.DATA_BITS(DATA_BITS), .WEIGHT_BITS(WEIGHT_BITS), .SUM_BITS(ACC_BITS))
pe_inst22 (
    .clk(clk),
    .rst_n(rst_n),
    .data_in(data[21]),
    .sum_in({ACC_BITS{1'b0}}),
    .weight(weight[21]),
    .data_out(pe_data_out[21]),
    .sum_out(pe_sum[21])
);

pe #(.DATA_BITS(DATA_BITS), .WEIGHT_BITS(WEIGHT_BITS), .SUM_BITS(ACC_BITS))
pe_inst23 (
    .clk(clk),
    .rst_n(rst_n),
    .data_in(data[22]),
    .sum_in({ACC_BITS{1'b0}}),
    .weight(weight[22]),
    .data_out(pe_data_out[22]),
    .sum_out(pe_sum[22])
);

pe #(.DATA_BITS(DATA_BITS), .WEIGHT_BITS(WEIGHT_BITS), .SUM_BITS(ACC_BITS))
pe_inst24 (
    .clk(clk),
    .rst_n(rst_n),
    .data_in(data[23]),
    .sum_in({ACC_BITS{1'b0}}),
    .weight(weight[23]),
    .data_out(pe_data_out[23]),
    .sum_out(pe_sum[23])
);

pe #(.DATA_BITS(DATA_BITS), .WEIGHT_BITS(WEIGHT_BITS), .SUM_BITS(ACC_BITS))
pe_inst25 (
    .clk(clk),
    .rst_n(rst_n),
    .data_in(data[24]),
    .sum_in({ACC_BITS{1'b0}}),
    .weight(weight[24]),
    .data_out(pe_data_out[24]),
    .sum_out(pe_sum[24])
);

wire signed [ACC_BITS-1:0] s1 [0:12];
wire signed [ACC_BITS-1:0] s2 [0:6];
wire signed [ACC_BITS-1:0] s3 [0:3];
wire signed [ACC_BITS-1:0] s4 [0:1];
wire signed [ACC_BITS-1:0] s5;

assign s1[0]  = pe_sum[0]  + pe_sum[1];
assign s1[1]  = pe_sum[2]  + pe_sum[3];
assign s1[2]  = pe_sum[4]  + pe_sum[5];
assign s1[3]  = pe_sum[6]  + pe_sum[7];
assign s1[4]  = pe_sum[8]  + pe_sum[9];
assign s1[5]  = pe_sum[10] + pe_sum[11];
assign s1[6]  = pe_sum[12] + pe_sum[13];
assign s1[7]  = pe_sum[14] + pe_sum[15];
assign s1[8]  = pe_sum[16] + pe_sum[17];
assign s1[9]  = pe_sum[18] + pe_sum[19];
assign s1[10] = pe_sum[20] + pe_sum[21];
assign s1[11] = pe_sum[22] + pe_sum[23];
assign s1[12] = pe_sum[24];

assign s2[0] = s1[0]  + s1[1];
assign s2[1] = s1[2]  + s1[3];
assign s2[2] = s1[4]  + s1[5];
assign s2[3] = s1[6]  + s1[7];
assign s2[4] = s1[8]  + s1[9];
assign s2[5] = s1[10] + s1[11];
assign s2[6] = s1[12];

assign s3[0] = s2[0] + s2[1];
assign s3[1] = s2[2] + s2[3];
assign s3[2] = s2[4] + s2[5];
assign s3[3] = s2[6];

assign s4[0] = s3[0] + s3[1];
assign s4[1] = s3[2] + s3[3];

assign s5 = s4[0] + s4[1];

assign conv_raw = s5;

reg valid_pipe;

always @(posedge clk) begin
    if (!rst_n)
        valid_pipe <= 1'b0;
    else
        valid_pipe <= valid_in;
end

assign valid_out = valid_pipe;

endmodule
//module conv2_systolic_array_5x5
//#(
//    parameter DATA_BITS   = 12,
//    parameter WEIGHT_BITS = 8,
//    parameter ACC_BITS    = 20,
//    parameter WEIGHT_FILE = "conv2_weight_11.mem"
//)
//(
//    input  wire                         clk,
//    input  wire                         rst_n,
//    input  wire                         valid_in,

//    input  wire signed [DATA_BITS-1:0] a00,a01,a02,a03,a04,
//    input  wire signed [DATA_BITS-1:0] a10,a11,a12,a13,a14,
//    input  wire signed [DATA_BITS-1:0] a20,a21,a22,a23,a24,
//    input  wire signed [DATA_BITS-1:0] a30,a31,a32,a33,a34,
//    input  wire signed [DATA_BITS-1:0] a40,a41,a42,a43,a44,

//    output wire signed [ACC_BITS-1:0]  conv_raw,
//    output wire                        valid_out
//);

//////////////////////////////////////////////////////////////
//// WEIGHTS
//////////////////////////////////////////////////////////////

//reg signed [WEIGHT_BITS-1:0] weight [0:24];

//initial begin
//    $readmemh(WEIGHT_FILE, weight);
//end

//////////////////////////////////////////////////////////////
//// DATA ARRAY
//////////////////////////////////////////////////////////////

//wire signed [DATA_BITS-1:0] data [0:24];

//assign data[0]  = a00;
//assign data[1]  = a01;
//assign data[2]  = a02;
//assign data[3]  = a03;
//assign data[4]  = a04;

//assign data[5]  = a10;
//assign data[6]  = a11;
//assign data[7]  = a12;
//assign data[8]  = a13;
//assign data[9]  = a14;

//assign data[10] = a20;
//assign data[11] = a21;
//assign data[12] = a22;
//assign data[13] = a23;
//assign data[14] = a24;

//assign data[15] = a30;
//assign data[16] = a31;
//assign data[17] = a32;
//assign data[18] = a33;
//assign data[19] = a34;

//assign data[20] = a40;
//assign data[21] = a41;
//assign data[22] = a42;
//assign data[23] = a43;
//assign data[24] = a44;

//////////////////////////////////////////////////////////////
//// 25 PARALLEL PE INSTANCES
////
//// sum_in is tied to zero.
//// Therefore each PE behaves as:
////
//// pe_sum[p] = data[p] * weight[p]
//////////////////////////////////////////////////////////////

//wire signed [DATA_BITS-1:0] pe_data_out [0:24];
//wire signed [ACC_BITS-1:0]  pe_sum      [0:24];

//genvar p;
//generate
//    for (p = 0; p < 25; p = p + 1) begin : CONV2_PE_ARRAY
//        pe
//        #(
//            .DATA_BITS(DATA_BITS),
//            .WEIGHT_BITS(WEIGHT_BITS),
//            .SUM_BITS(ACC_BITS)
//        )
//        pe_inst
//        (
//            .clk(clk),
//            .rst_n(rst_n),

//            .data_in(data[p]),
//            .sum_in({ACC_BITS{1'b0}}),
//            .weight(weight[p]),

//            .data_out(pe_data_out[p]),
//            .sum_out(pe_sum[p])
//        );
//    end
//endgenerate

//////////////////////////////////////////////////////////////
//// COMBINATIONAL ADDER TREE
////
//// Same accumulation structure as before,
//// but combinational instead of 5 registered stages.
//////////////////////////////////////////////////////////////

//wire signed [ACC_BITS-1:0] s1 [0:12];
//wire signed [ACC_BITS-1:0] s2 [0:6];
//wire signed [ACC_BITS-1:0] s3 [0:3];
//wire signed [ACC_BITS-1:0] s4 [0:1];
//wire signed [ACC_BITS-1:0] s5;

//assign s1[0]  = pe_sum[0]  + pe_sum[1];
//assign s1[1]  = pe_sum[2]  + pe_sum[3];
//assign s1[2]  = pe_sum[4]  + pe_sum[5];
//assign s1[3]  = pe_sum[6]  + pe_sum[7];
//assign s1[4]  = pe_sum[8]  + pe_sum[9];
//assign s1[5]  = pe_sum[10] + pe_sum[11];
//assign s1[6]  = pe_sum[12] + pe_sum[13];
//assign s1[7]  = pe_sum[14] + pe_sum[15];
//assign s1[8]  = pe_sum[16] + pe_sum[17];
//assign s1[9]  = pe_sum[18] + pe_sum[19];
//assign s1[10] = pe_sum[20] + pe_sum[21];
//assign s1[11] = pe_sum[22] + pe_sum[23];
//assign s1[12] = pe_sum[24];

//assign s2[0] = s1[0]  + s1[1];
//assign s2[1] = s1[2]  + s1[3];
//assign s2[2] = s1[4]  + s1[5];
//assign s2[3] = s1[6]  + s1[7];
//assign s2[4] = s1[8]  + s1[9];
//assign s2[5] = s1[10] + s1[11];
//assign s2[6] = s1[12];

//assign s3[0] = s2[0] + s2[1];
//assign s3[1] = s2[2] + s2[3];
//assign s3[2] = s2[4] + s2[5];
//assign s3[3] = s2[6];

//assign s4[0] = s3[0] + s3[1];
//assign s4[1] = s3[2] + s3[3];

//assign s5 = s4[0] + s4[1];

//assign conv_raw = s5;

//////////////////////////////////////////////////////////////
//// VALID PIPELINE
////
//// PE has one registered stage.
//// Therefore valid_out is delayed by 1 clock.
//////////////////////////////////////////////////////////////

//reg valid_pipe;

//always @(posedge clk) begin
//    if (!rst_n)
//        valid_pipe <= 1'b0;
//    else
//        valid_pipe <= valid_in;
//end

//assign valid_out = valid_pipe;

//endmodule

