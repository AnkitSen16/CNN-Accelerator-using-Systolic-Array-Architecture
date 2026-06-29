`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.05.2026 17:47:55
// Design Name: 
// Module Name: fully_connected
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



module fully_connected
#(
    parameter INPUT_NUM  = 48,
    parameter OUTPUT_NUM = 10,
    parameter DATA_BITS  = 8
)
(
    input  wire               clk,
    input  wire               rst_n,
    input  wire               valid_in,

    input  wire signed [11:0] data_in_1,
    input  wire signed [11:0] data_in_2,
    input  wire signed [11:0] data_in_3,

    output reg  signed [11:0] data_out,
    output reg                valid_out_fc
);

localparam INPUT_WIDTH = 16;       
localparam LAST_IDX    = INPUT_WIDTH - 1;  

localparam ST_COLLECT = 1'd0;
localparam ST_OUTPUT  = 1'd1;

reg state;

reg [4:0] buf_idx;   
reg [3:0] out_idx;   

reg signed [DATA_BITS-1:0] weight [0:INPUT_NUM*OUTPUT_NUM-1];
reg signed [DATA_BITS-1:0] bias   [0:OUTPUT_NUM-1];

initial begin
    $readmemh("fc_weight.mem", weight);
    $readmemh("fc_bias.mem",   bias);
end

wire signed [13:0] data1;
wire signed [13:0] data2;
wire signed [13:0] data3;

assign data1 = {{2{data_in_1[11]}}, data_in_1};
assign data2 = {{2{data_in_2[11]}}, data_in_2};
assign data3 = {{2{data_in_3[11]}}, data_in_3};

 reg signed [31:0] acc [0:OUTPUT_NUM-1];

integer output_neuron;

function signed [31:0] bias_ext;
    input integer idx;
    begin
        bias_ext = {{24{bias[idx][7]}}, bias[idx]};
    end
endfunction


function signed [DATA_BITS-1:0] d3_last_weight;
    input integer neuron_idx;
    begin
        if (neuron_idx == 0)
            d3_last_weight = {DATA_BITS{1'b0}};
        else
            d3_last_weight = weight[(neuron_idx-1)*INPUT_NUM + (INPUT_NUM-1)];
    end
endfunction

always @(posedge clk) begin
    if (!rst_n) begin

        state        <= ST_COLLECT;
        buf_idx      <= 5'd0;
        out_idx      <= 4'd0;
        data_out     <= 12'sd0;
        valid_out_fc <= 1'b0;

        for (output_neuron = 0; output_neuron < OUTPUT_NUM; output_neuron = output_neuron + 1)
            acc[output_neuron] <= 32'sd0;

    end
    else begin

        valid_out_fc <= 1'b0;

        case (state)

        ST_COLLECT: begin
            if (valid_in) begin

                for (output_neuron = 0; output_neuron < OUTPUT_NUM; output_neuron = output_neuron + 1) begin 

                    if (buf_idx == 5'd0) begin
                        acc[output_neuron] <= bias_ext(output_neuron)
                                + data1 * weight[output_neuron*INPUT_NUM + buf_idx]
                                + data2 * weight[output_neuron*INPUT_NUM + INPUT_WIDTH + buf_idx]
                                + data3 * weight[output_neuron*INPUT_NUM + INPUT_WIDTH*2 + buf_idx];
                    end
                    else if (buf_idx != LAST_IDX) begin
                        acc[output_neuron] <= acc[output_neuron]
                                + data1 * weight[output_neuron*INPUT_NUM + buf_idx]
                                + data2 * weight[output_neuron*INPUT_NUM + INPUT_WIDTH + buf_idx]
                                + data3 * weight[output_neuron*INPUT_NUM + INPUT_WIDTH*2 + buf_idx];
                    end
                    else begin
                        acc[output_neuron] <= acc[output_neuron]
                                + data1 * weight[output_neuron*INPUT_NUM + buf_idx]
                                + data2 * weight[output_neuron*INPUT_NUM + INPUT_WIDTH + buf_idx]
                                + data3 * d3_last_weight(output_neuron);
                    end
                end

                if (buf_idx == LAST_IDX) begin
                    buf_idx <= 5'd0;
                    out_idx <= 4'd0;
                    state   <= ST_OUTPUT;
                end
                else begin
                    buf_idx <= buf_idx + 1'b1;
                end
            end
        end

        ST_OUTPUT: begin
            data_out     <= acc[out_idx][18:7];
            valid_out_fc <= 1'b1;

            if (out_idx == OUTPUT_NUM-1) begin
                out_idx <= 4'd0;
                state   <= ST_COLLECT;
            end
            else begin
                out_idx <= out_idx + 1'b1;
            end
        end

        default: state <= ST_COLLECT;

        endcase

    end
end

endmodule
//module fully_connected
//#(
//    parameter INPUT_NUM  = 48,
//    parameter OUTPUT_NUM = 10,
//    parameter DATA_BITS  = 8
//)
//(
//    input  wire               clk,
//    input  wire               rst_n,
//    input  wire               valid_in,

//    input  wire signed [11:0] data_in_1,
//    input  wire signed [11:0] data_in_2,
//    input  wire signed [11:0] data_in_3,

//    output reg  signed [11:0] data_out,
//    output reg                valid_out_fc
//);

//localparam INPUT_WIDTH = 16;

////====================================================
//// FSM STATES
////====================================================
//reg [1:0] state;

//localparam ST_COLLECT = 2'd0;
//localparam ST_COMPUTE = 2'd1;

////====================================================
//// REGISTERS
////====================================================
//reg [4:0] buf_idx;
//reg [3:0] out_idx;
//reg [5:0] mac_idx;

//reg signed [13:0] buffer [0:INPUT_NUM-1];

//reg signed [DATA_BITS-1:0] weight [0:INPUT_NUM*OUTPUT_NUM-1];
//reg signed [DATA_BITS-1:0] bias   [0:OUTPUT_NUM-1];

//(* use_dsp = "yes" *) reg signed [31:0] acc;

////====================================================
//// INPUT EXTENSION
////====================================================
//wire signed [13:0] data1;
//wire signed [13:0] data2;
//wire signed [13:0] data3;

//assign data1 = {{2{data_in_1[11]}}, data_in_1};
//assign data2 = {{2{data_in_2[11]}}, data_in_2};
//assign data3 = {{2{data_in_3[11]}}, data_in_3};

////====================================================
//// VARIABLES
////====================================================
//integer i;

////====================================================
//// LOAD WEIGHTS / BIASES
////====================================================
//initial begin
//    $readmemh("fc_weight.mem", weight);
//    $readmemh("fc_bias.mem", bias);
//end

////====================================================
//// MAIN FSM
////====================================================
//always @(posedge clk) begin

//    if (~rst_n) begin

//        state <= ST_COLLECT;

//        buf_idx <= 0;
//        out_idx <= 0;
//        mac_idx <= 0;

//        acc <= 0;

//        data_out <= 0;
//        valid_out_fc <= 0;

//        for (i = 0; i < INPUT_NUM; i = i + 1)
//            buffer[i] <= 0;

//    end
//    else begin

//        valid_out_fc <= 1'b0;

//        case (state)

//        //================================================
//        // COLLECT INPUT FEATURE MAPS
//        //================================================
//        ST_COLLECT: begin

//            if (valid_in) begin

//                buffer[buf_idx]                   <= data1;
//                buffer[INPUT_WIDTH + buf_idx]    <= data2;
//                buffer[(INPUT_WIDTH*2) + buf_idx] <= data3;

//                if (buf_idx == INPUT_WIDTH-1) begin

//                    buf_idx <= 0;
//                    out_idx <= 0;
//                    mac_idx <= 0;

//                    state <= ST_COMPUTE;

//                end
//                else begin
//                    buf_idx <= buf_idx + 1'b1;
//                end
//            end
//        end

//        //================================================
//        // SEQUENTIAL MAC COMPUTATION
//        //================================================
//        ST_COMPUTE: begin

//            //------------------------------------------------
//            // Initialize accumulator with bias
//            //------------------------------------------------
//            if (mac_idx == 0) begin

//                acc <= {{24{bias[out_idx][7]}}, bias[out_idx]};
//                mac_idx <= mac_idx + 1'b1;

//            end

//            //------------------------------------------------
//            // Multiply Accumulate
//            //------------------------------------------------
//            else if (mac_idx <= INPUT_NUM) begin

//                acc <= acc +
//                       buffer[mac_idx-1] *
//                       weight[(out_idx * INPUT_NUM) + (mac_idx-1)];

//                mac_idx <= mac_idx + 1'b1;

//            end

//            //------------------------------------------------
//            // Output result
//            //------------------------------------------------
//            else begin

//                data_out <= acc[18:7];
//                valid_out_fc <= 1'b1;

//                mac_idx <= 0;

//                if (out_idx == OUTPUT_NUM-1) begin

//                    out_idx <= 0;
//                    state <= ST_COLLECT;

//                end
//                else begin

//                    out_idx <= out_idx + 1'b1;

//                end
//            end
//        end

//        //================================================
//        // DEFAULT
//        //================================================
//        default: begin
//            state <= ST_COLLECT;
//        end

//        endcase
//    end
//end

//endmodule


