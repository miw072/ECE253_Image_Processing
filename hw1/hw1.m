%% Problem 1: MATLAB basics

% i: Input A and B
A = [3 9 5 1; 4 25 4 3; 63 12 23 9; 6 23 77 0; 12 8 5 1];
B = [0 1 0 1; 0 1  1 1; 0 0 0 1; 1 1 0 1; 0 1 0 0];

% ii: Point-wise multiply A with B and set it to C.
C = A.*B;

% iii: Calculate the inner product of 2nd row and 5th row of C.
product1 = C(2, :) .* C(5, :);

% iv: Find the minimum and maximum values and their corresponding row and column indices in Matrix C
maxValue = max(C(:));
[rowIndex_max, colIndex_max] = find(C == maxValue);
minValue = min(C(:));
[rowIndex_min, colIndex_min] = find(C == minValue);
%% Problem 2: Simple image manipulation
% i: Download any color image from the Internet with a spatial resolution of no more than (720 X 480). Read this image into MATLAB. Call this image A.
A = imread('Surface-Book.jpg');

% ii: Transform the color image to grey-scale. Verify the values are between 0 and 255. If not, please normalize your image from 0 to 255. Call this image B.
B = rgb2gray(A);

% iii: Add 20 to each value of image B. Set all pixel values greater than 255 to 255. Call this image C
C = imadd(B, 20);

% iv: Flip image B along both the horizontal and vertical axis. Call this image D.
D1 = flip(B, 2); % horizontal
D = flip(D1, 1); % vertical

% v: Calculate the median of all values in image B. Next, threshold image B by the median value
% you just calculated i.e. set all values greater than median to 1 and set all values less than or
% equal to the median to 0. Name this binary image E.

medianB = median(B(:));
E = zeros(size(B,1), size(B,2));
for x = 1:size(B, 2)
    for y = 1:size(B,1)
        if B(y, x) > medianB
            E(y,x) = 1;
        else
            E(y,x) = 0;
        end
    end
end

figure(1)
subplot(5, 1, 1)
imshow(A)
subplot(5, 1, 2)
imshow(B)
subplot(5, 1, 3)
imshow(C)
subplot(5, 1, 4)
imshow(D)
subplot(5, 1, 5)
imshow(E)

%% Problem 3
img = merge('D:\ucsd\ece253\laptop_left.png', 'D:\ucsd\ece253\laptop_right.png', 0);
figure(1)
imshow(img);
img = merge('D:\ucsd\ece253\laptop_left.png', 'D:\ucsd\ece253\laptop_right.png', 15);
figure(2)
imshow(img);


