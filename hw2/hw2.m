clear all
clc
% %% Problem 1
% filename = 'D:\ucsd\ece253\hw2\fog.jpg';
% eq_img = equalization(filename);
% 
% %% Problem 2
% filename2 = 'D:\ucsd\ece253\hw2\peppers.png';
% samp_quan_img = samp_quan(filename2);

%% Problem 3
% i & ii
% lena
lena = imread('D:\ucsd\ece253\hw2\lena512.tif');
[mse_lena_uni, mse_lena_lloyds] = mse(lena);
x = 1:7;
figure(1);
subplot(2,1,1);
plot(x, mse_lena_uni);
title('MSE with uniform quantizer for lena512.tif');
subplot(2,1,2);
plot(x, mse_lena_lloyds);
title('MSE with Lloyd-Max quantizer quantizer for lena512.tif');
%diver
diver = imread('D:\ucsd\ece253\hw2\diver.tif');
[mse_diver_uni, mse_diver_lloyds] = mse(diver);
x = 1:7;
figure(2);
subplot(2,1,1);
plot(x, mse_diver_uni);
title('MSE with uniform quantizer for diver.tif');
subplot(2,1,2);
plot(x, mse_diver_lloyds);
title('MSE with Lloyd-Max quantizer quantizer for diver.tif');

% iii
lena_equal = histeq(lena, 256);
diver_equal = histeq(diver, 256);
figure; imshow(lena_equal);
figure; imshow(diver_equal);
[mse_lena_equni, mse_lena_eqll] = mse(lena_equal);
[mse_diver_equni, mse_diver_eqll] = mse(diver_equal);
figure(3);
subplot(2,1,1);
plot(x, mse_lena_equni);
title('MSE with uniform quantizer for lena512.tif after equalization');
subplot(2,1,2);
plot(x, mse_lena_eqll);
title('MSE with Lloyd-Max quantizer quantizer for lena512.tif after equalization');

figure(4);
subplot(2,1,1);
plot(x, mse_diver_equni);
title('MSE with uniform quantizer for diver.tif after equalization');
subplot(2,1,2);
plot(x, mse_diver_eqll);
title('MSE with Lloyd-Max quantizer quantizer for diver.tif after equalization');



