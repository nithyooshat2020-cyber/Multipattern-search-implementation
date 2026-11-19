clc
clear
%a = imread('bus1.bmp');
a = imread('flower1.bmp');
%b = imread('bus2.bmp');
b = imread('flower2.bmp');
%a1 = rgb2gray(a);
a1 = rgb2gray(a);
%b1 = rgb2gray(b);
b1 = rgb2gray(b);
%img1 = double(a1);
img1 = double(a1);
%img2 = double(b1);
img2 = double(b1);
% figure;
% imshow(a)
% 
% figure;
% imshow(b)
%reconstructed_img = img1;
[r1, c1] = size(img1);
[r2, c2] = size(img2);
mbsize = 16;
search_area = 32;
croppedimgx = img1(51:238,51:302,:);
croppedimg1 = croppedimgx;
size(croppedimg1);
%size(croppedimg1);
%imshow(croppedimg1)
croppedimgy = img2(51:238,51:302,:);
croppedimg2 = croppedimgy;
size(croppedimg2);
%imshow(croppedimg2)
sad = 0;
for i = 1:188
    for j = 1:252
        diff = abs(double(croppedimg1(i,j)-croppedimg2(i,j)));
        sad = sad+diff;
    end
end
Im = sad/(252*188)
block_data_matrix = [];
candidateBlockMatrix = [];
calculated_blocks = [];
allminvlues = [];
minsuum_blocks = [];
search_area_coordinates = [];
diamond_pattern = [0 0; -1 0; 1 0; 0 1; 0 -1];
diamondHex_pattern = [0 0; -1 0; 1 0; 0 1; 0 -1; -2 -1; -2 1; 0 2; 2 1; 2 -1; 0 -2];
dimondSqrOct_pattern = [0 0; -1 0; 1 0; 0 1; 0 -1;-3 -3; -3 3; 3 3; 3 -3; -5 -2; -5 2; -2 5; 2 5; 5 2; 5 -2; 2 -5; -2 -5];
SdSqrLd_pattern = [0 0; -1 0; 1 0; 0 1; 0 -1;-3 -3; -3 3; 3 3; 3 -3; -7 -0; -3 4; 0 7; 3 4 ; 7 0; 3 -4; 0 -7; -3 -4];
if Im<5
     
    for i = 1:mbsize:r1
    for j = 1:mbsize:c1
        current_block = img1(i:i+mbsize-1, j:j+mbsize-1);
        [m,n] = size(current_block);
        cu_x = m-mbsize+i;
        cu_y = n-mbsize+j;
        current_blockcell{i,j} = current_block;
        search_start_i = max(1, i - search_area);
        search_end_i = min(r2, i + search_area + mbsize - 1)
        search_start_j = max(1, j - search_area);
        search_end_j = min(c2, j + search_area + mbsize - 1)
        
        d = i-search_start_i+1
       e = j-search_start_j+1
       search_area_coordinates = [search_area_coordinates;i j search_start_i search_start_j d e];
        centx = i-search_start_i+1
        centy = j-search_start_j+1
        ref_blocks = img2(search_start_i:search_end_i, search_start_j:search_end_j);
        reblocks_cell{i,j} = ref_blocks;
        matrix1 = [size(ref_blocks)];
        x = [search_start_i search_end_i];
        y = [search_start_j search_end_j];
        x1 = size(ref_blocks, 1);
        y1 = size(ref_blocks, 2);
        block_data_matrix = [block_data_matrix; x1 y1];
        candidateBlockMatrix = [candidateBlockMatrix; search_start_i search_start_j; search_end_i search_end_j];
        % d = search_end_i-search_area+1;
        % e = search_end_j - search_area+1;
       
        minsum = inf;
        sum_values = [];
        prev_c = centx;
        prev_d = centy;
        reject_list = [];
        result_matrix = [];
        % for pattern_idx = 1:length(patterns)
        %     current_pattern = patterns{pattern_idx};
            for m = 1:x1
                for n = 1:y1
                    new_matrix1 = [];
                    for k = 1:size(diamond_pattern, 1)
                        new_x = centx + diamond_pattern(k, 1);
                        new_y = centy + diamond_pattern(k, 2);
                        is_in_reject_list = false;
                        for idx = 1:size(reject_list, 1)
                            if reject_list(idx, 1) == new_x && reject_list(idx, 2) == new_y
                                is_in_reject_list = true;
                                break;
                            end
                        end
                        reject_list = [reject_list; new_x new_y];
                        if is_in_reject_list == false && new_x >= 1 && new_x + mbsize - 1 <= x1 && new_y >= 1 && new_y + mbsize - 1 <= y1
                            
                                new_matrix = ref_blocks(new_x:new_x+mbsize-1, new_y:new_y+mbsize-1);
                                diff_matrix = current_block - new_matrix;
                                absmatrix = abs(diff_matrix);
                                summatrix= sum(sum(absmatrix));
                            % end
                            if size(new_matrix1, 1) == 0
                                new_matrix1 = [minsum centx centy];
                            end
                            
                            new_matrix1 = [new_matrix1; summatrix new_x new_y];
                           
                        end 
                    end
                    if size(new_matrix1, 2) >= 1
                        minsum_candidate = min(new_matrix1(:, 1))
                        minsuum_blocks = [minsuum_blocks;minsum_candidate];
                        if minsum_candidate < minsum
                            minsum = minsum_candidate;
                            minrows = new_matrix1(:, 1) == minsum;
                            ver_x = new_matrix1(minrows, 2);
                            ver_y = new_matrix1(minrows, 3);
                            center_vertix = [ver_x ver_y];
                             [rowcount1,~] = size(ver_x);
                             [rowcount2,~] = size(ver_x);
                            centx = ver_x(1,:);
                            centy = ver_y(1,:);
                            % 
                            % if size(ver_x)>=2 && size(ver_y)>=2
                            %     centx = ver_x(rowcount1,:);
                            %     centy = ver_y(rowcount2,:);
                            % end
                            % 
                            mv_xlocation = search_start_i+centx-1;
                            mv_ylocation = search_start_j+centy-1;
                            % mv_x = centx-cu_x;
                            % mv_y = centy-cu_y;
                            mv_x = i-mv_xlocation;
                            mv_y = j-mv_ylocation;
                            sum_values = [sum_values; minsum centx centy];
                        end
                    end
                    if centx == prev_c && centy == prev_d || centx < 1 || centy < 1
                        break;
                    end
                    prev_c = centx;
                    prev_d = centy;
                end
                if centx == prev_c && centy == prev_d || centx < 1 || centy < 1
                    break;
                end
            end
     
        allminvlues = [allminvlues; minsum centx centy d e mv_x mv_y];
        disp('next iteration');
        disp('diamond pattern');
    end
    end
