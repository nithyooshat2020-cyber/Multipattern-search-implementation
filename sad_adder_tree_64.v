module sad_adder_tree_64(
    clka,
    rst,
    valid_in,

    current_pixels1,
    current_pixels2,
    current_pixels3,
    current_pixels4,
    current_pixels5,
    current_pixels6,
    current_pixels7,
    current_pixels8,

    reference_pixels1,
    reference_pixels2,
    reference_pixels3,
    reference_pixels4,
    reference_pixels5,
    reference_pixels6,
    reference_pixels7,
    reference_pixels8,

    sad_out,
    valid_out
);

input clka;
input rst;
input valid_in;

input [63:0] current_pixels1;
input [63:0] current_pixels2;
input [63:0] current_pixels3;
input [63:0] current_pixels4;
input [63:0] current_pixels5;
input [63:0] current_pixels6;
input [63:0] current_pixels7;
input [63:0] current_pixels8;

input [63:0] reference_pixels1;
input [63:0] reference_pixels2;
input [63:0] reference_pixels3;
input [63:0] reference_pixels4;
input [63:0] reference_pixels5;
input [63:0] reference_pixels6;
input [63:0] reference_pixels7;
input [63:0] reference_pixels8;

output reg [13:0] sad_out;
output reg valid_out;


/* ============================================================
   CURRENT PIXEL EXTRACTION
   ============================================================ */

wire [7:0] c0;
wire [7:0] c1;
wire [7:0] c2;
wire [7:0] c3;
wire [7:0] c4;
wire [7:0] c5;
wire [7:0] c6;
wire [7:0] c7;

wire [7:0] c8;
wire [7:0] c9;
wire [7:0] c10;
wire [7:0] c11;
wire [7:0] c12;
wire [7:0] c13;
wire [7:0] c14;
wire [7:0] c15;

wire [7:0] c16;
wire [7:0] c17;
wire [7:0] c18;
wire [7:0] c19;
wire [7:0] c20;
wire [7:0] c21;
wire [7:0] c22;
wire [7:0] c23;

wire [7:0] c24;
wire [7:0] c25;
wire [7:0] c26;
wire [7:0] c27;
wire [7:0] c28;
wire [7:0] c29;
wire [7:0] c30;
wire [7:0] c31;

wire [7:0] c32;
wire [7:0] c33;
wire [7:0] c34;
wire [7:0] c35;
wire [7:0] c36;
wire [7:0] c37;
wire [7:0] c38;
wire [7:0] c39;

wire [7:0] c40;
wire [7:0] c41;
wire [7:0] c42;
wire [7:0] c43;
wire [7:0] c44;
wire [7:0] c45;
wire [7:0] c46;
wire [7:0] c47;

wire [7:0] c48;
wire [7:0] c49;
wire [7:0] c50;
wire [7:0] c51;
wire [7:0] c52;
wire [7:0] c53;
wire [7:0] c54;
wire [7:0] c55;

wire [7:0] c56;
wire [7:0] c57;
wire [7:0] c58;
wire [7:0] c59;
wire [7:0] c60;
wire [7:0] c61;
wire [7:0] c62;
wire [7:0] c63;


/* Current pixels 0-7 */

assign c0 = current_pixels1[63:56];
assign c1 = current_pixels1[55:48];
assign c2 = current_pixels1[47:40];
assign c3 = current_pixels1[39:32];
assign c4 = current_pixels1[31:24];
assign c5 = current_pixels1[23:16];
assign c6 = current_pixels1[15:8];
assign c7 = current_pixels1[7:0];


/* Current pixels 8-15 */

assign c8  = current_pixels2[63:56];
assign c9  = current_pixels2[55:48];
assign c10 = current_pixels2[47:40];
assign c11 = current_pixels2[39:32];
assign c12 = current_pixels2[31:24];
assign c13 = current_pixels2[23:16];
assign c14 = current_pixels2[15:8];
assign c15 = current_pixels2[7:0];


/* Current pixels 16-23 */

