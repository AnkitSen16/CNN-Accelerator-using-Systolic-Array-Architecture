`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.05.2026 23:27:58
// Design Name: 
// Module Name: top_tb_1000_systolic
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


`timescale 1ns/1ps

module top_tb_1000_systolic();

////////////////////////////////////////////////////////////
// PARAMETERS
////////////////////////////////////////////////////////////

localparam NUM_IMAGES = 1000;
localparam IMG_SIZE   = 784;

////////////////////////////////////////////////////////////
// CLOCK / RESET
////////////////////////////////////////////////////////////

reg clk;
reg rst_n;

always #5 clk = ~clk;

////////////////////////////////////////////////////////////
// IMAGE MEMORY
////////////////////////////////////////////////////////////

reg [7:0] pixels [0:783999];

////////////////////////////////////////////////////////////
// TESTBENCH CONTROL SIGNALS
////////////////////////////////////////////////////////////

reg [9:0] cnt;          // number of tested images
reg [9:0] img_idx;      // pixel index inside one image
reg [9:0] rand_num;     // selected image index
reg [7:0] data_in;
reg       valid_in;

reg [1:0] state;

localparam ST_RESET = 2'd0;
localparam ST_SEND  = 2'd1;
localparam ST_WAIT  = 2'd2;
localparam ST_DONE  = 2'd3;

integer reset_count;

reg [9:0] accuracy;

////////////////////////////////////////////////////////////
// LATENCY MEASUREMENT
////////////////////////////////////////////////////////////

integer cycle_counter;
integer start_cycle;
integer end_cycle;
integer latency;

always @(posedge clk) begin
    if (!rst_n)
        cycle_counter <= 0;
    else
        cycle_counter <= cycle_counter + 1;
end

////////////////////////////////////////////////////////////
// CNN INTERNAL WIRES
////////////////////////////////////////////////////////////

wire signed [11:0] conv_out_1;
wire signed [11:0] conv_out_2;
wire signed [11:0] conv_out_3;

wire signed [11:0] conv2_out_1;
wire signed [11:0] conv2_out_2;
wire signed [11:0] conv2_out_3;

wire signed [11:0] max_value_1;
wire signed [11:0] max_value_2;
wire signed [11:0] max_value_3;

wire signed [11:0] max2_value_1;
wire signed [11:0] max2_value_2;
wire signed [11:0] max2_value_3;

wire signed [11:0] fc_out_data;

wire [3:0] decision;

wire valid_out_1;
wire valid_out_2;
wire valid_out_3;
wire valid_out_4;
wire valid_out_5;
wire valid_out_6;

////////////////////////////////////////////////////////////
// MODULE INSTANTIATION
////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////
// SYSTOLIC CONV1
////////////////////////////////////////////////////////////

conv1_systolic conv1_systolic_inst
(
    .clk(clk),
    .rst_n(rst_n),
    .valid_in(valid_in),
    .data_in(data_in),

    .conv_out_1(conv_out_1),
    .conv_out_2(conv_out_2),
    .conv_out_3(conv_out_3),
    .valid_out(valid_out_1)
);

////////////////////////////////////////////////////////////
// MAXPOOL + RELU 1
////////////////////////////////////////////////////////////

maxpool_relu
#(
    .CONV_BIT(12),
    .HALF_WIDTH(12),
    .HALF_HEIGHT(12),
    .HALF_WIDTH_BIT(4)
)
maxpool_relu_1
(
    .clk(clk),
    .rst_n(rst_n),
    .valid_in(valid_out_1),

    .conv_out_1(conv_out_1),
    .conv_out_2(conv_out_2),
    .conv_out_3(conv_out_3),

    .max_value_1(max_value_1),
    .max_value_2(max_value_2),
    .max_value_3(max_value_3),

    .valid_out_relu(valid_out_2)
);

////////////////////////////////////////////////////////////
// CONV2 LAYER
// Use your systolic/modified conv2_layer here.
////////////////////////////////////////////////////////////

conv2_layer conv2_layer_inst
(
    .clk(clk),
    .rst_n(rst_n),
    .valid_in(valid_out_2),

    .max_value_1(max_value_1),
    .max_value_2(max_value_2),
    .max_value_3(max_value_3),

    .conv2_out_1(conv2_out_1),
    .conv2_out_2(conv2_out_2),
    .conv2_out_3(conv2_out_3),

    .valid_out_conv2(valid_out_3)
);

////////////////////////////////////////////////////////////
// MAXPOOL + RELU 2
////////////////////////////////////////////////////////////

maxpool_relu
#(
    .CONV_BIT(12),
    .HALF_WIDTH(4),
    .HALF_HEIGHT(4),
    .HALF_WIDTH_BIT(3)
)
maxpool_relu_2
(
    .clk(clk),
    .rst_n(rst_n),
    .valid_in(valid_out_3),

    .conv_out_1(conv2_out_1),
    .conv_out_2(conv2_out_2),
    .conv_out_3(conv2_out_3),

    .max_value_1(max2_value_1),
    .max_value_2(max2_value_2),
    .max_value_3(max2_value_3),

    .valid_out_relu(valid_out_4)
);

