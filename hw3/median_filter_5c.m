function output_img = median_filter_5c( input_img )
    [rows, cols] = size(input_img);
    output_img = zeros(rows, cols);
    arr = zeros(5);
    for i = 2:rows-1
        for j = 2:cols-1
            arr = [input_img(i,j), input_img(i-1,j), input_img(i,j-1), input_img(i+1,j), input_img(i,j+1)];
            output_img(i, j) = median(arr);
        end
    end

end