assign c16 = current_pixels3[63:56];
assign c17 = current_pixels3[55:48];
assign c18 = current_pixels3[47:40];
assign c19 = current_pixels3[39:32];
assign c20 = current_pixels3[31:24];
assign c21 = current_pixels3[23:16];
assign c22 = current_pixels3[15:8];
assign c23 = current_pixels3[7:0];


/* Current pixels 24-31 */

assign c24 = current_pixels4[63:56];
assign c25 = current_pixels4[55:48];
assign c26 = current_pixels4[47:40];
assign c27 = current_pixels4[39:32];
assign c28 = current_pixels4[31:24];
assign c29 = current_pixels4[23:16];
assign c30 = current_pixels4[15:8];
assign c31 = current_pixels4[7:0];


/* Current pixels 32-39 */

assign c32 = current_pixels5[63:56];
assign c33 = current_pixels5[55:48];
assign c34 = current_pixels5[47:40];
assign c35 = current_pixels5[39:32];
assign c36 = current_pixels5[31:24];
assign c37 = current_pixels5[23:16];
assign c38 = current_pixels5[15:8];
assign c39 = current_pixels5[7:0];


/* Current pixels 40-47 */

assign c40 = current_pixels6[63:56];
assign c41 = current_pixels6[55:48];
assign c42 = current_pixels6[47:40];
assign c43 = current_pixels6[39:32];
assign c44 = current_pixels6[31:24];
assign c45 = current_pixels6[23:16];
assign c46 = current_pixels6[15:8];
assign c47 = current_pixels6[7:0];


/* Current pixels 48-55 */

assign c48 = current_pixels7[63:56];
assign c49 = current_pixels7[55:48];
assign c50 = current_pixels7[47:40];
assign c51 = current_pixels7[39:32];
assign c52 = current_pixels7[31:24];
assign c53 = current_pixels7[23:16];
assign c54 = current_pixels7[15:8];
assign c55 = current_pixels7[7:0];


/* Current pixels 56-63 */

assign c56 = current_pixels8[63:56];
assign c57 = current_pixels8[55:48];
assign c58 = current_pixels8[47:40];
assign c59 = current_pixels8[39:32];
assign c60 = current_pixels8[31:24];
assign c61 = current_pixels8[23:16];
assign c62 = current_pixels8[15:8];
assign c63 = current_pixels8[7:0];


/* ============================================================
   REFERENCE PIXEL EXTRACTION
   ============================================================ */

wire [7:0] r0;
wire [7:0] r1;
wire [7:0] r2;
wire [7:0] r3;
wire [7:0] r4;
wire [7:0] r5;
wire [7:0] r6;
wire [7:0] r7;

wire [7:0] r8;
wire [7:0] r9;
wire [7:0] r10;
wire [7:0] r11;
wire [7:0] r12;
wire [7:0] r13;
wire [7:0] r14;
wire [7:0] r15;

wire [7:0] r16;
wire [7:0] r17;
wire [7:0] r18;
wire [7:0] r19;
wire [7:0] r20;
wire [7:0] r21;
wire [7:0] r22;
wire [7:0] r23;

wire [7:0] r24;
wire [7:0] r25;
wire [7:0] r26;
wire [7:0] r27;
wire [7:0] r28;
wire [7:0] r29;
wire [7:0] r30;
wire [7:0] r31;

wire [7:0] r32;
wire [7:0] r33;
wire [7:0] r34;
wire [7:0] r35;
wire [7:0] r36;
wire [7:0] r37;
wire [7:0] r38;
wire [7:0] r39;

wire [7:0] r40;
wire [7:0] r41;
wire [7:0] r42;
wire [7:0] r43;
wire [7:0] r44;
wire [7:0] r45;
wire [7:0] r46;
wire [7:0] r47;

wire [7:0] r48;
wire [7:0] r49;
wire [7:0] r50;
wire [7:0] r51;
wire [7:0] r52;
wire [7:0] r53;
wire [7:0] r54;
wire [7:0] r55;

