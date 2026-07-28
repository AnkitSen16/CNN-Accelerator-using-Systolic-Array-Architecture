`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.05.2026 17:42:27
// Design Name: 
// Module Name: conv1_systolic
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


module conv1_systolic
(
    input  wire        clk,
    input  wire        rst_n,
    input  wire        valid_in,
    input  wire [7:0]  data_in,

    output wire signed [11:0] conv_out_1,
    output wire signed [11:0] conv_out_2,
    output wire signed [11:0] conv_out_3,
    output wire              valid_out
);

wire lb_valid;
wire [7:0] w00,w01,w02,w03,w04;
wire [7:0] w10,w11,w12,w13,w14;
wire [7:0] w20,w21,w22,w23,w24;
wire [7:0] w30,w31,w32,w33,w34;
wire [7:0] w40,w41,w42,w43,w44;

wire sa_valid_1;
wire sa_valid_2;
wire sa_valid_3;

wire signed [11:0] conv_raw_1;
wire signed [11:0] conv_raw_2;
wire signed [11:0] conv_raw_3;

reg signed [7:0] conv1_bias [0:2];

wire signed [11:0] conv1_bias_ext_1;
wire signed [11:0] conv1_bias_ext_2;
wire signed [11:0] conv1_bias_ext_3;

initial begin
    $readmemh("conv1_bias.mem", conv1_bias);
end

assign conv1_bias_ext_1 = {{4{conv1_bias[0][7]}}, conv1_bias[0]};
assign conv1_bias_ext_2 = {{4{conv1_bias[1][7]}}, conv1_bias[1]};
assign conv1_bias_ext_3 = {{4{conv1_bias[2][7]}}, conv1_bias[2]};


line_buffer_5x5 line_buffer
(
    .clk(clk),
    .rst_n(rst_n),
    .valid_in(valid_in),
    .pixel_in(data_in),
    .valid_out(lb_valid),
    .w00(w00), .w01(w01), .w02(w02), .w03(w03), .w04(w04),
    .w10(w10), .w11(w11), .w12(w12), .w13(w13), .w14(w14),
    .w20(w20), .w21(w21), .w22(w22), .w23(w23), .w24(w24),
    .w30(w30), .w31(w31), .w32(w32), .w33(w33), .w34(w34),
    .w40(w40), .w41(w41), .w42(w42), .w43(w43), .w44(w44)
);


systolic_array_5x5 #(.WEIGHT_FILE("conv1_weight_1.mem")) sa1
(
    .clk(clk), .rst_n(rst_n), .valid_in(lb_valid),
    .a00(w00), .a01(w01), .a02(w02), .a03(w03), .a04(w04),
    .a10(w10), .a11(w11), .a12(w12), .a13(w13), .a14(w14),
    .a20(w20), .a21(w21), .a22(w22), .a23(w23), .a24(w24),
    .a30(w30), .a31(w31), .a32(w32), .a33(w33), .a34(w34),
    .a40(w40), .a41(w41), .a42(w42), .a43(w43), .a44(w44),
    .conv_out(conv_raw_1), .valid_out(sa_valid_1)
);
systolic_array_5x5 #(.WEIGHT_FILE("conv1_weight_2.mem")) sa2
(
    .clk(clk), .rst_n(rst_n), .valid_in(lb_valid),
    .a00(w00), .a01(w01), .a02(w02), .a03(w03), .a04(w04),
    .a10(w10), .a11(w11), .a12(w12), .a13(w13), .a14(w14),
    .a20(w20), .a21(w21), .a22(w22), .a23(w23), .a24(w24),
    .a30(w30), .a31(w31), .a32(w32), .a33(w33), .a34(w34),
    .a40(w40), .a41(w41), .a42(w42), .a43(w43), .a44(w44),
    .conv_out(conv_raw_2), .valid_out(sa_valid_2)
);
systolic_array_5x5 #(.WEIGHT_FILE("conv1_weight_3.mem")) sa3
(
    .clk(clk), .rst_n(rst_n), .valid_in(lb_valid),
    .a00(w00), .a01(w01), .a02(w02), .a03(w03), .a04(w04),
    .a10(w10), .a11(w11), .a12(w12), .a13(w13), .a14(w14),
    .a20(w20), .a21(w21), .a22(w22), .a23(w23), .a24(w24),
    .a30(w30), .a31(w31), .a32(w32), .a33(w33), .a34(w34),
    .a40(w40), .a41(w41), .a42(w42), .a43(w43), .a44(w44),
    .conv_out(conv_raw_3), .valid_out(sa_valid_3)
);
assign conv_out_1 = conv_raw_1 + conv1_bias_ext_1;
assign conv_out_2 = conv_raw_2 + conv1_bias_ext_2;
assign conv_out_3 = conv_raw_3 + conv1_bias_ext_3;


assign valid_out = sa_valid_1 & sa_valid_2 & sa_valid_3;


endmodule

