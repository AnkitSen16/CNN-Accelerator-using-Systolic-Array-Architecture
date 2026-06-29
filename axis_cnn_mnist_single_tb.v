`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.06.2026 16:22:45
// Design Name: 
// Module Name: axis_cnn_mnist_single_tb
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

module axis_cnn_mnist_single_tb;

    localparam integer DIGIT_INDEX = 1;

    reg [8*32-1:0] IMAGE_FILE;    

    reg aclk;
    reg aresetn;

    initial begin
        aclk = 1'b0;
        forever #5 aclk = ~aclk;     
    end

    wire        s_axis_tready;
    reg  [7:0]  s_axis_tdata;
    reg         s_axis_tvalid;

    reg         m_axis_tready;
    wire [7:0]  m_axis_tdata;
    wire        m_axis_tvalid;
    wire        m_axis_tlast;

    wire signed [11:0] conv_out_1,  conv_out_2,  conv_out_3;
    wire signed [11:0] conv2_out_1, conv2_out_2, conv2_out_3;
    wire signed [11:0] max_value_1, max_value_2, max_value_3;
    wire signed [11:0] max2_value_1,max2_value_2,max2_value_3;
    wire signed [11:0] fc_out_data;

    reg [7:0] pixels [0:783];

    reg signed [11:0] fc_scores [0:9];
    integer            fc_capture_idx;

    integer    i;
    integer    timeout_count;
    reg [3:0]  predicted_digit;
    integer    start_cycle, end_cycle, latency, cycle_counter;

    always @(posedge aclk) begin
        if (!aresetn) cycle_counter <= 0;
        else          cycle_counter <= cycle_counter + 1;
    end

    axis_cnn_mnist dut (
        .aclk           (aclk),
        .aresetn        (aresetn),
        .s_axis_tready  (s_axis_tready),
        .s_axis_tdata   (s_axis_tdata),
        .s_axis_tvalid  (s_axis_tvalid),
        .m_axis_tready  (m_axis_tready),
        .m_axis_tdata   (m_axis_tdata),
        .m_axis_tvalid  (m_axis_tvalid),
        .m_axis_tlast   (m_axis_tlast),
        .conv_out_1     (conv_out_1),
        .conv_out_2     (conv_out_2),
        .conv_out_3     (conv_out_3),
        .conv2_out_1    (conv2_out_1),
        .conv2_out_2    (conv2_out_2),
        .conv2_out_3    (conv2_out_3),
        .max_value_1    (max_value_1),
        .max_value_2    (max_value_2),
        .max_value_3    (max_value_3),
        .max2_value_1   (max2_value_1),
        .max2_value_2   (max2_value_2),
        .max2_value_3   (max2_value_3),
        .fc_out_data    (fc_out_data)
    );

    always @(posedge aclk) begin
        if (!aresetn) begin
            fc_capture_idx <= 0;
            for (i = 0; i < 10; i = i + 1)
                fc_scores[i] <= 12'sd0;
        end
        else begin
            if (dut.valid_out_5 && (fc_capture_idx < 10)) begin
                fc_scores[fc_capture_idx] <= fc_out_data;
                fc_capture_idx            <= fc_capture_idx + 1;
            end
        end
    end

    task reset_dut;
        begin
            s_axis_tvalid = 1'b0;
            s_axis_tdata  = 8'd0;
            m_axis_tready = 1'b0;

            aresetn = 1'b0;
            repeat (10) @(posedge aclk);

            aresetn = 1'b1;
            repeat (5) @(posedge aclk);
        end
    endtask

    initial begin
        s_axis_tdata  = 8'd0;
        s_axis_tvalid = 1'b0;
        m_axis_tready = 1'b0;
        aresetn       = 1'b0;

        $sformat(IMAGE_FILE, "digit_%0d.txt", DIGIT_INDEX);

        $readmemh(IMAGE_FILE, pixels);

        reset_dut();

        @(posedge aclk);
        start_cycle = cycle_counter;
        m_axis_tready = 1'b0;

        for (i = 0; i < 784; i = i + 1) begin
            @(negedge aclk);
            s_axis_tdata  = pixels[i];
            s_axis_tvalid = 1'b1;

            @(posedge aclk);
            while (!s_axis_tready) begin
                @(posedge aclk);
            end
        end

        @(negedge aclk);
        s_axis_tvalid = 1'b0;
        s_axis_tdata  = 8'd0;

        timeout_count = 0;
        while ((m_axis_tvalid !== 1'b1) && (timeout_count < 50000)) begin
            @(posedge aclk);
            timeout_count = timeout_count + 1;
        end

        if (timeout_count >= 50000) begin
            $display("ERROR: Timeout waiting for output.");
            $finish;
        end

        predicted_digit = m_axis_tdata[3:0];

        @(negedge aclk);
        m_axis_tready = 1'b1;
        @(posedge aclk);
        @(negedge aclk);
        m_axis_tready = 1'b0;

        end_cycle = cycle_counter;
        latency   = end_cycle - start_cycle;

        repeat (20) @(posedge aclk);
        
        $display("");
        for (i = 0; i < 10; i = i + 1) begin
            $display("FC Score[%0d] = %0d", i, $signed(fc_scores[i]));
        end

        $display("");
        $display("=== SINGLE IMAGE TEST RESULT ===");
        $display("Image file : %0s (expected digit = %0d)", IMAGE_FILE, DIGIT_INDEX);
        $display("Predicted  : %0d", predicted_digit);
        if (predicted_digit == DIGIT_INDEX[3:0])
            $display("RESULT     : SUCCESS!");
        else
            $display("RESULT     : FAIL");
        $display("Latency    : %0d cycles", latency);
        $display("");

        $finish;
    end

endmodule