wire [7:0] r56;
wire [7:0] r57;
wire [7:0] r58;
wire [7:0] r59;
wire [7:0] r60;
wire [7:0] r61;
wire [7:0] r62;
wire [7:0] r63;


/* Reference pixels 0-7 */

assign r0 = reference_pixels1[63:56];
assign r1 = reference_pixels1[55:48];
assign r2 = reference_pixels1[47:40];
assign r3 = reference_pixels1[39:32];
assign r4 = reference_pixels1[31:24];
assign r5 = reference_pixels1[23:16];
assign r6 = reference_pixels1[15:8];
assign r7 = reference_pixels1[7:0];


/* Reference pixels 8-15 */

assign r8  = reference_pixels2[63:56];
assign r9  = reference_pixels2[55:48];
assign r10 = reference_pixels2[47:40];
assign r11 = reference_pixels2[39:32];
assign r12 = reference_pixels2[31:24];
assign r13 = reference_pixels2[23:16];
assign r14 = reference_pixels2[15:8];
assign r15 = reference_pixels2[7:0];


/* Reference pixels 16-23 */

assign r16 = reference_pixels3[63:56];
assign r17 = reference_pixels3[55:48];
assign r18 = reference_pixels3[47:40];
assign r19 = reference_pixels3[39:32];
assign r20 = reference_pixels3[31:24];
assign r21 = reference_pixels3[23:16];
assign r22 = reference_pixels3[15:8];
assign r23 = reference_pixels3[7:0];


/* Reference pixels 24-31 */

assign r24 = reference_pixels4[63:56];
assign r25 = reference_pixels4[55:48];
assign r26 = reference_pixels4[47:40];
assign r27 = reference_pixels4[39:32];
assign r28 = reference_pixels4[31:24];
assign r29 = reference_pixels4[23:16];
assign r30 = reference_pixels4[15:8];
assign r31 = reference_pixels4[7:0];


/* Reference pixels 32-39 */

assign r32 = reference_pixels5[63:56];
assign r33 = reference_pixels5[55:48];
assign r34 = reference_pixels5[47:40];
assign r35 = reference_pixels5[39:32];
assign r36 = reference_pixels5[31:24];
assign r37 = reference_pixels5[23:16];
assign r38 = reference_pixels5[15:8];
assign r39 = reference_pixels5[7:0];


/* Reference pixels 40-47 */

assign r40 = reference_pixels6[63:56];
assign r41 = reference_pixels6[55:48];
assign r42 = reference_pixels6[47:40];
assign r43 = reference_pixels6[39:32];
assign r44 = reference_pixels6[31:24];
assign r45 = reference_pixels6[23:16];
assign r46 = reference_pixels6[15:8];
assign r47 = reference_pixels6[7:0];


/* Reference pixels 48-55 */

assign r48 = reference_pixels7[63:56];
assign r49 = reference_pixels7[55:48];
assign r50 = reference_pixels7[47:40];
assign r51 = reference_pixels7[39:32];
assign r52 = reference_pixels7[31:24];
assign r53 = reference_pixels7[23:16];
assign r54 = reference_pixels7[15:8];
assign r55 = reference_pixels7[7:0];


/* Reference pixels 56-63 */

assign r56 = reference_pixels8[63:56];
assign r57 = reference_pixels8[55:48];
assign r58 = reference_pixels8[47:40];
assign r59 = reference_pixels8[39:32];
assign r60 = reference_pixels8[31:24];
assign r61 = reference_pixels8[23:16];
assign r62 = reference_pixels8[15:8];
assign r63 = reference_pixels8[7:0];


/* ============================================================
   ABSOLUTE DIFFERENCES
   ============================================================ */

wire [8:0] d0;
wire [8:0] d1;
wire [8:0] d2;
wire [8:0] d3;
wire [8:0] d4;
wire [8:0] d5;
wire [8:0] d6;
wire [8:0] d7;

wire [8:0] d8;
wire [8:0] d9;
wire [8:0] d10;
wire [8:0] d11;
wire [8:0] d12;
wire [8:0] d13;
wire [8:0] d14;
wire [8:0] d15;

