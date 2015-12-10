function [ img ] = merge( file1, file2, ncol )
    left = imread(file1);
    right = imread(file2);
    [a1, b1, c1] = size(left);
    [a2, b2, c2] = size(right);
    img(1:a1, 1:b1) = left(1:a1, 1:b1);
    img(1:a2, b1+1:b1+b2-ncol) = right(1:a2, 1+ncol:b2);
end

