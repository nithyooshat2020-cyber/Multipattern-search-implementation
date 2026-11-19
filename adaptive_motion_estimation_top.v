module adaptive_motion_estimation_top(
    clka, rst, start, threshold, MV_X, MV_Y, MV_done
);
input clka;
input rst;
input start;
input [1:0] threshold;
output reg [6:0] MV_X;
output reg [6:0] MV_Y;
output reg MV_done;

reg [2:0] state;
reg [1:0] threshold_latched;
reg [2:0] pattern_select;
reg [3:0] candidate_index;
reg [5:0] row_count;
reg [3:0] drain_count;
reg scan_active;
reg [6:0] center_x;
reg [6:0] center_y;
reg [19:0] iteration_best_sad;
reg [6:0] iteration_best_x;
reg [6:0] iteration_best_y;
reg [6:0] candidate_x_d1, candidate_x_d2;
reg [6:0] candidate_y_d1, candidate_y_d2;
reg candidate_valid_d1, candidate_valid_d2;

wire [6:0] candidate_x;
wire [6:0] candidate_y;
wire agu_valid;
wire [6:0] reference_address;
wire [5:0] current_address1,current_address2,current_address3,current_address4;
wire [5:0] current_address5,current_address6,current_address7,current_address8;
wire [63:0] current_dout1,current_dout2,current_dout3,current_dout4;
wire [63:0] current_dout5,current_dout6,current_dout7,current_dout8;
wire [127:0] reference_dout1,reference_dout2,reference_dout3,reference_dout4;
wire [127:0] reference_dout5,reference_dout6,reference_dout7,reference_dout8;
wire [63:0] reference_pixels1,reference_pixels2,reference_pixels3,reference_pixels4;
wire [63:0] reference_pixels5,reference_pixels6,reference_pixels7,reference_pixels8;
wire extractor_valid;
wire [13:0] sad_out;
wire sad_valid;
wire [19:0] candidate_sad;
wire candidate_sad_valid;
wire [2:0] unused_candidate_index_out;
wire [19:0] unused_candidate_sad;
wire unused_candidate_sad_valid;
wire [2:0] unused_candidate_index;
wire [2:0] current_pattern_last;
wire candidate_valid;

