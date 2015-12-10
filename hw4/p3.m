clear;clc;
%% i
letters = imread('D:\ucsd\ece253\hw4\Letters.jpg');
letters_tem = imread('D:\ucsd\ece253\hw4\LettersTemplate.jpg');
[m, n] = size(letters);
[m2, n2] = size(letters_tem);

filtered_spa = conv2(double(letters), double(flip(flip(letters_tem, 1), 2)), 'same');
maxPixelValue = max(max(filtered_spa)); 
minPixelValue = min(min(filtered_spa)); 
filtered_spa = ((filtered_spa + minPixelValue)/maxPixelValue);

dft_letters = fft2(letters, m+m2-1, n+n2-1);
dft_letter_tem = fft2(letters_tem, m+m2-1, n+n2-1);

dft_filtered_fre = dft_letters .* flip(flip(dft_letter_tem,1),2);
filtered_fre = ifft2(dft_filtered_fre);
maxPixelValue = max(max(filtered_fre)); 
minPixelValue = min(min(filtered_fre)); 
filtered_fre = circshift(((filtered_fre + minPixelValue)/maxPixelValue),[20, 20]);

figure;subplot(211);imshow(filtered_spa);colorbar;subplot(212);imshow(filtered_fre(1:m, 1:n));colorbar;

%% ii
clear;clc;
letters = rgb2gray(imread('D:\ucsd\ece253\hw4\StopSign.jpg'));
letters_tem = rgb2gray(imread('D:\ucsd\ece253\hw4\StopSignTemplate.jpg'));
[m, n] = size(letters);
[m2, n2] = size(letters_tem);

filtered_spa = conv2(double(letters), double(flip(flip(letters_tem, 1), 2)), 'same');
maxPixelValue = max(max(filtered_spa)); 
minPixelValue = min(min(filtered_spa)); 
filtered_spa = ((filtered_spa + minPixelValue)/maxPixelValue);

dft_letters = fft2(letters, m+m2-1, n+n2-1);
dft_letter_tem = fft2(letters_tem, m+m2-1, n+n2-1);

dft_filtered_fre = dft_letters .* flip(flip(dft_letter_tem,1),2);
filtered_fre = ifft2(dft_filtered_fre);
maxPixelValue = max(max(filtered_fre)); 
minPixelValue = min(min(filtered_fre)); 
filtered_fre = circshift(((filtered_fre + minPixelValue)/maxPixelValue), [20, 45]);

figure;subplot(211);imshow(filtered_spa);colorbar;subplot(212);imshow(filtered_fre(1:m, 1:n));colorbar;

%% iii
img = rgb2gray(imread('D:\ucsd\ece253\hw4\StopSign.jpg'));
template = rgb2gray(imread('D:\ucsd\ece253\hw4\StopSignTemplate.jpg'));

c = normxcorr2(template, img);
figure
imshow(c,[]);colorbar;

[ypeak, xpeak] = find(c==max(c(:)));
yoffSet = ypeak-size(template,1);
xoffSet = xpeak-size(template,2);
hFig = figure;
hAx  = axes;
imshow(img,'Parent', hAx);
imrect(hAx, [xoffSet, yoffSet, size(template,2), size(template,1)]);