end
if Im>5 &&Im<=10
    for i = 1:mbsize:r1
    for j = 1:mbsize:c1
        current_block = img1(i:i+mbsize-1, j:j+mbsize-1);
        [m,n] = size(current_block);
        cu_x = m-mbsize+i;
        cu_y = n-mbsize+j;
        current_blockcell{i,j} = current_block;
        search_start_i = max(1, i - search_area);
        search_end_i = min(r2, i + search_area + mbsize - 1)
        search_start_j = max(1, j - search_area);
        search_end_j = min(c2, j + search_area + mbsize - 1)
        
        d = i-search_start_i+1
       e = j-search_start_j+1
       search_area_coordinates = [search_area_coordinates;i j search_start_i search_start_j d e];
        centx = i-search_start_i+1
        centy = j-search_start_j+1
        ref_blocks = img2(search_start_i:search_end_i, search_start_j:search_end_j);
        reblocks_cell{i,j} = ref_blocks;
        matrix1 = [size(ref_blocks)];
        x = [search_start_i search_end_i];
        y = [search_start_j search_end_j];
        x1 = size(ref_blocks, 1);
        y1 = size(ref_blocks, 2);
        block_data_matrix = [block_data_matrix; x1 y1];
        candidateBlockMatrix = [candidateBlockMatrix; search_start_i search_start_j; search_end_i search_end_j];
        % d = search_end_i-search_area+1;
        % e = search_end_j - search_area+1;
       
        minsum = inf;
        sum_values = [];
        prev_c = centx;
        prev_d = centy;
        reject_list = [];
        result_matrix = [];
        % for pattern_idx = 1:length(patterns)
        %     current_pattern = patterns{pattern_idx};
            for m = 1:x1
                for n = 1:y1
                    new_matrix1 = [];
                    for k = 1:size(diamondHex_pattern, 1)
                        new_x = centx + diamondHex_pattern(k, 1);
                        new_y = centy + diamondHex_pattern(k, 2);
                        is_in_reject_list = false;
                        for idx = 1:size(reject_list, 1)
                            if reject_list(idx, 1) == new_x && reject_list(idx, 2) == new_y
                                is_in_reject_list = true;
                                break;
                            end
                        end
                        reject_list = [reject_list; new_x new_y];
                        if is_in_reject_list == false && new_x >= 1 && new_x + mbsize - 1 <= x1 && new_y >= 1 && new_y + mbsize - 1 <= y1
                            
                                new_matrix = ref_blocks(new_x:new_x+mbsize-1, new_y:new_y+mbsize-1);
                                diff_matrix = current_block - new_matrix;
                                absmatrix = abs(diff_matrix);
                                summatrix= sum(sum(absmatrix));
                            % end
                            if size(new_matrix1, 1) == 0
                                new_matrix1 = [minsum centx centy];
                            end
                            
                            new_matrix1 = [new_matrix1; summatrix new_x new_y];
                           
                        end 
                    end
                    if size(new_matrix1, 2) >= 1
                        minsum_candidate = min(new_matrix1(:, 1))
                        minsuum_blocks = [minsuum_blocks;minsum_candidate];
                        if minsum_candidate < minsum
                            minsum = minsum_candidate;
                            minrows = new_matrix1(:, 1) == minsum;
                            ver_x = new_matrix1(minrows, 2);
                            ver_y = new_matrix1(minrows, 3);
                            center_vertix = [ver_x ver_y];
                             [rowcount1,~] = size(ver_x);
                             [rowcount2,~] = size(ver_x);
                            centx = ver_x(1,:);
                            centy = ver_y(1,:);
                            % 
                            % if size(ver_x)>=2 && size(ver_y)>=2
                            %     centx = ver_x(rowcount1,:);
                            %     centy = ver_y(rowcount2,:);
                            % end
                            % 
                            mv_xlocation = search_start_i+centx-1;
                            mv_ylocation = search_start_j+centy-1;
                            % mv_x = centx-cu_x;
                            % mv_y = centy-cu_y;
                            mv_x = i-mv_xlocation;
                            mv_y = j-mv_ylocation;
                            sum_values = [sum_values; minsum centx centy];
                        end
                    end
                    if centx == prev_c && centy == prev_d || centx < 1 || centy < 1
                        break;
                    end
                    prev_c = centx;
                    prev_d = centy;
                end
                if centx == prev_c && centy == prev_d || centx < 1 || centy < 1
                    break;
                end
            end
     
        allminvlues = [allminvlues; minsum centx centy d e mv_x mv_y];
        disp('next iteration');
         disp('diamond and hexagon pattern')
    end
    end
