`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.05.2026 17:46:35
// Design Name: 
// Module Name: conv2_layer
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

module conv2_layer
(
    input  wire               clk,
    input  wire               rst_n,
    input  wire               valid_in,

    input  wire signed [11:0] max_value_1,
    input  wire signed [11:0] max_value_2,
    input  wire signed [11:0] max_value_3,

    output wire signed [11:0] conv2_out_1,
    output wire signed [11:0] conv2_out_2,
    output wire signed [11:0] conv2_out_3,

    output wire               valid_out_conv2
);


wire buf_valid_1;
wire buf_valid_2;
wire buf_valid_3;
wire buf_valid;

wire signed [11:0] ch1_w00,ch1_w01,ch1_w02,ch1_w03,ch1_w04;
wire signed [11:0] ch1_w10,ch1_w11,ch1_w12,ch1_w13,ch1_w14;
wire signed [11:0] ch1_w20,ch1_w21,ch1_w22,ch1_w23,ch1_w24;
wire signed [11:0] ch1_w30,ch1_w31,ch1_w32,ch1_w33,ch1_w34;
wire signed [11:0] ch1_w40,ch1_w41,ch1_w42,ch1_w43,ch1_w44;

wire signed [11:0] ch2_w00,ch2_w01,ch2_w02,ch2_w03,ch2_w04;
wire signed [11:0] ch2_w10,ch2_w11,ch2_w12,ch2_w13,ch2_w14;
wire signed [11:0] ch2_w20,ch2_w21,ch2_w22,ch2_w23,ch2_w24;
wire signed [11:0] ch2_w30,ch2_w31,ch2_w32,ch2_w33,ch2_w34;
wire signed [11:0] ch2_w40,ch2_w41,ch2_w42,ch2_w43,ch2_w44;

wire signed [11:0] ch3_w00,ch3_w01,ch3_w02,ch3_w03,ch3_w04;
wire signed [11:0] ch3_w10,ch3_w11,ch3_w12,ch3_w13,ch3_w14;
wire signed [11:0] ch3_w20,ch3_w21,ch3_w22,ch3_w23,ch3_w24;
wire signed [11:0] ch3_w30,ch3_w31,ch3_w32,ch3_w33,ch3_w34;
wire signed [11:0] ch3_w40,ch3_w41,ch3_w42,ch3_w43,ch3_w44;

assign buf_valid = buf_valid_1 & buf_valid_2 & buf_valid_3;

conv2_line_buffer_5x5
#(
    .WIDTH(12),
    .DATA_BITS(12)
)
conv2_line_buffer_ch1
(
    .clk(clk),
    .rst_n(rst_n),
    .valid_in(valid_in),
    .data_in(max_value_1),

    .valid_out(buf_valid_1),

    .w00(ch1_w00), .w01(ch1_w01), .w02(ch1_w02), .w03(ch1_w03), .w04(ch1_w04),
    .w10(ch1_w10), .w11(ch1_w11), .w12(ch1_w12), .w13(ch1_w13), .w14(ch1_w14),
    .w20(ch1_w20), .w21(ch1_w21), .w22(ch1_w22), .w23(ch1_w23), .w24(ch1_w24),
    .w30(ch1_w30), .w31(ch1_w31), .w32(ch1_w32), .w33(ch1_w33), .w34(ch1_w34),
    .w40(ch1_w40), .w41(ch1_w41), .w42(ch1_w42), .w43(ch1_w43), .w44(ch1_w44)
);

conv2_line_buffer_5x5
#(
    .WIDTH(12),
    .DATA_BITS(12)
)
conv2_line_buffer_ch2
(
    .clk(clk),
    .rst_n(rst_n),
    .valid_in(valid_in),
    .data_in(max_value_2),

    .valid_out(buf_valid_2),

    .w00(ch2_w00), .w01(ch2_w01), .w02(ch2_w02), .w03(ch2_w03), .w04(ch2_w04),
    .w10(ch2_w10), .w11(ch2_w11), .w12(ch2_w12), .w13(ch2_w13), .w14(ch2_w14),
    .w20(ch2_w20), .w21(ch2_w21), .w22(ch2_w22), .w23(ch2_w23), .w24(ch2_w24),
    .w30(ch2_w30), .w31(ch2_w31), .w32(ch2_w32), .w33(ch2_w33), .w34(ch2_w34),
    .w40(ch2_w40), .w41(ch2_w41), .w42(ch2_w42), .w43(ch2_w43), .w44(ch2_w44)
);

conv2_line_buffer_5x5
#(
    .WIDTH(12),
    .DATA_BITS(12)
)
conv2_line_buffer_ch3
(
    .clk(clk),
    .rst_n(rst_n),
    .valid_in(valid_in),
    .data_in(max_value_3),

    .valid_out(buf_valid_3),

    .w00(ch3_w00), .w01(ch3_w01), .w02(ch3_w02), .w03(ch3_w03), .w04(ch3_w04),
    .w10(ch3_w10), .w11(ch3_w11), .w12(ch3_w12), .w13(ch3_w13), .w14(ch3_w14),
    .w20(ch3_w20), .w21(ch3_w21), .w22(ch3_w22), .w23(ch3_w23), .w24(ch3_w24),
    .w30(ch3_w30), .w31(ch3_w31), .w32(ch3_w32), .w33(ch3_w33), .w34(ch3_w34),
    .w40(ch3_w40), .w41(ch3_w41), .w42(ch3_w42), .w43(ch3_w43), .w44(ch3_w44)
);

wire signed [19:0] raw_11;
wire signed [19:0] raw_12;
wire signed [19:0] raw_13;

wire signed [19:0] raw_21;
wire signed [19:0] raw_22;
wire signed [19:0] raw_23;

wire signed [19:0] raw_31;
wire signed [19:0] raw_32;
wire signed [19:0] raw_33;

wire valid_11;
wire valid_12;
wire valid_13;

wire valid_21;
wire valid_22;
wire valid_23;

wire valid_31;
wire valid_32;
wire valid_33;

conv2_systolic_array_5x5
#(
    .WEIGHT_FILE("conv2_weight_11.mem")
)
conv2_sa_11
(
    .clk(clk),
    .rst_n(rst_n),
    .valid_in(buf_valid),

    .a00(ch1_w00), .a01(ch1_w01), .a02(ch1_w02), .a03(ch1_w03), .a04(ch1_w04),
    .a10(ch1_w10), .a11(ch1_w11), .a12(ch1_w12), .a13(ch1_w13), .a14(ch1_w14),
    .a20(ch1_w20), .a21(ch1_w21), .a22(ch1_w22), .a23(ch1_w23), .a24(ch1_w24),
    .a30(ch1_w30), .a31(ch1_w31), .a32(ch1_w32), .a33(ch1_w33), .a34(ch1_w34),
    .a40(ch1_w40), .a41(ch1_w41), .a42(ch1_w42), .a43(ch1_w43), .a44(ch1_w44),

    .conv_raw(raw_11),
    .valid_out(valid_11)
);

conv2_systolic_array_5x5
#(
    .WEIGHT_FILE("conv2_weight_12.mem")
)
conv2_sa_12
(
    .clk(clk),
    .rst_n(rst_n),
    .valid_in(buf_valid),

    .a00(ch2_w00), .a01(ch2_w01), .a02(ch2_w02), .a03(ch2_w03), .a04(ch2_w04),
    .a10(ch2_w10), .a11(ch2_w11), .a12(ch2_w12), .a13(ch2_w13), .a14(ch2_w14),
    .a20(ch2_w20), .a21(ch2_w21), .a22(ch2_w22), .a23(ch2_w23), .a24(ch2_w24),
    .a30(ch2_w30), .a31(ch2_w31), .a32(ch2_w32), .a33(ch2_w33), .a34(ch2_w34),
    .a40(ch2_w40), .a41(ch2_w41), .a42(ch2_w42), .a43(ch2_w43), .a44(ch2_w44),

    .conv_raw(raw_12),
    .valid_out(valid_12)
);

conv2_systolic_array_5x5
#(
    .WEIGHT_FILE("conv2_weight_13.mem")
)
conv2_sa_13
(
    .clk(clk),
    .rst_n(rst_n),
    .valid_in(buf_valid),

    .a00(ch3_w00), .a01(ch3_w01), .a02(ch3_w02), .a03(ch3_w03), .a04(ch3_w04),
    .a10(ch3_w10), .a11(ch3_w11), .a12(ch3_w12), .a13(ch3_w13), .a14(ch3_w14),
    .a20(ch3_w20), .a21(ch3_w21), .a22(ch3_w22), .a23(ch3_w23), .a24(ch3_w24),
    .a30(ch3_w30), .a31(ch3_w31), .a32(ch3_w32), .a33(ch3_w33), .a34(ch3_w34),
    .a40(ch3_w40), .a41(ch3_w41), .a42(ch3_w42), .a43(ch3_w43), .a44(ch3_w44),

    .conv_raw(raw_13),
    .valid_out(valid_13)
);

conv2_systolic_array_5x5
#(
    .WEIGHT_FILE("conv2_weight_21.mem")
)
conv2_sa_21
(
    .clk(clk),
    .rst_n(rst_n),
    .valid_in(buf_valid),

    .a00(ch1_w00), .a01(ch1_w01), .a02(ch1_w02), .a03(ch1_w03), .a04(ch1_w04),
    .a10(ch1_w10), .a11(ch1_w11), .a12(ch1_w12), .a13(ch1_w13), .a14(ch1_w14),
    .a20(ch1_w20), .a21(ch1_w21), .a22(ch1_w22), .a23(ch1_w23), .a24(ch1_w24),
    .a30(ch1_w30), .a31(ch1_w31), .a32(ch1_w32), .a33(ch1_w33), .a34(ch1_w34),
    .a40(ch1_w40), .a41(ch1_w41), .a42(ch1_w42), .a43(ch1_w43), .a44(ch1_w44),

    .conv_raw(raw_21),
    .valid_out(valid_21)
);

conv2_systolic_array_5x5
#(
    .WEIGHT_FILE("conv2_weight_22.mem")
)
conv2_sa_22
(
    .clk(clk),
    .rst_n(rst_n),
    .valid_in(buf_valid),

    .a00(ch2_w00), .a01(ch2_w01), .a02(ch2_w02), .a03(ch2_w03), .a04(ch2_w04),
    .a10(ch2_w10), .a11(ch2_w11), .a12(ch2_w12), .a13(ch2_w13), .a14(ch2_w14),
    .a20(ch2_w20), .a21(ch2_w21), .a22(ch2_w22), .a23(ch2_w23), .a24(ch2_w24),
    .a30(ch2_w30), .a31(ch2_w31), .a32(ch2_w32), .a33(ch2_w33), .a34(ch2_w34),
    .a40(ch2_w40), .a41(ch2_w41), .a42(ch2_w42), .a43(ch2_w43), .a44(ch2_w44),

    .conv_raw(raw_22),
    .valid_out(valid_22)
);

conv2_systolic_array_5x5
#(
    .WEIGHT_FILE("conv2_weight_23.mem")
)
conv2_sa_23
(
    .clk(clk),
    .rst_n(rst_n),
    .valid_in(buf_valid),

    .a00(ch3_w00), .a01(ch3_w01), .a02(ch3_w02), .a03(ch3_w03), .a04(ch3_w04),
    .a10(ch3_w10), .a11(ch3_w11), .a12(ch3_w12), .a13(ch3_w13), .a14(ch3_w14),
    .a20(ch3_w20), .a21(ch3_w21), .a22(ch3_w22), .a23(ch3_w23), .a24(ch3_w24),
    .a30(ch3_w30), .a31(ch3_w31), .a32(ch3_w32), .a33(ch3_w33), .a34(ch3_w34),
    .a40(ch3_w40), .a41(ch3_w41), .a42(ch3_w42), .a43(ch3_w43), .a44(ch3_w44),

    .conv_raw(raw_23),
    .valid_out(valid_23)
);

conv2_systolic_array_5x5
#(
    .WEIGHT_FILE("conv2_weight_31.mem")
)
conv2_sa_31
(
    .clk(clk),
    .rst_n(rst_n),
    .valid_in(buf_valid),

    .a00(ch1_w00), .a01(ch1_w01), .a02(ch1_w02), .a03(ch1_w03), .a04(ch1_w04),
    .a10(ch1_w10), .a11(ch1_w11), .a12(ch1_w12), .a13(ch1_w13), .a14(ch1_w14),
    .a20(ch1_w20), .a21(ch1_w21), .a22(ch1_w22), .a23(ch1_w23), .a24(ch1_w24),
    .a30(ch1_w30), .a31(ch1_w31), .a32(ch1_w32), .a33(ch1_w33), .a34(ch1_w34),
    .a40(ch1_w40), .a41(ch1_w41), .a42(ch1_w42), .a43(ch1_w43), .a44(ch1_w44),

    .conv_raw(raw_31),
    .valid_out(valid_31)
);

conv2_systolic_array_5x5
#(
    .WEIGHT_FILE("conv2_weight_32.mem")
)
conv2_sa_32
(
    .clk(clk),
    .rst_n(rst_n),
    .valid_in(buf_valid),

    .a00(ch2_w00), .a01(ch2_w01), .a02(ch2_w02), .a03(ch2_w03), .a04(ch2_w04),
    .a10(ch2_w10), .a11(ch2_w11), .a12(ch2_w12), .a13(ch2_w13), .a14(ch2_w14),
    .a20(ch2_w20), .a21(ch2_w21), .a22(ch2_w22), .a23(ch2_w23), .a24(ch2_w24),
    .a30(ch2_w30), .a31(ch2_w31), .a32(ch2_w32), .a33(ch2_w33), .a34(ch2_w34),
    .a40(ch2_w40), .a41(ch2_w41), .a42(ch2_w42), .a43(ch2_w43), .a44(ch2_w44),

    .conv_raw(raw_32),
    .valid_out(valid_32)
);

conv2_systolic_array_5x5
#(
    .WEIGHT_FILE("conv2_weight_33.mem")
)
conv2_sa_33
(
    .clk(clk),
    .rst_n(rst_n),
    .valid_in(buf_valid),

    .a00(ch3_w00), .a01(ch3_w01), .a02(ch3_w02), .a03(ch3_w03), .a04(ch3_w04),
    .a10(ch3_w10), .a11(ch3_w11), .a12(ch3_w12), .a13(ch3_w13), .a14(ch3_w14),
    .a20(ch3_w20), .a21(ch3_w21), .a22(ch3_w22), .a23(ch3_w23), .a24(ch3_w24),
    .a30(ch3_w30), .a31(ch3_w31), .a32(ch3_w32), .a33(ch3_w33), .a34(ch3_w34),
    .a40(ch3_w40), .a41(ch3_w41), .a42(ch3_w42), .a43(ch3_w43), .a44(ch3_w44),

    .conv_raw(raw_33),
    .valid_out(valid_33)
);

reg signed [7:0] conv2_bias [0:2];

wire signed [11:0] conv2_bias_ext_1;
wire signed [11:0] conv2_bias_ext_2;
wire signed [11:0] conv2_bias_ext_3;

initial begin
    $readmemh("conv2_bias.mem", conv2_bias);
end

assign conv2_bias_ext_1 = {{4{conv2_bias[0][7]}}, conv2_bias[0]};
assign conv2_bias_ext_2 = {{4{conv2_bias[1][7]}}, conv2_bias[1]};
assign conv2_bias_ext_3 = {{4{conv2_bias[2][7]}}, conv2_bias[2]};

wire signed [19:0] sum_out_1;
wire signed [19:0] sum_out_2;
wire signed [19:0] sum_out_3;

wire signed [19:0] scaled_out_1;
wire signed [19:0] scaled_out_2;
wire signed [19:0] scaled_out_3;

assign sum_out_1 = raw_11 + raw_12 + raw_13;
assign sum_out_2 = raw_21 + raw_22 + raw_23;
assign sum_out_3 = raw_31 + raw_32 + raw_33;

assign scaled_out_1 = $signed(sum_out_1) >>> 7;
assign scaled_out_2 = $signed(sum_out_2) >>> 7;
assign scaled_out_3 = $signed(sum_out_3) >>> 7;

assign conv2_out_1 = scaled_out_1[11:0] + conv2_bias_ext_1;
assign conv2_out_2 = scaled_out_2[11:0] + conv2_bias_ext_2;
assign conv2_out_3 = scaled_out_3[11:0] + conv2_bias_ext_3;

assign valid_out_conv2 =
       valid_11 & valid_12 & valid_13
     & valid_21 & valid_22 & valid_23
     & valid_31 & valid_32 & valid_33;

endmodule

