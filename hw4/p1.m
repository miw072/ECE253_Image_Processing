clear;clc;
%% i
horizlow = imread('D:\ucsd\ece253\hw4\FreqHorizLow.png');
horizmed = imread('D:\ucsd\ece253\hw4\FreqHorizMed.png');
horizhigh = imread('D:\ucsd\ece253\hw4\FreqHorizHigh.png');
vertmed = imread('D:\ucsd\ece253\hw4\FreqVertMed.png');
angle1 = imread('D:\ucsd\ece253\hw4\FreqAngle1.png');
angle2 = imread('D:\ucsd\ece253\hw4\FreqAngle2.png');
angle3 = imread('D:\ucsd\ece253\hw4\FreqAngle3.png');

dft_horizlow = fftshift(fft2(horizlow, 512, 512));
dft_horizmed = fftshift(fft2(horizmed, 512, 512));
dft_horizhigh = fftshift(fft2(horizhigh, 512, 512));
dft_vertmed = fftshift(fft2(vertmed, 512, 512));
dft_angle1 = fftshift(fft2(angle1, 512, 512));
dft_angle2 = fftshift(fft2(angle2, 512, 512));
dft_angle3 = fftshift(fft2(angle3, 512, 512));

figure;subplot(121);imshow(horizlow(:,:,[1 1 1]));subplot(122);imagesc(abs(dft_horizlow));colorbar;title('FreqHorizLow.png');
figure;subplot(121);imshow(horizmed(:,:,[1 1 1]));subplot(122);imagesc(abs(dft_horizmed));colorbar;title('FreqHorizMed.png');
figure;subplot(121);imshow(horizhigh(:,:,[1 1 1]));subplot(122);imagesc(abs(dft_horizhigh));colorbar;title('FreqHorizHigh.png');
figure;subplot(121);imshow(vertmed(:,:,[1 1 1]));subplot(122);imagesc(abs(dft_vertmed));colorbar;title('FreqVertMed.png');
figure;subplot(121);imshow(angle1(:,:,[1 1 1]));subplot(122);imagesc(abs(dft_angle1));colorbar;title('FreqAngle1.png');
figure;subplot(121);imshow(angle2(:,:,[1 1 1]));subplot(122);imagesc(abs(dft_angle2));colorbar;title('FreqAngle2.png');
figure;subplot(121);imshow(angle3(:,:,[1 1 1]));subplot(122);imagesc(abs(dft_angle3));colorbar;title('FreqAngle3.png');

%% ii
checkboard = imread('D:\ucsd\ece253\hw4\FreqCheckerboard.png');
dft_newimage = fftshift(fft2(checkboard, 512, 512));
figure;subplot(121);imshow(checkboard(:,:,[1 1 1]));colorbar;subplot(122);imagesc(abs(dft_newimage));colorbar;title('FreqCheckerboard.png');

newimage = uint8(double(horizmed) + double(vertmed));
dft_newimage = fftshift(fft2(newimage, 512, 512));
figure;subplot(121);imshow(newimage(:,:,[1 1 1]));colorbar;subplot(122);imagesc(abs(dft_newimage));colorbar;title('New Image');

%% iii
maskA = (1/16)*[1 2 1; 2 4 2; 1 2 1];
weight = 10;
[a,b] = size(maskA);
maskB = zeros( size(maskA) );
maskB(ceil(a/2), ceil(b/2)) = 1;
maskC = maskB - maskA;
maskD = maskB + weight * maskC;

dft_maskA = fftshift(fft2(maskA, 512, 512));
figure;imagesc(abs(dft_maskA));colorbar;title('maskA, low-pass filter');
dft_maskB = fftshift(fft2(maskB, 512, 512));
figure;imagesc(abs(dft_maskB));colorbar;title('maskB, identity filter');
dft_maskC = fftshift(fft2(maskC, 512, 512));
figure;imagesc(abs(dft_maskC));colorbar;title('maskC, high-pass filter');
dft_maskD = fftshift(fft2(maskD, 512, 512));
figure;imagesc(abs(dft_maskD));colorbar;title('maskD, high-boost filter');