end
if Im>10 && Im<=15
    for i = 1:mbsize:r1
    for j = 1:mbsize:c1
        current_block = img1(i:i+mbsize-1, j:j+mbsize-1);
        [m,n] = size(current_block);
        cu_x = m-mbsize+i;
        cu_y = n-mbsize+j;
        current_blockcell{i,j} = current_block;
        search_start_i = max(1, i - search_area);
        search_end_i = min(r2, i + search_area + mbsize - 1)
        search_start_j = max(1, j - search_area);
        search_end_j = min(c2, j + search_area + mbsize - 1)
        
        d = i-search_start_i+1
       e = j-search_start_j+1
       search_area_coordinates = [search_area_coordinates;i j search_start_i search_start_j d e];
        centx = i-search_start_i+1
        centy = j-search_start_j+1
        ref_blocks = img2(search_start_i:search_end_i, search_start_j:search_end_j);
        reblocks_cell{i,j} = ref_blocks;
        matrix1 = [size(ref_blocks)];
        x = [search_start_i search_end_i];
        y = [search_start_j search_end_j];
        x1 = size(ref_blocks, 1);
        y1 = size(ref_blocks, 2);
        block_data_matrix = [block_data_matrix; x1 y1];
        candidateBlockMatrix = [candidateBlockMatrix; search_start_i search_start_j; search_end_i search_end_j];
        % d = search_end_i-search_area+1;
        % e = search_end_j - search_area+1;
       
        minsum = inf;
        sum_values = [];
        prev_c = centx;
        prev_d = centy;
        reject_list = [];
        result_matrix = [];
        % for pattern_idx = 1:length(patterns)
        %     current_pattern = patterns{pattern_idx};
            for m = 1:x1
                for n = 1:y1
                    new_matrix1 = [];
                    for k = 1:size(dimondSqrOct_pattern, 1)
                        new_x = centx + dimondSqrOct_pattern(k, 1);
                        new_y = centy + dimondSqrOct_pattern(k, 2);
                       a = imread('coastguard1.bmp');
b = imread('coastguard7.bmp');
a1 = rgb2gray(a);
b1 = rgb2gray(b);
img1 = double(a1);
img2 = double(b1); is_in_reject_list = false;
                        for idx = 1:size(reject_list, 1)
                            if reject_list(idx, 1) == new_x && reject_list(idx, 2) == new_y
                                is_in_reject_list = true;
                                break;
                            end
                        end
                        reject_list = [reject_list; new_x new_y];
                        if is_in_reject_list == false && new_x >= 1 && new_x + mbsize - 1 <= x1 && new_y >= 1 && new_y + mbsize - 1 <= y1
                            
                                new_matrix = ref_blocks(new_x:new_x+mbsize-1, new_y:new_y+mbsize-1);
                                diff_matrix = current_block - new_matrix;
                                absmatrix = abs(diff_matrix);
                                summatrix= sum(sum(absmatrix));
                            % end
                            if size(new_matrix1, 1) == 0
                                new_matrix1 = [minsum centx centy];
                            end
                            
                            new_matrix1 = [new_matrix1; summatrix new_x new_y];
                           
                        end 
                    end
                    if size(new_matrix1, 2) >= 1
                        minsum_candidate = min(new_matrix1(:, 1))
                        minsuum_blocks = [minsuum_blocks;minsum_candidate];
                        if minsum_candidate < minsum
                            minsum = minsum_candidate;
                            minrows = new_matrix1(:, 1) == minsum;
                            ver_x = new_matrix1(minrows, 2);
                            ver_y = new_matrix1(minrows, 3);
                            center_vertix = [ver_x ver_y];
                             [rowcount1,~] = size(ver_x);
                             [rowcount2,~] = size(ver_x);
                            centx = ver_x(1,:);
                            centy = ver_y(1,:);
                            % 
                            % if size(ver_x)>=2 && size(ver_y)>=2
                            %     centx = ver_x(rowcount1,:);
                            %     centy = ver_y(rowcount2,:);
                            % end
                            % 