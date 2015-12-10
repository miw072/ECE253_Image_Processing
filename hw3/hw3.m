clear;clc;
%% P1
helmet_ori = imread('D:\ucsd\ece253\hw3\Helmet.jpg');
helmet = rgb2gray(helmet_ori);
noise = rand(size(helmet));
noisy_image = uint8(double(helmet) .* (noise > 0.2) + 255 .* (noise < 0.1)); % salt and pepper noise
figure;
subplot(211);
imshow(helmet);
title('original image');
subplot(212);
imshow(noisy_image);
title('noisy image');

% median filter
[x, y] = filters(helmet, noisy_image);
figure;
plot(x, y, 'o');
title('MSE plot with median filter');

% mean filter
[x1, y1] = mean_filters(helmet, noisy_image);
figure;
plot(x1, y1, 'o');
title('MSE plot with mean filter');

%% P2
image_synth = ones(128,1)*[64*ones(1,32) (64:4:192) 192*ones(1,32) 64*ones(1,32)];
m1 = fspecial('average', 3);
m2 = fspecial('average', 5);
m3 = fspecial('average', 7);
m4= fspecial('gaussian', 3, 0.5);
m5= 1/12*[1,1,1; 1,4,1; 1,1,1];
weight = [0.1, 1, 10];
% imshow(image_synth, [min(min(image_synth)), max(max(image_synth))]);

im_out_1_1 = uint8(unsharp(image_synth, m1, weight(1)));
im_out_1_2 = unsharp(image_synth, m1, weight(2));
im_out_2_2 = unsharp(image_synth, m2, weight(2));
im_out_3_2 = unsharp(image_synth, m3, weight(2));
im_out_4_2 = unsharp(image_synth, m4, weight(2));
im_out_5_2 = unsharp(image_synth, m5, weight(2));
im_out_1_3 = unsharp(image_synth, m1, weight(3));

figure;
subplot(311); imshow(im_out_1_2, [min(min(im_out_1_2)), max(max(im_out_1_2))]);
subplot(312); imshow(im_out_2_2, [min(min(im_out_2_2)), max(max(im_out_2_2))]);
subplot(313); imshow(im_out_3_2, [min(min(im_out_3_2)), max(max(im_out_3_2))]);
figure;
plot(image_synth(64, :), 'c');hold on
plot(im_out_1_2(64, :), 'r');hold on
plot(im_out_2_2(64, :), 'b');hold on
plot(im_out_3_2(64, :), 'y');
legend('original image', 'mean filter with 3*3', 'mean filter with 5*5', 'mean filter with 7*7');


figure;
subplot(311); imshow(im_out_1_2, [min(min(im_out_1_2)), max(max(im_out_1_2))]);
subplot(312); imshow(im_out_4_2, [min(min(im_out_4_2)), max(max(im_out_4_2))]);
subplot(313); imshow(im_out_5_2, [min(min(im_out_5_2)), max(max(im_out_5_2))]);
figure;
plot(image_synth(64, :), 'c');hold on
plot(im_out_1_2(64, :), 'r');hold on;
plot(im_out_4_2(64, :), 'b');hold on;
plot(im_out_5_2(64, :), 'y');
legend('original image', 'mean filter with 3*3', 'gaussian filter with 3*3', 'weighted mean filter with 3*3');

figure;
subplot(311); imshow(im_out_1_1, [min(min(im_out_1_1)), max(max(im_out_1_1))]);
subplot(312); imshow(im_out_1_2, [min(min(im_out_1_2)), max(max(im_out_1_2))]);
subplot(313); imshow(im_out_1_3, [min(min(im_out_1_3)), max(max(im_out_1_3))]);
figure;
plot(image_synth(64, :), 'c');hold on
plot(im_out_1_1(64, :), 'r');hold on;
plot(im_out_1_2(64, :), 'b');hold on;
plot(im_out_1_3(64, :), 'y');
legend('original image', 'mean filter with weight 0.1', 'mean filter with weight 1', 'mean filter with weight 10');

xray_ori = imread('D:\ucsd\ece253\hw3\xray.tif');
me = fspecial('gaussian', 5, 1);
xray_enh = uint8(unsharp(xray_ori, m1, 25));
figure;
imshow(xray_ori);
figure;
imshow(xray_enh);

%% P3
eyechart_ori = imread('D:\ucsd\ece253\hw3\eyechart.tif');
binary_ori = 1 - round(double(eyechart_ori)/255);
eyechart_1 = imread('D:\ucsd\ece253\hw3\eyechart_1.tif');
binary_1 = 1 - round(double(eyechart_1)/255);
eyechart_5 = imread('D:\ucsd\ece253\hw3\eyechart_5.tif');
binary_5 = 1 - round(double(eyechart_5)/255);
eyechart_20 = imread('D:\ucsd\ece253\hw3\eyechart_20.tif');
binary_20 = 1 - round(double(eyechart_20)/255);

clean_1 = ipc(binary_1);
clean_5 = ipc(binary_5);
clean_20 = ipc(binary_20);

figure;
subplot(121);
imshow(binary_1);
subplot(122);
imshow(clean_1);
figure;
subplot(121);
imshow(binary_5);
subplot(122);
imshow(clean_5);
figure;
subplot(121);
imshow(binary_20);
subplot(122);
imshow(clean_20);

mse_before = zeros(1, 3);
mse_before(1) = img_mse(binary_ori, binary_1);
mse_before(2) = img_mse(binary_ori, binary_5);
mse_before(3) = img_mse(binary_ori, binary_20);
mse_after_ipc = zeros(1, 3);
mse_after_ipc(1) = img_mse(binary_ori, clean_1);
mse_after_ipc(2) = img_mse(binary_ori, clean_5);
mse_after_ipc(3) = img_mse(binary_ori, clean_20);

co_1 = bwmorph(bwmorph(binary_1, 'close'), 'open');
co_5 = bwmorph(bwmorph(binary_5, 'close'), 'open');
co_20 = bwmorph(bwmorph(binary_20, 'close'), 'open');
figure;
subplot(131);
imshow(co_1);
subplot(132);
imshow(co_5);
subplot(133);
imshow(co_20);
mse_after_co = zeros(1, 3);
mse_after_co(1) = img_mse(binary_ori, co_1);
mse_after_co(2) = img_mse(binary_ori, co_5);
mse_after_co(3) = img_mse(binary_ori, co_20);

oc_1 = bwmorph(bwmorph(binary_1, 'open'), 'close');
oc_5 = bwmorph(bwmorph(binary_5, 'open'), 'close');
oc_20 = bwmorph(bwmorph(binary_20, 'open'), 'close');
figure;
subplot(131);
imshow(oc_1);
subplot(132);
imshow(oc_5);
subplot(133);
imshow(oc_20);
mse_after_oc = zeros(1, 3);
mse_after_oc(1) = img_mse(binary_ori, oc_1);
mse_after_oc(2) = img_mse(binary_ori, oc_5);
mse_after_oc(3) = img_mse(binary_ori, oc_20);