wire [8:0] d16;
wire [8:0] d17;
wire [8:0] d18;
wire [8:0] d19;
wire [8:0] d20;
wire [8:0] d21;
wire [8:0] d22;
wire [8:0] d23;

wire [8:0] d24;
wire [8:0] d25;
wire [8:0] d26;
wire [8:0] d27;
wire [8:0] d28;
wire [8:0] d29;
wire [8:0] d30;
wire [8:0] d31;

wire [8:0] d32;
wire [8:0] d33;
wire [8:0] d34;
wire [8:0] d35;
wire [8:0] d36;
wire [8:0] d37;
wire [8:0] d38;
wire [8:0] d39;

wire [8:0] d40;
wire [8:0] d41;
wire [8:0] d42;
wire [8:0] d43;
wire [8:0] d44;
wire [8:0] d45;
wire [8:0] d46;
wire [8:0] d47;

wire [8:0] d48;
wire [8:0] d49;
wire [8:0] d50;
wire [8:0] d51;
wire [8:0] d52;
wire [8:0] d53;
wire [8:0] d54;
wire [8:0] d55;

wire [8:0] d56;
wire [8:0] d57;
wire [8:0] d58;
wire [8:0] d59;
wire [8:0] d60;
wire [8:0] d61;
wire [8:0] d62;
wire [8:0] d63;


assign d0  = (c0  >= r0)  ? (c0  - r0)  : (r0  - c0);
assign d1  = (c1  >= r1)  ? (c1  - r1)  : (r1  - c1);
assign d2  = (c2  >= r2)  ? (c2  - r2)  : (r2  - c2);
assign d3  = (c3  >= r3)  ? (c3  - r3)  : (r3  - c3);
assign d4  = (c4  >= r4)  ? (c4  - r4)  : (r4  - c4);
assign d5  = (c5  >= r5)  ? (c5  - r5)  : (r5  - c5);
assign d6  = (c6  >= r6)  ? (c6  - r6)  : (r6  - c6);
assign d7  = (c7  >= r7)  ? (c7  - r7)  : (r7  - c7);

assign d8  = (c8  >= r8)  ? (c8  - r8)  : (r8  - c8);
assign d9  = (c9  >= r9)  ? (c9  - r9)  : (r9  - c9);
assign d10 = (c10 >= r10) ? (c10 - r10) : (r10 - c10);
assign d11 = (c11 >= r11) ? (c11 - r11) : (r11 - c11);
assign d12 = (c12 >= r12) ? (c12 - r12) : (r12 - c12);
assign d13 = (c13 >= r13) ? (c13 - r13) : (r13 - c13);
assign d14 = (c14 >= r14) ? (c14 - r14) : (r14 - c14);
assign d15 = (c15 >= r15) ? (c15 - r15) : (r15 - c15);

assign d16 = (c16 >= r16) ? (c16 - r16) : (r16 - c16);
assign d17 = (c17 >= r17) ? (c17 - r17) : (r17 - c17);
assign d18 = (c18 >= r18) ? (c18 - r18) : (r18 - c18);
assign d19 = (c19 >= r19) ? (c19 - r19) : (r19 - c19);
assign d20 = (c20 >= r20) ? (c20 - r20) : (r20 - c20);
assign d21 = (c21 >= r21) ? (c21 - r21) : (r21 - c21);
assign d22 = (c22 >= r22) ? (c22 - r22) : (r22 - c22);
assign d23 = (c23 >= r23) ? (c23 - r23) : (r23 - c23);

assign d24 = (c24 >= r24) ? (c24 - r24) : (r24 - c24);
assign d25 = (c25 >= r25) ? (c25 - r25) : (r25 - c25);
assign d26 = (c26 >= r26) ? (c26 - r26) : (r26 - c26);
assign d27 = (c27 >= r27) ? (c27 - r27) : (r27 - c27);
assign d28 = (c28 >= r28) ? (c28 - r28) : (r28 - c28);
assign d29 = (c29 >= r29) ? (c29 - r29) : (r29 - c29);
assign d30 = (c30 >= r30) ? (c30 - r30) : (r30 - c30);
assign d31 = (c31 >= r31) ? (c31 - r31) : (r31 - c31);

