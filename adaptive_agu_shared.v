module adaptive_agu_shared(
    center_x, center_y, pattern_select, candidate_index, row_count,
    candidate_x, candidate_y, candidate_valid, reference_address
);
input [6:0] center_x;
input [6:0] center_y;
input [2:0] pattern_select;
input [3:0] candidate_index;
input [5:0] row_count;
output reg [6:0] candidate_x;
output reg [6:0] candidate_y;
output reg candidate_valid;
output reg [6:0] reference_address;
reg [6:0] x_tmp;
reg [6:0] y_tmp;

/* pattern_select: 0=small diamond, 1=hexagon, 2=square,
   3=octagon, 4=large diamond. Coordinates are clamped to 0..64. */
always @(*) begin
    x_tmp = center_x;
    y_tmp = center_y;
    candidate_valid = 1'b1;

    case (pattern_select)
        3'd0: begin
            case (candidate_index)
                4'd0: begin x_tmp=center_x; y_tmp=center_y; end
                4'd1: begin if(center_y>0) y_tmp=center_y-7'd1; else y_tmp=7'd0; end
                4'd2: begin if(center_x>0) x_tmp=center_x-7'd1; else x_tmp=7'd0; end
                4'd3: begin if(center_x<7'd64) x_tmp=center_x+7'd1; else x_tmp=7'd64; end
                4'd4: begin if(center_y<7'd64) y_tmp=center_y+7'd1; else y_tmp=7'd64; end
                default: candidate_valid=1'b0;
            endcase
        end
        3'd1: begin
            case (candidate_index)
                4'd0: begin x_tmp=center_x; y_tmp=center_y; end
                4'd1: begin if(center_x>=7'd2) x_tmp=center_x-7'd2; else x_tmp=7'd0; end
                4'd2: begin if(center_x>0) x_tmp=center_x-7'd1; else x_tmp=7'd0; if(center_y>=7'd2) y_tmp=center_y-7'd2; else y_tmp=7'd0; end
                4'd3: begin if(center_x<7'd64) x_tmp=center_x+7'd1; else x_tmp=7'd64; if(center_y>=7'd2) y_tmp=center_y-7'd2; else y_tmp=7'd0; end
                4'd4: begin if(center_x<=7'd62) x_tmp=center_x+7'd2; else x_tmp=7'd64; end
                4'd5: begin if(center_x<7'd64) x_tmp=center_x+7'd1; else x_tmp=7'd64; if(center_y<=7'd62) y_tmp=center_y+7'd2; else y_tmp=7'd64; end
                4'd6: begin if(center_x>0) x_tmp=center_x-7'd1; else x_tmp=7'd0; if(center_y<=7'd62) y_tmp=center_y+7'd2; else y_tmp=7'd64; end
                default: candidate_valid=1'b0;
            endcase
        end
        3'd2: begin
            case (candidate_index)
                4'd0: begin x_tmp=center_x; y_tmp=center_y; end
                4'd1: begin if(center_x>=7'd4) x_tmp=center_x-7'd4; else x_tmp=7'd0; if(center_y>=7'd4) y_tmp=center_y-7'd4; else y_tmp=7'd0; end
                4'd2: begin if(center_y>=7'd4) y_tmp=center_y-7'd4; else y_tmp=7'd0; end
                4'd3: begin if(center_x<=7'd60) x_tmp=center_x+7'd4; else x_tmp=7'd64; if(center_y>=7'd4) y_tmp=center_y-7'd4; else y_tmp=7'd0; end
                4'd4: begin if(center_x>=7'd4) x_tmp=center_x-7'd4; else x_tmp=7'd0; end
                4'd5: begin if(center_x<=7'd60) x_tmp=center_x+7'd4; else x_tmp=7'd64; end
                4'd6: begin if(center_x>=7'd4) x_tmp=center_x-7'd4; else x_tmp=7'd0; if(center_y<=7'd60) y_tmp=center_y+7'd4; else y_tmp=7'd64; end
                4'd7: begin if(center_y<=7'd60) y_tmp=center_y+7'd4; else y_tmp=7'd64; end
                4'd8: begin if(center_x<=7'd60) x_tmp=center_x+7'd4; else x_tmp=7'd64; if(center_y<=7'd60) y_tmp=center_y+7'd4; else y_tmp=7'd64; end
                default: candidate_valid=1'b0;
            endcase
        end
        3'd3: begin
            case (candidate_index)
                4'd0: begin x_tmp=center_x; y_tmp=center_y; end
                4'd1: begin if(center_x>=7'd4) x_tmp=center_x-7'd4; else x_tmp=7'd0; if(center_y>=7'd4) y_tmp=center_y-7'd4; else y_tmp=7'd0; end
                4'd2: begin if(center_y>=7'd6) y_tmp=center_y-7'd6; else y_tmp=7'd0; end
                4'd3: begin if(center_x<=7'd60) x_tmp=center_x+7'd4; else x_tmp=7'd64; if(center_y>=7'd4) y_tmp=center_y-7'd4; else y_tmp=7'd0; end
                4'd4: begin if(center_x>=7'd6) x_tmp=center_x-7'd6; else x_tmp=7'd0; end
                4'd5: begin if(center_x<=7'd58) x_tmp=center_x+7'd6; else x_tmp=7'd64; end
                4'd6: begin if(center_x>=7'd4) x_tmp=center_x-7'd4; else x_tmp=7'd0; if(center_y<=7'd60) y_tmp=center_y+7'd4; else y_tmp=7'd64; end
                4'd7: begin if(center_y<=7'd58) y_tmp=center_y+7'd6; else y_tmp=7'd64; end
                4'd8: begin if(center_x<=7'd60) x_tmp=center_x+7'd4; else x_tmp=7'd64; if(center_y<=7'd60) y_tmp=center_y+7'd4; else y_tmp=7'd64; end
                default: candidate_valid=1'b0;
            endcase
        end
        3'd4: begin
            case (candidate_index)
                4'd0: begin x_tmp=center_x; y_tmp=center_y; end
                4'd1: begin if(center_y>=7'd8) y_tmp=center_y-7'd8; else y_tmp=7'd0; end
                4'd2: begin if(center_x>=7'd8) x_tmp=center_x-7'd8; else x_tmp=7'd0; end
                4'd3: begin if(center_x<=7'd56) x_tmp=center_x+7'd8; else x_tmp=7'd64; end
                4'd4: begin if(center_y<=7'd56) y_tmp=center_y+7'd8; else y_tmp=7'd64; end
                default: candidate_valid=1'b0;
            endcase
        end
        default: begin candidate_valid=1'b0; x_tmp=center_x; y_tmp=center_y; end
    endcase

    candidate_x = x_tmp;
    candidate_y = y_tmp;
    if ((x_tmp > 7'd64) || (y_tmp > 7'd64)) candidate_valid = 1'b0;
    if (candidate_valid) reference_address = y_tmp + {1'b0,row_count};
    else reference_address = 7'd0;
end
endmodule