module sad_candidate_accumulator_64(
    clka,
    rst,

    sad_valid,
    sad_in,

    candidate_index_in,

    candidate_sad,
    candidate_sad_valid,
    candidate_index_out
);

input clka;
input rst;

input sad_valid;
input [13:0] sad_in;

input [2:0] candidate_index_in;

output reg [19:0] candidate_sad;
output reg candidate_sad_valid;
output reg [2:0] candidate_index_out;


/* ============================================================
   ROW COUNTER
   Counts 0 to 63
   ============================================================ */

reg [5:0] row_count;


/* ============================================================
   SAD ACCUMULATOR
   ============================================================ */

reg [19:0] sad_accum;


/* ============================================================
   ACCUMULATOR
   ============================================================ */

always @(posedge clka) begin

    if (rst) begin

        row_count <= 6'd0;

        sad_accum <= 20'd0;

        candidate_sad <= 20'd0;

        candidate_sad_valid <= 1'b0;

        candidate_index_out <= 3'd0;

    end

    else begin

        candidate_sad_valid <= 1'b0;


        if (sad_valid) begin
            if (row_count == 6'd63) begin
                candidate_sad <= sad_accum + sad_in;

                candidate_index_out <= candidate_index_in;

                candidate_sad_valid <= 1'b1;

               
                row_count <= 6'd0;

                sad_accum <= 20'd0;

            end

            else begin
                sad_accum <= sad_accum + sad_in;

                row_count <= row_count + 6'd1;

            end

        end

    end

end

endmodule