assign d32 = (c32 >= r32) ? (c32 - r32) : (r32 - c32);
assign d33 = (c33 >= r33) ? (c33 - r33) : (r33 - c33);
assign d34 = (c34 >= r34) ? (c34 - r34) : (r34 - c34);
assign d35 = (c35 >= r35) ? (c35 - r35) : (r35 - c35);
assign d36 = (c36 >= r36) ? (c36 - r36) : (r36 - c36);
assign d37 = (c37 >= r37) ? (c37 - r37) : (r37 - c37);
assign d38 = (c38 >= r38) ? (c38 - r38) : (r38 - c38);
assign d39 = (c39 >= r39) ? (c39 - r39) : (r39 - c39);

assign d40 = (c40 >= r40) ? (c40 - r40) : (r40 - c40);
assign d41 = (c41 >= r41) ? (c41 - r41) : (r41 - c41);
assign d42 = (c42 >= r42) ? (c42 - r42) : (r42 - c42);
assign d43 = (c43 >= r43) ? (c43 - r43) : (r43 - c43);
assign d44 = (c44 >= r44) ? (c44 - r44) : (r44 - c44);
assign d45 = (c45 >= r45) ? (c45 - r45) : (r45 - c45);
assign d46 = (c46 >= r46) ? (c46 - r46) : (r46 - c46);
assign d47 = (c47 >= r47) ? (c47 - r47) : (r47 - c47);

assign d48 = (c48 >= r48) ? (c48 - r48) : (r48 - c48);
assign d49 = (c49 >= r49) ? (c49 - r49) : (r49 - c49);
assign d50 = (c50 >= r50) ? (c50 - r50) : (r50 - c50);
assign d51 = (c51 >= r51) ? (c51 - r51) : (r51 - c51);
assign d52 = (c52 >= r52) ? (c52 - r52) : (r52 - c52);
assign d53 = (c53 >= r53) ? (c53 - r53) : (r53 - c53);
assign d54 = (c54 >= r54) ? (c54 - r54) : (r54 - c54);
assign d55 = (c55 >= r55) ? (c55 - r55) : (r55 - c55);

assign d56 = (c56 >= r56) ? (c56 - r56) : (r56 - c56);
assign d57 = (c57 >= r57) ? (c57 - r57) : (r57 - c57);
assign d58 = (c58 >= r58) ? (c58 - r58) : (r58 - c58);
assign d59 = (c59 >= r59) ? (c59 - r59) : (r59 - c59);
assign d60 = (c60 >= r60) ? (c60 - r60) : (r60 - c60);
assign d61 = (c61 >= r61) ? (c61 - r61) : (r61 - c61);
assign d62 = (c62 >= r62) ? (c62 - r62) : (r62 - c62);
assign d63 = (c63 >= r63) ? (c63 - r63) : (r63 - c63);


/* ============================================================
   STAGE 1 : 64 -> 32
   ============================================================ */

reg [8:0] s1_0;
reg [8:0] s1_1;
reg [8:0] s1_2;
reg [8:0] s1_3;
reg [8:0] s1_4;
reg [8:0] s1_5;
reg [8:0] s1_6;
reg [8:0] s1_7;
reg [8:0] s1_8;
reg [8:0] s1_9;
reg [8:0] s1_10;
reg [8:0] s1_11;
reg [8:0] s1_12;
reg [8:0] s1_13;
reg [8:0] s1_14;
reg [8:0] s1_15;
reg [8:0] s1_16;
reg [8:0] s1_17;
reg [8:0] s1_18;
reg [8:0] s1_19;
reg [8:0] s1_20;
reg [8:0] s1_21;
reg [8:0] s1_22;
reg [8:0] s1_23;
reg [8:0] s1_24;
reg [8:0] s1_25;
reg [8:0] s1_26;
reg [8:0] s1_27;
reg [8:0] s1_28;
reg [8:0] s1_29;
reg [8:0] s1_30;
reg [8:0] s1_31;

