`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.05.2026 17:50:39
// Design Name: 
// Module Name: axis_cnn_mnist
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


//module axis_cnn_mnist
//    (
//        input  wire       aclk,
//        input  wire       aresetn,
//        output wire       s_axis_tready,
//        input  wire [31:0] s_axis_tdata,
//        input  wire       s_axis_tvalid,
//        input  wire       m_axis_tready,
//        output wire [31:0] m_axis_tdata,
//        output wire       m_axis_tvalid,
//        output wire       m_axis_tlast
//        //output wire signed [11:0] conv_out_1, conv_out_2, conv_out_3,
//        //output wire signed [11:0] conv2_out_1, conv2_out_2, conv2_out_3,
//        //output wire signed [11:0] max_value_1, max_value_2, max_value_3,
//        //output wire signed [11:0] max2_value_1, max2_value_2, max2_value_3,
//        //output wire signed [11:0] fc_out_data
//    );

    
//    wire signed [11:0] conv_out_1, conv_out_2, conv_out_3;
//    wire signed [11:0] conv2_out_1, conv2_out_2, conv2_out_3;
//    wire signed [11:0] max_value_1, max_value_2, max_value_3;
//    wire signed [11:0] max2_value_1, max2_value_2, max2_value_3;
//    wire signed [11:0] fc_out_data;
//    wire valid_out_1, valid_out_2, valid_out_3, valid_out_4, valid_out_5, valid_out_6;
//    wire [3:0] decision;
    
//    reg [31:0] s_axis_tdata_reg;
//    reg s_axis_tvalid_reg;
//    wire s_axis_tvalid_tick;
//    reg [10:0] cnt_sequencer_reg;
//    wire valid_in;
//    wire clr;
        
//    conv1_systolic conv1
//    (
//        .clk(aclk),
//        .rst_n(aresetn),
    
//        .valid_in(s_axis_tvalid),
//        .data_in(s_axis_tdata),
    
//        .conv_out_1(conv_out_1),
//        .conv_out_2(conv_out_2),
//        .conv_out_3(conv_out_3),
    
//        .valid_out(valid_out_1)
//    );

//    maxpool_relu
//    #(
//        .CONV_BIT(12),
//        .HALF_WIDTH(12),
//        .HALF_HEIGHT(12),
//        .HALF_WIDTH_BIT(4)
//    )
//    maxpool_relu_1
//    (
//        .clk(aclk),
//        .rst_n(aresetn & clr),
//        .valid_in(valid_out_1),
//        .conv_out_1(conv_out_1),
//        .conv_out_2(conv_out_2),
//        .conv_out_3(conv_out_3),
//        .max_value_1(max_value_1),
//        .max_value_2(max_value_2),
//        .max_value_3(max_value_3),
//        .valid_out_relu(valid_out_2)
//    );

//    conv2_layer conv2_layer
//    (
//        .clk(aclk),
//        .rst_n(aresetn & clr),
//        .valid_in(valid_out_2),
//        .max_value_1(max_value_1),
//        .max_value_2(max_value_2),
//        .max_value_3(max_value_3),
//        .conv2_out_1(conv2_out_1),
//        .conv2_out_2(conv2_out_2),
//        .conv2_out_3(conv2_out_3),
//        .valid_out_conv2(valid_out_3)
//    );

//    maxpool_relu
//    #(
//        .CONV_BIT(12),
//        .HALF_WIDTH(4),
//        .HALF_HEIGHT(4),
//        .HALF_WIDTH_BIT(3)
//    )
//    maxpool_relu_2
//    (
//        .clk(aclk),
//        .rst_n(aresetn & clr),
//        .valid_in(valid_out_3),
//        .conv_out_1(conv2_out_1),
//        .conv_out_2(conv2_out_2),
//        .conv_out_3(conv2_out_3),
//        .max_value_1(max2_value_1),
//        .max_value_2(max2_value_2),
//        .max_value_3(max2_value_3),
//        .valid_out_relu(valid_out_4)
//    );
//    fully_connected
//    #(
//        .INPUT_NUM(48),
//        .OUTPUT_NUM(10),
//        .DATA_BITS(8)
//    )
//    fully_connected
//    (
//        .clk(aclk),
//        .rst_n(aresetn & clr),
//        .valid_in(valid_out_4),
//        .data_in_1(max2_value_1),
//        .data_in_2(max2_value_2),
//        .data_in_3(max2_value_3),
//        .data_out(fc_out_data),
//        .valid_out_fc(valid_out_5)
//    );

//    comparator comparator
//    (
//        .clk(aclk),
//        .rst_n(aresetn & clr),
//        .valid_in(valid_out_5),
//        .data_in(fc_out_data),
//        .decision(decision),
//        .valid_out(valid_out_6)
//    );
    
//   always @(posedge aclk)
//    begin
//        if (!aresetn)
//        begin
//            s_axis_tdata_reg <= 0;
//        end
//        else
//        begin
//            s_axis_tdata_reg <= s_axis_tdata;
//        end
//    end   
    
//    // Rising edge detector
//    always @(posedge aclk)
//    begin
//        if (!aresetn)
//        begin
//            s_axis_tvalid_reg <= 0;
//        end
//        else
//        begin
//            s_axis_tvalid_reg <= s_axis_tvalid;
//        end
//    end
//    assign s_axis_tvalid_tick = s_axis_tvalid & ~s_axis_tvalid_reg;
    
//    // Counter sequencer as a global FSM
//    always @(posedge aclk)
//    begin
//        if (!aresetn)
//        begin
//            cnt_sequencer_reg <= 0;
//        end
//        else if (s_axis_tvalid_tick)
//        begin
//            cnt_sequencer_reg <= cnt_sequencer_reg + 1;
//        end
//        else if (cnt_sequencer_reg >= 1 && cnt_sequencer_reg <= 1280)
//        begin
//            cnt_sequencer_reg <= cnt_sequencer_reg + 1;
//        end
//        else if (cnt_sequencer_reg >= 1281)
//        begin
//            cnt_sequencer_reg <= 0;
//        end
//    end
    
//    assign s_axis_tready = 1'b1;
    
//    reg [7:0] m_axis_tdata_hold;
//    reg       m_axis_tvalid_hold;
//    reg       m_axis_tlast_hold;
    
//    always @(posedge aclk) begin
//        if (!aresetn) begin
//            m_axis_tdata_hold  <= 8'd0;
//            m_axis_tvalid_hold <= 1'b0;
//            m_axis_tlast_hold  <= 1'b0;
//        end
//        else begin
//            if (m_axis_tvalid_hold && m_axis_tready) begin
//                m_axis_tvalid_hold <= 1'b0;
//                m_axis_tlast_hold  <= 1'b0;
//            end
    
//            if (valid_out_6) begin
//                m_axis_tdata_hold  <= {4'b0000, decision};
//                m_axis_tvalid_hold <= 1'b1;
//                m_axis_tlast_hold  <= 1'b1;
//            end
//        end
//    end
    
//    assign m_axis_tdata  = m_axis_tdata_hold;
//    assign m_axis_tvalid = m_axis_tvalid_hold;
//    assign m_axis_tlast  = m_axis_tlast_hold;
    
//    assign clr = 1'b1;



//endmodule
module axis_cnn_mnist
(
    input  wire       aclk,
    input  wire       aresetn,

    // Slave AXIS
    output wire       s_axis_tready,
    input  wire [31:0] s_axis_tdata,
    input  wire       s_axis_tvalid,

    // Master AXIS
    input  wire       m_axis_tready,
    output wire [31:0] m_axis_tdata,
    output wire       m_axis_tvalid,
    output wire       m_axis_tlast,
    output wire signed [11:0] conv_out_1, conv_out_2, conv_out_3,
    output wire signed [11:0] conv2_out_1, conv2_out_2, conv2_out_3,
    output wire signed [11:0] max_value_1, max_value_2, max_value_3,
    output wire signed [11:0] max2_value_1, max2_value_2, max2_value_3,
    output wire signed [11:0] fc_out_data
);

//////////////////////////////////////////////////////////////
// Internal Signals
//////////////////////////////////////////////////////////////
// wire signed [11:0] conv_out_1, conv_out_2, conv_out_3;
// wire signed [11:0] conv2_out_1, conv2_out_2, conv2_out_3;
// wire signed [11:0] max_value_1, max_value_2, max_value_3;
// wire signed [11:0] max2_value_1, max2_value_2, max2_value_3;
// wire signed [11:0] fc_out_data;
 wire valid_out_1, valid_out_2, valid_out_3, valid_out_4, valid_out_5, valid_out_6;
 wire [3:0] decision;

//////////////////////////////////////////////////////////////
// AXIS INPUT HANDSHAKE
//////////////////////////////////////////////////////////////

wire input_handshake;

assign s_axis_tready = 1'b1;

assign input_handshake =
        s_axis_tvalid &&
        s_axis_tready;

conv1_systolic conv1
(
    .clk(aclk),
    .rst_n(aresetn),

    .valid_in(input_handshake),
    .data_in(s_axis_tdata),

    .conv_out_1(conv_out_1),
    .conv_out_2(conv_out_2),
    .conv_out_3(conv_out_3),

    .valid_out(valid_out_1)
);

maxpool_relu
#(
    .CONV_BIT(12),
    .HALF_WIDTH(12),
    .HALF_HEIGHT(12),
    .HALF_WIDTH_BIT(4)
)
maxpool_relu_1
(
    .clk(aclk),
    .rst_n(aresetn),

    .valid_in(valid_out_1),

    .conv_out_1(conv_out_1),
    .conv_out_2(conv_out_2),
    .conv_out_3(conv_out_3),

    .max_value_1(max_value_1),
    .max_value_2(max_value_2),
    .max_value_3(max_value_3),

    .valid_out_relu(valid_out_2)
);

reg signed [11:0] max_value_1_r;
reg signed [11:0] max_value_2_r;
reg signed [11:0] max_value_3_r;
reg valid_out_2_r;

always @(posedge aclk)
begin
    if(!aresetn)
    begin
        max_value_1_r <= 0;
        max_value_2_r <= 0;
        max_value_3_r <= 0;
        valid_out_2_r <= 0;
    end
    else
    begin
        max_value_1_r <= max_value_1;
        max_value_2_r <= max_value_2;
        max_value_3_r <= max_value_3;
        valid_out_2_r <= valid_out_2;
    end
end

conv2_layer conv2
(
    .clk(aclk),
    .rst_n(aresetn),

    .valid_in(valid_out_2_r),

    .max_value_1(max_value_1_r),
    .max_value_2(max_value_2_r),
    .max_value_3(max_value_3_r),

    .conv2_out_1(conv2_out_1),
    .conv2_out_2(conv2_out_2),
    .conv2_out_3(conv2_out_3),

    .valid_out_conv2(valid_out_3)
);

maxpool_relu
#(
    .CONV_BIT(12),
    .HALF_WIDTH(4),
    .HALF_HEIGHT(4),
    .HALF_WIDTH_BIT(3)
)
maxpool_relu_2
(
    .clk(aclk),
    .rst_n(aresetn),

    .valid_in(valid_out_3),

    .conv_out_1(conv2_out_1),
    .conv_out_2(conv2_out_2),
    .conv_out_3(conv2_out_3),

    .max_value_1(max2_value_1),
    .max_value_2(max2_value_2),
    .max_value_3(max2_value_3),

    .valid_out_relu(valid_out_4)
);

fully_connected
#(
    .INPUT_NUM(48),
    .OUTPUT_NUM(10),
    .DATA_BITS(8)
)
fc
(
    .clk(aclk),
    .rst_n(aresetn),

    .valid_in(valid_out_4),

    .data_in_1(max2_value_1),
    .data_in_2(max2_value_2),
    .data_in_3(max2_value_3),

    .data_out(fc_out_data),

    .valid_out_fc(valid_out_5)
);

comparator comp
(
    .clk(aclk),
    .rst_n(aresetn),

    .valid_in(valid_out_5),

    .data_in(fc_out_data),

    .decision(decision),

    .valid_out(valid_out_6)
);

//////////////////////////////////////////////////////////////
// AXIS OUTPUT REGISTER
//////////////////////////////////////////////////////////////

reg [7:0] m_axis_tdata_reg;
reg       m_axis_tvalid_reg;
reg       m_axis_tlast_reg;

always @(posedge aclk)
begin
    if(!aresetn)
    begin
        m_axis_tdata_reg  <= 0;
        m_axis_tvalid_reg <= 0;
        m_axis_tlast_reg  <= 0;
    end
    else
    begin

        // Transfer completed
        if(m_axis_tvalid_reg && m_axis_tready)
        begin
            m_axis_tvalid_reg <= 0;
            m_axis_tlast_reg  <= 0;
        end

        // Load new output only if buffer empty
        if(valid_out_6 && !m_axis_tvalid_reg)
        begin
            m_axis_tdata_reg  <= {4'b0000, decision};
            m_axis_tvalid_reg <= 1'b1;
            m_axis_tlast_reg  <= 1'b1;
        end
    end
end

assign m_axis_tdata  = m_axis_tdata_reg;
assign m_axis_tvalid = m_axis_tvalid_reg;
assign m_axis_tlast  = m_axis_tlast_reg;

endmodule
