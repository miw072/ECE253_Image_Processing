function img = samp_quan( filename )
img_ori = imread(filename);
figure(1);imshow(img_ori);
f = 10;
[row, col, ~] = size(img_ori);
%sample
img_new = img_ori(1:f:row, 1:f:col, :);
figure(2);imshow(img_new);

[row_sam, col_sam] = size(img_new);
img = img_new;
for i = 1: row_sam
    for j = 1:col_sam
        quan = floor(img_new(i,j)/52);
        switch quan
            case 0
                img(i, j) = 51;
            case 1
                img(i, j) = 107;
            case 2
                img(i, j) = 153;
            case 3
                img(i,j) = 204;
            case 4
                img(i,j) = 255;
        end
    end
end
figure(3);imshow(img, [0, 255]);
end

