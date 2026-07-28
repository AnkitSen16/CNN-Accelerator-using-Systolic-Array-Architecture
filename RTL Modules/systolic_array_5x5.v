`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.05.2026 17:41:06
// Design Name: 
// Module Name: systolic_array_5x5
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
module systolic_array_5x5
#(
    parameter DATA_BITS   = 8,
    parameter WEIGHT_BITS = 8,
    parameter ACC_BITS    = 24,
    parameter WEIGHT_FILE = "conv1_weight_1.mem" //default
)
(
    input  wire                 clk,
    input  wire                 rst_n,
    input  wire                 valid_in,

    input  wire [DATA_BITS-1:0] a00,a01,a02,a03,a04,
    input  wire [DATA_BITS-1:0] a10,a11,a12,a13,a14,
    input  wire [DATA_BITS-1:0] a20,a21,a22,a23,a24,
    input  wire [DATA_BITS-1:0] a30,a31,a32,a33,a34,
    input  wire [DATA_BITS-1:0] a40,a41,a42,a43,a44,

    output wire signed [11:0] conv_out,
    output wire               valid_out
);

reg signed [WEIGHT_BITS-1:0] weight [0:24];

initial begin
    $readmemh(WEIGHT_FILE, weight);
end

wire signed [8:0] pixel [0:24];

assign pixel[0]  = {1'b0, a00};
assign pixel[1]  = {1'b0, a01};
assign pixel[2]  = {1'b0, a02};
assign pixel[3]  = {1'b0, a03};
assign pixel[4]  = {1'b0, a04};

assign pixel[5]  = {1'b0, a10};
assign pixel[6]  = {1'b0, a11};
assign pixel[7]  = {1'b0, a12};
assign pixel[8]  = {1'b0, a13};
assign pixel[9]  = {1'b0, a14};

assign pixel[10] = {1'b0, a20};
assign pixel[11] = {1'b0, a21};
assign pixel[12] = {1'b0, a22};
assign pixel[13] = {1'b0, a23};
assign pixel[14] = {1'b0, a24};

assign pixel[15] = {1'b0, a30};
assign pixel[16] = {1'b0, a31};
assign pixel[17] = {1'b0, a32};
assign pixel[18] = {1'b0, a33};
assign pixel[19] = {1'b0, a34};

assign pixel[20] = {1'b0, a40};
assign pixel[21] = {1'b0, a41};
assign pixel[22] = {1'b0, a42};
assign pixel[23] = {1'b0, a43};
assign pixel[24] = {1'b0, a44};


wire signed [8:0] pe_data_out [0:24];
(* use_dsp = "no" *)
wire signed [ACC_BITS-1:0] pe_sum [0:24];

pe #(.DATA_BITS(9), .WEIGHT_BITS(WEIGHT_BITS), .SUM_BITS(ACC_BITS))
pe_inst1 (
    .clk(clk),
    .rst_n(rst_n),
    .data_in(pixel[0]),
    .sum_in({ACC_BITS{1'b0}}),
    .weight(weight[0]),
    .data_out(pe_data_out[0]),
    .sum_out(pe_sum[0])
);

pe #(.DATA_BITS(9), .WEIGHT_BITS(WEIGHT_BITS), .SUM_BITS(ACC_BITS))
pe_inst2 (
    .clk(clk),
    .rst_n(rst_n),
    .data_in(pixel[1]),
    .sum_in({ACC_BITS{1'b0}}),
    .weight(weight[1]),
    .data_out(pe_data_out[1]),
    .sum_out(pe_sum[1])
);

pe #(.DATA_BITS(9), .WEIGHT_BITS(WEIGHT_BITS), .SUM_BITS(ACC_BITS))
pe_inst3 (
    .clk(clk),
    .rst_n(rst_n),
    .data_in(pixel[2]),
    .sum_in({ACC_BITS{1'b0}}),
    .weight(weight[2]),
    .data_out(pe_data_out[2]),
    .sum_out(pe_sum[2])
);

pe #(.DATA_BITS(9), .WEIGHT_BITS(WEIGHT_BITS), .SUM_BITS(ACC_BITS))
pe_inst4 (
    .clk(clk),
    .rst_n(rst_n),
    .data_in(pixel[3]),
    .sum_in({ACC_BITS{1'b0}}),
    .weight(weight[3]),
    .data_out(pe_data_out[3]),
    .sum_out(pe_sum[3])
);

pe #(.DATA_BITS(9), .WEIGHT_BITS(WEIGHT_BITS), .SUM_BITS(ACC_BITS))
pe_inst5 (
    .clk(clk),
    .rst_n(rst_n),
    .data_in(pixel[4]),
    .sum_in({ACC_BITS{1'b0}}),
    .weight(weight[4]),
    .data_out(pe_data_out[4]),
    .sum_out(pe_sum[4])
);

pe #(.DATA_BITS(9), .WEIGHT_BITS(WEIGHT_BITS), .SUM_BITS(ACC_BITS))
pe_inst6 (
    .clk(clk),
    .rst_n(rst_n),
    .data_in(pixel[5]),
    .sum_in({ACC_BITS{1'b0}}),
    .weight(weight[5]),
    .data_out(pe_data_out[5]),
    .sum_out(pe_sum[5])
);

pe #(.DATA_BITS(9), .WEIGHT_BITS(WEIGHT_BITS), .SUM_BITS(ACC_BITS))
pe_inst7 (
    .clk(clk),
    .rst_n(rst_n),
    .data_in(pixel[6]),
    .sum_in({ACC_BITS{1'b0}}),
    .weight(weight[6]),
    .data_out(pe_data_out[6]),
    .sum_out(pe_sum[6])
);

pe #(.DATA_BITS(9), .WEIGHT_BITS(WEIGHT_BITS), .SUM_BITS(ACC_BITS))
pe_inst8 (
    .clk(clk),
    .rst_n(rst_n),
    .data_in(pixel[7]),
    .sum_in({ACC_BITS{1'b0}}),
    .weight(weight[7]),
    .data_out(pe_data_out[7]),
    .sum_out(pe_sum[7])
);

pe #(.DATA_BITS(9), .WEIGHT_BITS(WEIGHT_BITS), .SUM_BITS(ACC_BITS))
pe_inst9 (
    .clk(clk),
    .rst_n(rst_n),
    .data_in(pixel[8]),
    .sum_in({ACC_BITS{1'b0}}),
    .weight(weight[8]),
    .data_out(pe_data_out[8]),
    .sum_out(pe_sum[8])
);

pe #(.DATA_BITS(9), .WEIGHT_BITS(WEIGHT_BITS), .SUM_BITS(ACC_BITS))
pe_inst10 (
    .clk(clk),
    .rst_n(rst_n),
    .data_in(pixel[9]),
    .sum_in({ACC_BITS{1'b0}}),
    .weight(weight[9]),
    .data_out(pe_data_out[9]),
    .sum_out(pe_sum[9])
);

pe #(.DATA_BITS(9), .WEIGHT_BITS(WEIGHT_BITS), .SUM_BITS(ACC_BITS))
pe_inst11 (
    .clk(clk),
    .rst_n(rst_n),
    .data_in(pixel[10]),
    .sum_in({ACC_BITS{1'b0}}),
    .weight(weight[10]),
    .data_out(pe_data_out[10]),
    .sum_out(pe_sum[10])
);

pe #(.DATA_BITS(9), .WEIGHT_BITS(WEIGHT_BITS), .SUM_BITS(ACC_BITS))
pe_inst12 (
    .clk(clk),
    .rst_n(rst_n),
    .data_in(pixel[11]),
    .sum_in({ACC_BITS{1'b0}}),
    .weight(weight[11]),
    .data_out(pe_data_out[11]),
    .sum_out(pe_sum[11])
);

pe #(.DATA_BITS(9), .WEIGHT_BITS(WEIGHT_BITS), .SUM_BITS(ACC_BITS))
pe_inst13 (
    .clk(clk),
    .rst_n(rst_n),
    .data_in(pixel[12]),
    .sum_in({ACC_BITS{1'b0}}),
    .weight(weight[12]),
    .data_out(pe_data_out[12]),
    .sum_out(pe_sum[12])
);

pe #(.DATA_BITS(9), .WEIGHT_BITS(WEIGHT_BITS), .SUM_BITS(ACC_BITS))
pe_inst14 (
    .clk(clk),
    .rst_n(rst_n),
    .data_in(pixel[13]),
    .sum_in({ACC_BITS{1'b0}}),
    .weight(weight[13]),
    .data_out(pe_data_out[13]),
    .sum_out(pe_sum[13])
);

pe #(.DATA_BITS(9), .WEIGHT_BITS(WEIGHT_BITS), .SUM_BITS(ACC_BITS))
pe_inst15 (
    .clk(clk),
    .rst_n(rst_n),
    .data_in(pixel[14]),
    .sum_in({ACC_BITS{1'b0}}),
    .weight(weight[14]),
    .data_out(pe_data_out[14]),
    .sum_out(pe_sum[14])
);

pe #(.DATA_BITS(9), .WEIGHT_BITS(WEIGHT_BITS), .SUM_BITS(ACC_BITS))
pe_inst16 (
    .clk(clk),
    .rst_n(rst_n),
    .data_in(pixel[15]),
    .sum_in({ACC_BITS{1'b0}}),
    .weight(weight[15]),
    .data_out(pe_data_out[15]),
    .sum_out(pe_sum[15])
);

pe #(.DATA_BITS(9), .WEIGHT_BITS(WEIGHT_BITS), .SUM_BITS(ACC_BITS))
pe_inst17 (
    .clk(clk),
    .rst_n(rst_n),
    .data_in(pixel[16]),
    .sum_in({ACC_BITS{1'b0}}),
    .weight(weight[16]),
    .data_out(pe_data_out[16]),
    .sum_out(pe_sum[16])
);

pe #(.DATA_BITS(9), .WEIGHT_BITS(WEIGHT_BITS), .SUM_BITS(ACC_BITS))
pe_inst18 (
    .clk(clk),
    .rst_n(rst_n),
    .data_in(pixel[17]),
    .sum_in({ACC_BITS{1'b0}}),
    .weight(weight[17]),
    .data_out(pe_data_out[17]),
    .sum_out(pe_sum[17])
);

pe #(.DATA_BITS(9), .WEIGHT_BITS(WEIGHT_BITS), .SUM_BITS(ACC_BITS))
pe_inst19 (
    .clk(clk),
    .rst_n(rst_n),
    .data_in(pixel[18]),
    .sum_in({ACC_BITS{1'b0}}),
    .weight(weight[18]),
    .data_out(pe_data_out[18]),
    .sum_out(pe_sum[18])
);

pe #(.DATA_BITS(9), .WEIGHT_BITS(WEIGHT_BITS), .SUM_BITS(ACC_BITS))
pe_inst20 (
    .clk(clk),
    .rst_n(rst_n),
    .data_in(pixel[19]),
    .sum_in({ACC_BITS{1'b0}}),
    .weight(weight[19]),
    .data_out(pe_data_out[19]),
    .sum_out(pe_sum[19])
);

pe #(.DATA_BITS(9), .WEIGHT_BITS(WEIGHT_BITS), .SUM_BITS(ACC_BITS))
pe_inst21 (
    .clk(clk),
    .rst_n(rst_n),
    .data_in(pixel[20]),
    .sum_in({ACC_BITS{1'b0}}),
    .weight(weight[20]),
    .data_out(pe_data_out[20]),
    .sum_out(pe_sum[20])
);

pe #(.DATA_BITS(9), .WEIGHT_BITS(WEIGHT_BITS), .SUM_BITS(ACC_BITS))
pe_inst22 (
    .clk(clk),
    .rst_n(rst_n),
    .data_in(pixel[21]),
    .sum_in({ACC_BITS{1'b0}}),
    .weight(weight[21]),
    .data_out(pe_data_out[21]),
    .sum_out(pe_sum[21])
);

pe #(.DATA_BITS(9), .WEIGHT_BITS(WEIGHT_BITS), .SUM_BITS(ACC_BITS))
pe_inst23 (
    .clk(clk),
    .rst_n(rst_n),
    .data_in(pixel[22]),
    .sum_in({ACC_BITS{1'b0}}),
    .weight(weight[22]),
    .data_out(pe_data_out[22]),
    .sum_out(pe_sum[22])
);

pe #(.DATA_BITS(9), .WEIGHT_BITS(WEIGHT_BITS), .SUM_BITS(ACC_BITS))
pe_inst24 (
    .clk(clk),
    .rst_n(rst_n),
    .data_in(pixel[23]),
    .sum_in({ACC_BITS{1'b0}}),
    .weight(weight[23]),
    .data_out(pe_data_out[23]),
    .sum_out(pe_sum[23])
);

pe #(.DATA_BITS(9), .WEIGHT_BITS(WEIGHT_BITS), .SUM_BITS(ACC_BITS))
pe_inst25 (
    .clk(clk),
    .rst_n(rst_n),
    .data_in(pixel[24]),
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

wire signed [ACC_BITS-1:0] scaled;

assign scaled   = s5 >>> 8;
assign conv_out = scaled[11:0];

reg valid_pipe;

always @(posedge clk) begin
    if (!rst_n)
        valid_pipe <= 1'b0;
    else
        valid_pipe <= valid_in;
end

assign valid_out = valid_pipe;

endmodule
//module systolic_array_5x5
//#(
//    parameter DATA_BITS   = 8,
//    parameter WEIGHT_BITS = 8,
//    parameter ACC_BITS    = 24,
//    parameter WEIGHT_FILE = "conv1_weight_1.mem"
//)
//(
//    input  wire                 clk,
//    input  wire                 rst_n,
//    input  wire                 valid_in,

//    input  wire [DATA_BITS-1:0] a00,a01,a02,a03,a04,
//    input  wire [DATA_BITS-1:0] a10,a11,a12,a13,a14,
//    input  wire [DATA_BITS-1:0] a20,a21,a22,a23,a24,
//    input  wire [DATA_BITS-1:0] a30,a31,a32,a33,a34,
//    input  wire [DATA_BITS-1:0] a40,a41,a42,a43,a44,

//    output wire signed [11:0] conv_out,
//    output wire               valid_out
//);

//////////////////////////////////////////////////////////////
//// WEIGHTS
//////////////////////////////////////////////////////////////

//reg signed [WEIGHT_BITS-1:0] weight [0:24];

//initial begin
//    $readmemh(WEIGHT_FILE, weight);
//end

//////////////////////////////////////////////////////////////
//// PIXELS
//////////////////////////////////////////////////////////////

//wire signed [8:0] pixel [0:24];

//assign pixel[0]  = {1'b0, a00};
//assign pixel[1]  = {1'b0, a01};
//assign pixel[2]  = {1'b0, a02};
//assign pixel[3]  = {1'b0, a03};
//assign pixel[4]  = {1'b0, a04};

//assign pixel[5]  = {1'b0, a10};
//assign pixel[6]  = {1'b0, a11};
//assign pixel[7]  = {1'b0, a12};
//assign pixel[8]  = {1'b0, a13};
//assign pixel[9]  = {1'b0, a14};

//assign pixel[10] = {1'b0, a20};
//assign pixel[11] = {1'b0, a21};
//assign pixel[12] = {1'b0, a22};
//assign pixel[13] = {1'b0, a23};
//assign pixel[14] = {1'b0, a24};

//assign pixel[15] = {1'b0, a30};
//assign pixel[16] = {1'b0, a31};
//assign pixel[17] = {1'b0, a32};
//assign pixel[18] = {1'b0, a33};
//assign pixel[19] = {1'b0, a34};

//assign pixel[20] = {1'b0, a40};
//assign pixel[21] = {1'b0, a41};
//assign pixel[22] = {1'b0, a42};
//assign pixel[23] = {1'b0, a43};
//assign pixel[24] = {1'b0, a44};

//////////////////////////////////////////////////////////////
//// PE ARRAY
//////////////////////////////////////////////////////////////

//wire signed [8:0] pe_data_out [0:24];
//wire signed [ACC_BITS-1:0] pe_sum [0:24];

//genvar p;

//generate
//    for (p = 0; p < 25; p = p + 1) begin : CONV1_PE_ARRAY

//        pe
//        #(
//            .DATA_BITS(9),
//            .WEIGHT_BITS(WEIGHT_BITS),
//            .SUM_BITS(ACC_BITS)
//        )
//        pe_inst
//        (
//            .clk(clk),
//            .rst_n(rst_n),

//            .data_in(pixel[p]),
//            .sum_in({ACC_BITS{1'b0}}),
//            .weight(weight[p]),

//            .data_out(pe_data_out[p]),
//            .sum_out(pe_sum[p])
//        );

//    end
//endgenerate

//////////////////////////////////////////////////////////////
//// REGISTERED ADDER TREE
//////////////////////////////////////////////////////////////

//reg signed [ACC_BITS-1:0] s1 [0:12];
//reg signed [ACC_BITS-1:0] s2 [0:6];
//reg signed [ACC_BITS-1:0] s3 [0:3];
//reg signed [ACC_BITS-1:0] s4 [0:1];
//reg signed [ACC_BITS-1:0] s5;

//integer i;

//always @(posedge clk) begin

//    if(!rst_n) begin

//        s5 <= 0;

//    end
//    else begin

//        //--------------------------------------------------
//        // STAGE 1
//        //--------------------------------------------------

//        for(i=0; i<12; i=i+1)
//            s1[i] <= pe_sum[2*i] + pe_sum[(2*i)+1];

//        s1[12] <= pe_sum[24];

//        //--------------------------------------------------
//        // STAGE 2
//        //--------------------------------------------------

//        for(i=0; i<6; i=i+1)
//            s2[i] <= s1[2*i] + s1[(2*i)+1];

//        s2[6] <= s1[12];

//        //--------------------------------------------------
//        // STAGE 3
//        //--------------------------------------------------

//        s3[0] <= s2[0] + s2[1];
//        s3[1] <= s2[2] + s2[3];
//        s3[2] <= s2[4] + s2[5];
//        s3[3] <= s2[6];

//        //--------------------------------------------------
//        // STAGE 4
//        //--------------------------------------------------

//        s4[0] <= s3[0] + s3[1];
//        s4[1] <= s3[2] + s3[3];

//        //--------------------------------------------------
//        // FINAL
//        //--------------------------------------------------

//        s5 <= s4[0] + s4[1];

//    end
//end

//////////////////////////////////////////////////////////////
//// OUTPUT REGISTER
//////////////////////////////////////////////////////////////

//reg signed [ACC_BITS-1:0] scaled;
//reg signed [11:0] conv_out_r;

//always @(posedge clk) begin

//    if(!rst_n) begin

//        scaled     <= 0;
//        conv_out_r <= 0;

//    end
//    else begin

//        scaled     <= s5 >>> 8;
//        conv_out_r <= scaled[11:0];

//    end
//end

//assign conv_out = conv_out_r;

//////////////////////////////////////////////////////////////
//// VALID PIPELINE
//////////////////////////////////////////////////////////////

//reg [6:0] valid_pipe;

//always @(posedge clk) begin

//    if(!rst_n)
//        valid_pipe <= 0;
//    else
//        valid_pipe <= {valid_pipe[5:0], valid_in};

//end

//assign valid_out = valid_pipe[6];

//endmodule