////////////////////////////////////////////////////////////
// FULLY CONNECTED
////////////////////////////////////////////////////////////

fully_connected
#(
    .INPUT_NUM(48),
    .OUTPUT_NUM(10),
    .DATA_BITS(8)
)
fully_connected_inst
(
    .clk(clk),
    .rst_n(rst_n),
    .valid_in(valid_out_4),

    .data_in_1(max2_value_1),
    .data_in_2(max2_value_2),
    .data_in_3(max2_value_3),

    .data_out(fc_out_data),
    .valid_out_fc(valid_out_5)
);

////////////////////////////////////////////////////////////
// COMPARATOR
////////////////////////////////////////////////////////////

comparator comparator_inst
(
    .clk(clk),
    .rst_n(rst_n),
    .valid_in(valid_out_5),
    .data_in(fc_out_data),

    .decision(decision),
    .valid_out(valid_out_6)
);

////////////////////////////////////////////////////////////
// INITIAL BLOCK
////////////////////////////////////////////////////////////

initial begin
    clk         = 1'b0;
    rst_n       = 1'b0;
    data_in     = 8'd0;
    valid_in    = 1'b0;

    cnt         = 0;
    img_idx     = 0;
    rand_num    = 0;
    accuracy    = 0;

    state       = ST_RESET;
    reset_count = 0;

    cycle_counter = 0;
    start_cycle   = 0;
    end_cycle     = 0;
    latency       = 0;

    $readmemh("input_1000.txt", pixels);

    #100;
end

////////////////////////////////////////////////////////////
// MAIN TESTBENCH FSM
////////////////////////////////////////////////////////////

always @(posedge clk) begin

    case (state)

        //////////////////////////////////////////////////////
        // RESET DUT BEFORE EACH IMAGE
        //////////////////////////////////////////////////////

        ST_RESET: begin
            rst_n    <= 1'b0;
            valid_in <= 1'b0;
            data_in  <= 8'd0;
            img_idx  <= 0;

            reset_count <= reset_count + 1;

            if (reset_count == 10) begin
                rst_n       <= 1'b1;
                reset_count <= 0;

                // Sequential image order.
                // Since your labels are j % 10, this gives:
                // image 0 -> digit 0
                // image 1 -> digit 1
                // ...
                rand_num <= cnt;

                // If you want random testing instead, comment above line
                // and uncomment below line:
                // rand_num <= $urandom_range(0, 999);

                start_cycle <= cycle_counter;

                state <= ST_SEND;
            end
        end

        //////////////////////////////////////////////////////
        // SEND 784 PIXELS
        //////////////////////////////////////////////////////

        ST_SEND: begin
            rst_n    <= 1'b1;
            valid_in <= 1'b1;

            data_in <= pixels[rand_num * IMG_SIZE + img_idx];

            if (img_idx == IMG_SIZE-1) begin
                img_idx  <= 0;
                valid_in <= 1'b0;
                data_in  <= 8'd0;
                state    <= ST_WAIT;
            end
            else begin
                img_idx <= img_idx + 1'b1;
            end
        end

        //////////////////////////////////////////////////////
        // WAIT FOR CNN DECISION
        //////////////////////////////////////////////////////

        ST_WAIT: begin
            valid_in <= 1'b0;
            data_in  <= 8'd0;

            if (valid_out_6 == 1'b1) begin

                end_cycle = cycle_counter;
                latency   = end_cycle - start_cycle;

                if (decision == rand_num % 10) begin
                    accuracy <= accuracy + 1'b1;

                    $display("Input image %0d: original value = %0d, decision = %0d ==> Success, Latency = %0d cycles",
                             cnt,
                             rand_num % 10,
                             decision,
                             latency);
                end
                else begin
                    $display("Input image %0d: original value = %0d, decision = %0d ==> Fail, Latency = %0d cycles",
                             cnt,
                             rand_num % 10,
                             decision,
                             latency);
                end

                cnt <= cnt + 1'b1;

                if (cnt == NUM_IMAGES-1) begin
                    state <= ST_DONE;
                end
                else begin
                    state <= ST_RESET;
                end
            end
        end

        //////////////////////////////////////////////////////
        // PRINT FINAL ACCURACY
        //////////////////////////////////////////////////////

        ST_DONE: begin
            valid_in <= 1'b0;
            data_in  <= 8'd0;

            $display("");
            $display("------ Final Accuracy for %0d Input Image ------", NUM_IMAGES);
            $display("Accuracy : %0f%%", (accuracy * 100.0) / NUM_IMAGES);
            $display("Correct  : %0d / %0d", accuracy, NUM_IMAGES);
            $display("Last Image Latency : %0d cycles", latency);
            $display("");

            $stop;
        end

        default: begin
            state <= ST_RESET;
        end

    endcase
end

endmodule