reg valid_s1;

always @(posedge clka) begin
    if (rst) begin
        s1_0 <= 9'd0;
        s1_1 <= 9'd0;
        s1_2 <= 9'd0;
        s1_3 <= 9'd0;
        s1_4 <= 9'd0;
        s1_5 <= 9'd0;
        s1_6 <= 9'd0;
        s1_7 <= 9'd0;
        s1_8 <= 9'd0;
        s1_9 <= 9'd0;
        s1_10 <= 9'd0;
        s1_11 <= 9'd0;
        s1_12 <= 9'd0;
        s1_13 <= 9'd0;
        s1_14 <= 9'd0;
        s1_15 <= 9'd0;
        s1_16 <= 9'd0;
        s1_17 <= 9'd0;
        s1_18 <= 9'd0;
        s1_19 <= 9'd0;
        s1_20 <= 9'd0;
        s1_21 <= 9'd0;
        s1_22 <= 9'd0;
        s1_23 <= 9'd0;
        s1_24 <= 9'd0;
        s1_25 <= 9'd0;
        s1_26 <= 9'd0;
        s1_27 <= 9'd0;
        s1_28 <= 9'd0;
        s1_29 <= 9'd0;
        s1_30 <= 9'd0;
        s1_31 <= 9'd0;
        valid_s1 <= 1'b0;
    end
    else begin
        s1_0  <= d0  + d1;
        s1_1  <= d2  + d3;
        s1_2  <= d4  + d5;
        s1_3  <= d6  + d7;
        s1_4  <= d8  + d9;
        s1_5  <= d10 + d11;
        s1_6  <= d12 + d13;
        s1_7  <= d14 + d15;
        s1_8  <= d16 + d17;
        s1_9  <= d18 + d19;
        s1_10 <= d20 + d21;
        s1_11 <= d22 + d23;
        s1_12 <= d24 + d25;
        s1_13 <= d26 + d27;
        s1_14 <= d28 + d29;
        s1_15 <= d30 + d31;
        s1_16 <= d32 + d33;
        s1_17 <= d34 + d35;
        s1_18 <= d36 + d37;
        s1_19 <= d38 + d39;
        s1_20 <= d40 + d41;
        s1_21 <= d42 + d43;
        s1_22 <= d44 + d45;
        s1_23 <= d46 + d47;
        s1_24 <= d48 + d49;
        s1_25 <= d50 + d51;
        s1_26 <= d52 + d53;
        s1_27 <= d54 + d55;
        s1_28 <= d56 + d57;
        s1_29 <= d58 + d59;
        s1_30 <= d60 + d61;
        s1_31 <= d62 + d63;

        valid_s1 <= valid_in;
    end
end


/* ============================================================
   STAGE 2 : 32 -> 16
   ============================================================ */

reg [9:0] s2_0;
reg [9:0] s2_1;
reg [9:0] s2_2;
reg [9:0] s2_3;
reg [9:0] s2_4;
reg [9:0] s2_5;
reg [9:0] s2_6;
reg [9:0] s2_7;
reg [9:0] s2_8;
reg [9:0] s2_9;
reg [9:0] s2_10;
reg [9:0] s2_11;
reg [9:0] s2_12;
reg [9:0] s2_13;
reg [9:0] s2_14;
reg [9:0] s2_15;

reg valid_s2;

