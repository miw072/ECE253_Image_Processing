function [ output_image ] = padding( input_image )
    output_image = zeros(512, 512);
    [rows, cols] = size(input_image);
    diff_rows = 512-rows;
    diff_cols = 512-cols;
    output_image(1:rows, 1:cols) = input_image(1:rows, 1:cols);
end