assign candidate_valid = agu_valid & scan_active;
assign current_pattern_last = (pattern_select == 3'd0) ? 3'd4 :
                              (pattern_select == 3'd1) ? 3'd6 :
                              (pattern_select == 3'd4) ? 3'd4 : 3'd8;

adaptive_agu_shared u_agu(
    .center_x(center_x), .center_y(center_y), .pattern_select(pattern_select),
    .candidate_index(candidate_index), .row_count(row_count),
    .candidate_x(candidate_x), .candidate_y(candidate_y),
    .candidate_valid(agu_valid), .reference_address(reference_address)
);

current_block u_shared_memories(
    .clka(clka), .rst(rst), .ena(scan_active), .wea(1'b0),
    .addra1(current_address1), .addra2(current_address2), .addra3(current_address3), .addra4(current_address4),
    .addra5(current_address5), .addra6(current_address6), .addra7(current_address7), .addra8(current_address8),
    .addraC1(reference_address), .addraC2(reference_address), .addraC3(reference_address), .addraC4(reference_address),
    .addraC5(reference_address), .addraC6(reference_address), .addraC7(reference_address), .addraC8(reference_address),
    .dina1(64'd0), .dina2(64'd0), .dina3(64'd0), .dina4(64'd0), .dina5(64'd0), .dina6(64'd0), .dina7(64'd0), .dina8(64'd0),
    .dinaC1(128'd0), .dinaC2(128'd0), .dinaC3(128'd0), .dinaC4(128'd0), .dinaC5(128'd0), .dinaC6(128'd0), .dinaC7(128'd0), .dinaC8(128'd0),
    .douta1(current_dout1), .douta2(current_dout2), .douta3(current_dout3), .douta4(current_dout4),
    .douta5(current_dout5), .douta6(current_dout6), .douta7(current_dout7), .douta8(current_dout8),
    .doutaC1(reference_dout1), .doutaC2(reference_dout2), .doutaC3(reference_dout3), .doutaC4(reference_dout4),
    .doutaC5(reference_dout5), .doutaC6(reference_dout6), .doutaC7(reference_dout7), .doutaC8(reference_dout8),
    .diff_valu0(), .diff_valu1(), .diff_valu2(), .diff_valu3(), .diff_valu4()
);

always @(posedge clka) begin
    if (rst) begin
        candidate_x_d1 <= 7'd32; candidate_x_d2 <= 7'd32;
        candidate_y_d1 <= 7'd32; candidate_y_d2 <= 7'd32;
        candidate_valid_d1 <= 1'b0; candidate_valid_d2 <= 1'b0;
    end else begin
        candidate_x_d1 <= candidate_x; candidate_x_d2 <= candidate_x_d1;
        candidate_y_d1 <= candidate_y; candidate_y_d2 <= candidate_y_d1;
        candidate_valid_d1 <= candidate_valid; candidate_valid_d2 <= candidate_valid_d1;
    end
end

reference_data_extractor_64 u_shared_extractor(
    .candidate_x(candidate_x_d2), .candidate_valid(candidate_valid_d2),
    .reference_dout1(reference_dout1), .reference_dout2(reference_dout2),
    .reference_dout3(reference_dout3), .reference_dout4(reference_dout4),
    .reference_dout5(reference_dout5), .reference_dout6(reference_dout6),
    .reference_dout7(reference_dout7), .reference_dout8(reference_dout8),
    .reference_pixels1(reference_pixels1), .reference_pixels2(reference_pixels2),
    .reference_pixels3(reference_pixels3), .reference_pixels4(reference_pixels4),
    .reference_pixels5(reference_pixels5), .reference_pixels6(reference_pixels6),
    .reference_pixels7(reference_pixels7), .reference_pixels8(reference_pixels8),
    .extractor_valid(extractor_valid)
);

sad_adder_tree_64 u_shared_sad_tree(
    .clka(clka), .rst(rst), .valid_in(extractor_valid),
    .current_pixels1(current_dout1), .current_pixels2(current_dout2), .current_pixels3(current_dout3), .current_pixels4(current_dout4),
    .current_pixels5(current_dout5), .current_pixels6(current_dout6), .current_pixels7(current_dout7), .current_pixels8(current_dout8),
    .reference_pixels1(reference_pixels1), .reference_pixels2(reference_pixels2), .reference_pixels3(reference_pixels3), .reference_pixels4(reference_pixels4),
    .reference_pixels5(reference_pixels5), .reference_pixels6(reference_pixels6), .reference_pixels7(reference_pixels7), .reference_pixels8(reference_pixels8),
    .sad_out(sad_out), .valid_out(sad_valid)
);

sad_candidate_accumulator_64 u_shared_accumulator(
    .clka(clka), .rst(rst), .sad_valid(sad_valid), .sad_in(sad_out),
    .candidate_index_in(candidate_index[2:0]), .candidate_sad(candidate_sad),
    .candidate_sad_valid(candidate_sad_valid), .candidate_index_out(unused_candidate_index_out)
);

/* States: 0=IDLE, 1=SCAN, 2=DRAIN, 3=ADVANCE, 4=DECIDE, 5=DONE. */
always @(posedge clka) begin
    if (rst) begin
        state <= 3'd0;
        threshold_latched <= 2'b00;
        pattern_select <= 3'd0;
        candidate_index <= 4'd0;
        row_count <= 6'd0;
        drain_count <= 4'd0;
        scan_active <= 1'b0;
        center_x <= 7'd32;
        center_y <= 7'd32;
        iteration_best_sad <= 20'hFFFFF;
        iteration_best_x <= 7'd32;
        iteration_best_y <= 7'd32;
        MV_X <= 7'd0;
        MV_Y <= 7'd0;
        MV_done <= 1'b0;
    end else begin
        MV_done <= 1'b0;

        /* The global comparator includes every candidate from every enabled pattern. */
        if (candidate_sad_valid && (candidate_sad < iteration_best_sad)) begin
            iteration_best_sad <= candidate_sad;
            iteration_best_x <= candidate_x_d2;
            iteration_best_y <= candidate_y_d2;
        end

        case (state)
            3'd0: begin
                scan_active <= 1'b0;
                if (start) begin
                    threshold_latched <= threshold;
                    center_x <= 7'd32;
                    center_y <= 7'd32;
                    pattern_select <= 3'd0;
                    candidate_index <= 4'd0;
                    row_count <= 6'd0;
                    drain_count <= 4'd0;
                    iteration_best_sad <= 20'hFFFFF;
                    iteration_best_x <= 7'd32;
                    iteration_best_y <= 7'd32;
                                scan_active <= 1'b1;
                    state <= 3'd1;
                end
            end
            3'd1: begin
                scan_active <= 1'b1;
                if (row_count == 6'd63) begin
                    row_count <= 6'd0;
                    scan_active <= 1'b0;
                    drain_count <= 4'd0;
                    state <= 3'd2;
                end else row_count <= row_count + 6'd1;
            end
            3'd2: begin
                scan_active <= 1'b0;
                if (drain_count == 4'd11) begin
                    drain_count <= 4'd0;
                    state <= 3'd3;
                end else drain_count <= drain_count + 4'd1;
            end
            3'd3: begin
                scan_active <= 1'b0;
                if (candidate_index < {1'b0,current_pattern_last}) begin
                    candidate_index <= candidate_index + 4'd1;
                    row_count <= 6'd0;
                    scan_active <= 1'b1;
                    state <= 3'd1;
                end else begin
                    candidate_index <= 4'd0;
                    if (pattern_select == 3'd0) begin
                        pattern_select <= 3'd1;
                        row_count <= 6'd0;
                        scan_active <= 1'b1;
                        state <= 3'd1;
                    end else if (pattern_select == 3'd1) begin
                        if (threshold_latched == 2'b00) state <= 3'd4;
                        else begin pattern_select <= 3'd2; row_count <= 6'd0; scan_active <= 1'b1; state <= 3'd1; end
                    end else if (pattern_select == 3'd2) begin
                        if (threshold_latched == 2'b01) state <= 3'd4;
                        else begin pattern_select <= 3'd3; row_count <= 6'd0; scan_active <= 1'b1; state <= 3'd1; end
                    end else if (pattern_select == 3'd3) begin
                        if (threshold_latched != 2'b11) state <= 3'd4;
                        else begin pattern_select <= 3'd4; row_count <= 6'd0; scan_active <= 1'b1; state <= 3'd1; end
                    end else state <= 3'd4;
                end
            end
            3'd4: begin
                scan_active <= 1'b0;
                if ((iteration_best_x == center_x) && (iteration_best_y == center_y)) begin
                    MV_X <= iteration_best_x - 7'd32;
                    MV_Y <= iteration_best_y - 7'd32;
                    MV_done <= 1'b1;
                    state <= 3'd5;
                end else begin
                    center_x <= iteration_best_x;
                    center_y <= iteration_best_y;
                    iteration_best_sad <= 20'hFFFFF;
                    iteration_best_x <= iteration_best_x;
                    iteration_best_y <= iteration_best_y;
                    pattern_select <= 3'd0;
                    candidate_index <= 4'd0;
                    row_count <= 6'd0;
                    scan_active <= 1'b1;
                    state <= 3'd1;
                end
            end
            3'd5: begin
                scan_active <= 1'b0;
                if (!start) state <= 3'd0;
            end
            default: begin
                state <= 3'd0;
                scan_active <= 1'b0;
            end
        endcase
    end
end
endmodule