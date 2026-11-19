module tb_adaptive_motion_estimation_top;
reg clka;
reg rst;
reg start;
reg [1:0] threshold;
wire [6:0] MV_X;
wire [6:0] MV_Y;
wire MV_done;
/* Internal DUT signals exposed for waveform inspection. */
wire [19:0] min_sad_wave;
wire [19:0] candidate_sad_wave;
wire candidate_sad_valid_wave;
reg [15:0] timeout_count;

/* Hierarchical references: these are simulation-only waveform taps. */
assign min_sad_wave = dut.iteration_best_sad;
assign candidate_sad_wave = dut.candidate_sad;
assign candidate_sad_valid_wave = dut.candidate_sad_valid;

adaptive_motion_estimation_top dut(
    .clka(clka),
    .rst(rst),
    .start(start),
    .threshold(threshold),
    .MV_X(MV_X),
    .MV_Y(MV_Y),
    .MV_done(MV_done)
);

initial begin
    clka = 1'b0;
    forever #5 clka = ~clka;
end

/* All-zero current/reference memories should produce a zero displacement. */
task run_threshold_case;
input [1:0] requested_threshold;
begin
    @(negedge clka);
    threshold = requested_threshold;
    start = 1'b1;
    @(negedge clka);
    start = 1'b0;
    timeout_count = 16'd0;
    while ((MV_done !== 1'b1) && (timeout_count < 16'd12000)) begin
        @(posedge clka);
        timeout_count = timeout_count + 16'd1;
    end
    if (MV_done !== 1'b1) begin
        $display("FAIL: timeout for threshold %b after %0d cycles", requested_threshold, timeout_count);
        $finish;
    end
    else if ((MV_X !== 7'd0) || (MV_Y !== 7'd0)) begin
        $display("FAIL: threshold %b expected zero MV for zero SAD memories; got MV_X=%b MV_Y=%b", requested_threshold, MV_X, MV_Y);
        $finish;
    end
    else begin
        $display("PASS: threshold=%b MV_X=%b MV_Y=%b MV_done=%b cycles=%0d", requested_threshold, MV_X, MV_Y, MV_done, timeout_count);
    end
    repeat (3) @(negedge clka);
end
endtask

initial begin
    rst = 1'b1;
    start = 1'b0;
    threshold = 2'b00;
    timeout_count = 16'd0;
    repeat (5) @(negedge clka);
    rst = 1'b0;
    repeat (2) @(negedge clka);

    run_threshold_case(2'b00);
    run_threshold_case(2'b01);
    run_threshold_case(2'b10);
    run_threshold_case(2'b11);

    $display("All threshold smoke tests completed.");
    $finish;
end

/* Console trace whenever the best SAD or a candidate SAD changes. */
always @(min_sad_wave or candidate_sad_wave or candidate_sad_valid_wave) begin
    if (candidate_sad_valid_wave === 1'b1)
        $display("%0t ns: candidate SAD valid; candidate_sad=%0d (0x%05h), best_min_sad=%0d (0x%05h)",
                 $time, candidate_sad_wave, candidate_sad_wave,
                 min_sad_wave, min_sad_wave);
    else if ((^min_sad_wave) !== 1'bx)
        $display("%0t ns: best_min_sad=%0d (0x%05h)",
                 $time, min_sad_wave, min_sad_wave);
end

initial begin
    #2000000;
    $display("FAIL: global simulation watchdog expired.");
    $finish;
end
endmodule