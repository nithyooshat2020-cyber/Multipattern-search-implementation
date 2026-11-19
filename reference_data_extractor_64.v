module reference_data_extractor_64(
    candidate_x,
    candidate_valid,

    reference_dout1,
    reference_dout2,
    reference_dout3,
    reference_dout4,
    reference_dout5,
    reference_dout6,
    reference_dout7,
    reference_dout8,

    reference_pixels1,
    reference_pixels2,
    reference_pixels3,
    reference_pixels4,
    reference_pixels5,
    reference_pixels6,
    reference_pixels7,
    reference_pixels8,

    extractor_valid
);


/* =========================================================
   INPUTS
   ========================================================= */

input [6:0] candidate_x;
input candidate_valid;

input [127:0] reference_dout1;
input [127:0] reference_dout2;
input [127:0] reference_dout3;
input [127:0] reference_dout4;
input [127:0] reference_dout5;
input [127:0] reference_dout6;
input [127:0] reference_dout7;
input [127:0] reference_dout8;


/* =========================================================
   OUTPUTS

   Each output contains 8 pixels.

   8 outputs × 64 bits
   = 64 pixels × 8 bits
   ========================================================= */

output reg [63:0] reference_pixels1;
output reg [63:0] reference_pixels2;
output reg [63:0] reference_pixels3;
output reg [63:0] reference_pixels4;
output reg [63:0] reference_pixels5;
output reg [63:0] reference_pixels6;
output reg [63:0] reference_pixels7;
output reg [63:0] reference_pixels8;

output reg extractor_valid;


/* =========================================================
   COMBINE THE 8 BRAM OUTPUTS

   Each BRAM contains:

   128 bits = 16 pixels

   Therefore:

   8 BRAMs × 16 pixels
   = 128 pixels
   ========================================================= */

wire [1023:0] reference_line;

assign reference_line = {
    reference_dout1,
    reference_dout2,
    reference_dout3,
    reference_dout4,
    reference_dout5,
    reference_dout6,
    reference_dout7,
    reference_dout8
};


/* =========================================================
   START BIT

   candidate_x is a PIXEL address.

   One pixel = 8 bits.

   Therefore:

   start_bit = candidate_x × 8

   We use shift instead of multiplication.

   candidate_x << 3
   ========================================================= */

wire [9:0] start_bit;

assign start_bit = {3'b000,candidate_x} << 3;


/* =========================================================
   512-BIT WINDOW

   64 pixels × 8 bits
   = 512 bits

   The variable part-select extracts:

   start_bit + 511
   down to
   start_bit
   ========================================================= */

wire [511:0] selected_reference;

assign selected_reference =
        reference_line[start_bit + 10'd511 -: 512];


/* =========================================================
   OUTPUT EXTRACTION

   512 bits
   =
   8 × 64-bit outputs

   Each 64-bit output = 8 pixels
   ========================================================= */

always @(*) begin

    reference_pixels1 = 64'd0;
    reference_pixels2 = 64'd0;
    reference_pixels3 = 64'd0;
    reference_pixels4 = 64'd0;
    reference_pixels5 = 64'd0;
    reference_pixels6 = 64'd0;
    reference_pixels7 = 64'd0;
    reference_pixels8 = 64'd0;

    extractor_valid = 1'b0;


    if (candidate_valid) begin

        /*
         * Valid 64-pixel extraction is possible when:
         *
         * candidate_x + 63 <= 127
         *
         * Therefore:
         *
         * candidate_x <= 64
         */

        if (candidate_x <= 7'd64) begin

            reference_pixels1 = selected_reference[511:448];

            reference_pixels2 = selected_reference[447:384];

            reference_pixels3 = selected_reference[383:320];

            reference_pixels4 = selected_reference[319:256];

            reference_pixels5 = selected_reference[255:192];

            reference_pixels6 = selected_reference[191:128];

            reference_pixels7 = selected_reference[127:64];

            reference_pixels8 = selected_reference[63:0];

            extractor_valid = 1'b1;

        end

        else begin

            reference_pixels1 = 64'd0;
            reference_pixels2 = 64'd0;
            reference_pixels3 = 64'd0;
            reference_pixels4 = 64'd0;
            reference_pixels5 = 64'd0;
            reference_pixels6 = 64'd0;
            reference_pixels7 = 64'd0;
            reference_pixels8 = 64'd0;

            extractor_valid = 1'b0;

        end

    end

end

endmodule