function [ x, y ] = filters( original, noisy )
x = [0 2 3 4 5 9 12 16 20 25 49];
y = zeros(1, 11);
y(1) = img_mse(original, noisy);

filtered_1 = medfilt2(noisy, [1 2]);
y(2) = img_mse(original, filtered_1);

filtered_2 = medfilt2(noisy, [1 3]);
y(3) = img_mse(original, filtered_2);

filtered_3= medfilt2(noisy, [2 2]);
y(4) = img_mse(original, filtered_3);

filtered_4 = uint8(median_filter_5c(noisy));
y(5) = img_mse(original, filtered_4);

filtered_5 = medfilt2(noisy, [3 3]);
y(6) = img_mse(original, filtered_5);

filtered_6 = medfilt2(noisy, [3 4]);
y(7) = img_mse(original, filtered_6);

filtered_7 = medfilt2(noisy, [4 4]);
y(8) = img_mse(original, filtered_7);

filtered_8 = medfilt2(noisy, [4 5]);
y(9) = img_mse(original, filtered_8);

filtered_9 = medfilt2(noisy, [5 5]);
y(10) = img_mse(original, filtered_9);

filtered_10 = medfilt2(noisy, [7 7]);
y(11) = img_mse(original, filtered_10);

figure;
subplot(221)
imshow(filtered_1);
title('image after 1*2 median filter')
subplot(222)
imshow(filtered_2);
title('image after 1*3 median filter')
subplot(223)
imshow(filtered_3);
title('image after 2*2 median filter')
subplot(224)
imshow(filtered_4);
title('image after cross shaped filter')

figure;
subplot(221)
imshow(filtered_5);
title('image after 3*3 median filter')
subplot(222)
imshow(filtered_6);
title('image after 3*4 median filter')
subplot(223)
imshow(filtered_7);
title('image after 4*4 median filter')
subplot(224)
imshow(filtered_8);
title('image after 4*5 median filter')

figure;
subplot(211)
imshow(filtered_9);
title('image after 5*5 median filter')
subplot(212)
imshow(filtered_10);
title('image after 7*7 median filter')
end