always @(posedge clka) begin
    if (rst) begin
        s2_0 <= 10'd0;
        s2_1 <= 10'd0;
        s2_2 <= 10'd0;
        s2_3 <= 10'd0;
        s2_4 <= 10'd0;
        s2_5 <= 10'd0;
        s2_6 <= 10'd0;
        s2_7 <= 10'd0;
        s2_8 <= 10'd0;
        s2_9 <= 10'd0;
        s2_10 <= 10'd0;
        s2_11 <= 10'd0;
        s2_12 <= 10'd0;
        s2_13 <= 10'd0;
        s2_14 <= 10'd0;
        s2_15 <= 10'd0;
        valid_s2 <= 1'b0;
    end
    else begin
        s2_0  <= s1_0  + s1_1;
        s2_1  <= s1_2  + s1_3;
        s2_2  <= s1_4  + s1_5;
        s2_3  <= s1_6  + s1_7;
        s2_4  <= s1_8  + s1_9;
        s2_5  <= s1_10 + s1_11;
        s2_6  <= s1_12 + s1_13;
        s2_7  <= s1_14 + s1_15;
        s2_8  <= s1_16 + s1_17;
        s2_9  <= s1_18 + s1_19;
        s2_10 <= s1_20 + s1_21;
        s2_11 <= s1_22 + s1_23;
        s2_12 <= s1_24 + s1_25;
        s2_13 <= s1_26 + s1_27;
        s2_14 <= s1_28 + s1_29;
        s2_15 <= s1_30 + s1_31;

        valid_s2 <= valid_s1;
    end
end


/* ============================================================
   STAGE 3 : 16 -> 8
   ============================================================ */

reg [10:0] s3_0;
reg [10:0] s3_1;
reg [10:0] s3_2;
reg [10:0] s3_3;
reg [10:0] s3_4;
reg [10:0] s3_5;
reg [10:0] s3_6;
reg [10:0] s3_7;

reg valid_s3;

always @(posedge clka) begin
    if (rst) begin
        s3_0 <= 11'd0;
        s3_1 <= 11'd0;
        s3_2 <= 11'd0;
        s3_3 <= 11'd0;
        s3_4 <= 11'd0;
        s3_5 <= 11'd0;
        s3_6 <= 11'd0;
        s3_7 <= 11'd0;
        valid_s3 <= 1'b0;
    end
    else begin
        s3_0 <= s2_0 + s2_1;
        s3_1 <= s2_2 + s2_3;
        s3_2 <= s2_4 + s2_5;
        s3_3 <= s2_6 + s2_7;
        s3_4 <= s2_8 + s2_9;
        s3_5 <= s2_10 + s2_11;
        s3_6 <= s2_12 + s2_13;
        s3_7 <= s2_14 + s2_15;

        valid_s3 <= valid_s2;
    end
end


/* ============================================================
   STAGE 4 : 8 -> 4
   ============================================================ */

reg [11:0] s4_0;
reg [11:0] s4_1;
reg [11:0] s4_2;
reg [11:0] s4_3;

reg valid_s4;

always @(posedge clka) begin
    if (rst) begin
        s4_0 <= 12'd0;
        s4_1 <= 12'd0;
        s4_2 <= 12'd0;
        s4_3 <= 12'd0;
        valid_s4 <= 1'b0;
    end
    else begin
        s4_0 <= s3_0 + s3_1;
        s4_1 <= s3_2 + s3_3;
        s4_2 <= s3_4 + s3_5;
        s4_3 <= s3_6 + s3_7;

        valid_s4 <= valid_s3;
    end
end


/* ============================================================
   STAGE 5 : 4 -> 2
   ============================================================ */

reg [12:0] s5_0;
reg [12:0] s5_1;

reg valid_s5;

always @(posedge clka) begin
    if (rst) begin
        s5_0 <= 13'd0;
        s5_1 <= 13'd0;
        valid_s5 <= 1'b0;
    end
    else begin
        s5_0 <= s4_0 + s4_1;
        s5_1 <= s4_2 + s4_3;

        valid_s5 <= valid_s4;
    end
end


/* ============================================================
   STAGE 6 : 2 -> 1
   FINAL SAD
   ============================================================ */

always @(posedge clka) begin
    if (rst) begin
        sad_out <= 14'd0;
        valid_out <= 1'b0;
    end
    else begin
        sad_out <= s5_0 + s5_1;
        valid_out <= valid_s5;
    end
end

endmodule